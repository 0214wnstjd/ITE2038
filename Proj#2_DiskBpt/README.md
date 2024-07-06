# How to run
- Open Terminal
- `cd disk_bpt`
- `make`
- `./main`
- Input Command (`"i %d", "f %d", "d %d", "q"`)
  
# Specification

## To Do
**On-disk 형식의 B+tree 구현**   
**보조 연산(ex. Merge, Split)에 대한 overhead를 줄이기 위한 전략 구현**
- In-memory B+tree를 통해 On-disk B+tree 구조 이해
- B+tree의 동작과정
    참고 : [BplusTree](https://www.cs.usfca.edu/~galles/visualization/BPlusTree.html)

## Given File

- memory_bpt/
  - include/
    - bpt.h
  - lib/
  - src/
    - bpt.c
    - main.c
  - Makefile

## Requirements

- Split과 Merge와 같은 보조 연산은 Disk I/O를 발생시켜 성능 하락의 원인이 됨
- 이를 줄이기 위한 전략을 code로 구현
  - Delay-merge, Key-rotation 등 자유
  
## Default Environment
- **gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1)** 9.4.0
- **GNU Make** 4.2.1


# Implementation

## Design
코드 분석은 [Proj#2 Disk B+Tree 구현](https://roan-fin-633.notion.site/Proj-2-Disk-B-Tree-d73faf651a1e470a82eaea40c004edd1?pvs=4) 참고


### Strategy to reduce Overhead

1. insert_into_leaf_as를 할 때 Overhead

    - 빈공간이 있는 page가 있음에도 불구하고 split 되어 page가 새롭게 생겨 write하는 경우가 있음.
    - 이런 경우는 불필요한 disk IO를 발생시킴


    **방법**
     - split을 하기 전에 해당 key가 들어갈 페이지(leafp)의 왼쪽 페이지(neighbor)에 빈공간이 있으면 leap의 첫번째 key를 neighbor로 옮김 (redistribute함수 이용)
     - 그 후 leafp에 insert_into_leaf

    **효과** - page를 불필요하게 새롭게 생성하지 않아 overhead를 줄일 수 있음

2. delete_entry를 할 때 Overhead

    - page에 key개수가 부족하여 바로 coalesce 하면 반복적으로 split - merge가 일어나는 현상이 있어 과다한 disk IO를 발생시킴.

    **방법** - delete를 즉시 적용하지 않고 ghost record로 마크를 해놓고 주기적으로 삭제를 진행함. 

    **효과** - delete되어 coalesce나 redistribute이 일어나야하는 상황에서 삭제가 실제로 진행되기 전에 insert가 일어나 key개수가 충분해지면 overhead를 줄일 수 있음.

## Implement

f 명령 사용시 해당 key가 속해있는 page의 시작 주소를 출력하게 변경하였음

```c
position = find_leaf(input);
printf("Key: %ld, Value: %s, Position: %lld\n", input, result, position);
```

1. db_insert에서 현재 insert하려는 leafp가 꽉차도 왼쪽 page(neighbor)가 빈 공간이 있으면 redistribute하는 전략

```c
if (neighbor->num_of_keys < LEAF_MAX && leaf != hp->rpo && neighbor_index == -2)
    {
        free(leafp);
        free(parent);
        free(neighbor);
        redistribute_pages(neighbor_offset, neighbor_index, leaf, parent_offset, k_prime, k_prime_index);
        insert_into_leaf(leaf, nr);
        return 0;
    }
```

  - redistribute함수는 neighbor_index가 -2일때 nbor의 첫번째 record를 need의 끝으로 옮겨오므로 해당 부분 이용.
  - neighbor_index를 무조건 -2로 주고 nbor_off를 leaf로 주고 need_more를 neighbor_offset를 주어 leafp의 첫번째 record를 neighbor_offset의 끝으로 넣어주게 하였음.   

    조건 - neighbor가 꽉 차지 않고 (num_of_keys < LEAF_MAX), root는 무조건 split해야하므로 제외(leaf ≠ hp→rpo), leaf가 parent의 leftmost이면 제외(parent→next_offset == leaf 일때 neighbor_index의 값을 0으로 주었음)

2. delete_entry를 할 때 ghost record로 mark하는 전략

  - d 명령어가 입력될 시 해당 key와 key가 들어갈 offset을 ghost record array에 저장함.
  - insert할때 해당 페이지에 ghost record가 있다면 그 index뒤부터 한칸씩 앞으로 땡겨온 후 insert를 함.
  - find할때 해당 key가 ghost record라면 not exists로 출력.
  - ghost array가 꽉차면 ghost array에 있는 모든 key들을 db_delete함.
  - quit할때도 ghost record array db_delete 해줌.

```c
// if input is not in ghost, add into ghost
ghost[ghostCnt].key = input;
ghost[ghostCnt].loc = find_leaf(input);
ghostCnt++;
// if ghost is full, delete
if (ghostCnt == 5)
{
for (int i = 0; i < 5; i++)
{
   db_delete(ghost[i].key);
   printf("ghost key %ld is deleted\n", ghost[i].key);
}
ghostCnt = 0;
}
```

## Result
Result는 [Proj#2 Disk B+Tree 구현](https://roan-fin-633.notion.site/Proj-2-Disk-B-Tree-d73faf651a1e470a82eaea40c004edd1?pvs=4) 참고


## Trouble shooting

1. On-disk bpt에 필요한 pread와 pwrite

    참고: [https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=neakoo35&logNo=30131029083](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=neakoo35&logNo=30131029083)

2. split시 redistribute 전략  

    - 예를 들어 1\~16을 insert 한 후 51\~66을 insert하면 tree는 1\~16 (16개)을 담고있는 leaf와 51\~56 (16개)를 담고있는 key일것이다.
    - 여기서 17\~31까지 입력을 하면 leftmost leaf page는 full될것이다.
    - 그렇다면 현재 insert 32를 하면 neighbor page를 체크해야하는데 left가 없다.
    - delete의 redistribute경우 leftmost일 때만 예외적으로 우측에서 가져와 need_more을 채웠다.
    - 하지만 insert의 경우 이러한 상황에서 32를 insert할 때 우측 이웃 page에 넣을지 그냥 split해버릴지 고민을 하였지만, average 상황과는 다르게 full page의 0번째 key를 옮기는 것이 아닌 input자체를 우측 이웃에 넣어야하므로 해당 예외상황에서는 따로 구현하지 않고 leftmost일 때는 split하게 두었음.
    - 해당 상황에서도 구현을 한다면 overhead를 더 줄일 수 있을거라고 생각됨.

3. delete시 ghost record에 모아서 delete하는 전략

    참고: [https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=sqlmvp&logNo=140164866348](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=sqlmvp&logNo=140164866348)

    - 10초마다 delete를 하기보단 delete의 buffer로 사용할 key와 offset을 담을 ghost structure array를 하나 만들었고 delete 시 해당 array에 추가하게 하였음.
    - delete만 바뀌면 되는게 아니라 insert와 find에서도 ghost record와 관하여 예외처리를 해주어야 했음.
    - db_find에서 isGhost라는 변수를 사용하여 ghost가 아닌데 dupcheck이 null이 아닐경우만 중복 메시지를 출력하게 변경하였음.
    - 이러한 buffer 사용을 통해 coalesce나 redistribute 되는 횟수를 줄여 Overhead를 줄일 수 있었음.
