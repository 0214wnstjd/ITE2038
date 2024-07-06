# 명세   

### 목표
**가상 수강 신청 사이트 구축**   

1. 주어진수강신청데이터를기반으로데이터베이스를생성(Back-End)
2. 데이터베이스에연결가능한사용자어플리케이션을제작(Front-End)

- Data Set을 참고하여 Table을 만들고 Data를 Database에 추가합니다
- 어디까지나 참고일 뿐이며, 자유롭게 스키마 변경 및 추가 가능

### 주어진 파일

- csv/
- mysql-connector-j-8.0.31.tar.gz

### 필요 기능

  <img src="https://prod-files-secure.s3.us-west-2.amazonaws.com/4adb7036-ca79-4b7b-ba3e-f588c52fd3e6/b2780fc6-30a1-41c1-a18d-c141eb497e79/Untitled.png" width="40%" height="40%" title="이미지1"></img><br/>
  <img src="https://prod-files-secure.s3.us-west-2.amazonaws.com/4adb7036-ca79-4b7b-ba3e-f588c52fd3e6/9adbacff-9d32-4596-b3f6-8b11778aa1f3/Untitled.png" width="40%" height="40%" title="이미지2" img><br/>
  <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/c1baabc0-d47f-4ad4-8378-af2e2a5f3d58" width="40%" height="40%" title="이미지1" alt="common"></img><br/>

### 조건
- Case 1
    - 첫 번째 relation의 attribute는 name, age
    - 두 번째 relation의 attribute는 name, salary
    - 모든 tuple은 name을 기준으로 정렬되어 있음
    - name을 기준으로 natural join 수행
    - “(name),(age),(salary)” 형태로 output 파일에 출력
  
        <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/f99cabdf-c07c-4db3-a233-d1fcea4cb8c5" width="30%" height="30%" title="이미지2" alt="case1"></img><br/>

- Case 2
    - 첫 번째 relation의 attribute는 name, age
    - 두 번째 relation의 attribute는 name, salary
    - 첫 번째 relation의 tuple은 age를 기준으로 정렬되어 있음
    - 두 번째 relation의 tuple은 salary를 기준으로 정렬되어 있음
    - name을 기준으로 natural join 수행
    - “(name),(age),(salary)” 형태로 output 파일에 출력

- Case 3
    - 첫 번째 relation의 attribute는 학생 이름과 1학기 성적
        - student_name, korean, math, english, science, social, history
    - 두 번째 relation의 attribute는 학생 이름과 2학기 성적
        - student_name, korean, math, english, science, social, history
    - 세 번째 relation의 attribute는 student_name, student_number
    - 모든 data는 무작위로 저장되어 있음
    - 각 과목에 대해서 1학기 보다 2학기 때 성적향상이 일어난 과목의 개수가 2개 이상인 학생의 이름과 학번을 “(student_name),(student_number)” 형태로 output 파일에 출력
        - 성적은 등급을 의미하므로 숫자가 작아진 것이 성적 향상을 의미
      
        <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/dbffdaf8-a811-41c2-910a-e559f88d7235" width="20%" height="20%" title="이미지3" alt="case3"></img><br/>


# Implementation

## case1:

### merge join

- case1의 경우엔 2개의 relation이 join attribute인 name을 기준으로 sorting되어 있어 open 함수를 각 파일마다 한번씩만 하면 되는(총 2000개 파일, 2000번 open) merge join을 사용하였음.     
- nested loop 와 hash join을 사용할 경우 같은 파일을 여러번 불러올 수 있기때문에 open 함수를 더 많이 호출함.  

## case2:

### hash join

- case2의 경우엔 2개의 relation이 모두 join attribute에 대해 sorting되어 있지 않아 nested_loop join 혹은 hash join으로 구현해야함.    
- nested_loop의 경우 최소를 위해 10 block씩 name_age를 100번에 나눠서 불러오고, 한번당 1000개 block의 name_salary을 open해야 하므로 100*1000 + 1000 = 101000번의 open이 필요.    
- hash join의 경우 partition시 기존 2000개의 block open과 bucket에 나눠서 쓸때 20000번의 open 필요.    
- join의 경우 각 bucket file들을 한번씩 open만 하면 되므로 2000번의 open필요.    
- 총 204000번의 open 발생하여 hash join이 좋음.    

## case3:

### hash join

- case3의 경우엔 3개의 relation이 모두 무작위로있어 nested_loop join 또는 hash join을 사용하여야함.    
- case2와 주어진 메모리 조건이 같기 때문에 case2에서 이미 봤듯이 hash join이 open을 덜 호출함.    
- case 3에선 partition시 기존 3000개 block open과 bucket에 나눠서 쓸때 30000번의 open 필요.    
- join의 경우 각 bucket file 들을 한번씩 open만 하면 되므로 3000번의 open 필요. 총 306000번의 open 발생함.   

## Trouble Shooting:

1. C++의 fstream 사용법


        open(<경로>, std::ios::<옵션>)

    - <경로>에는 절대 경로 또는 상대 경로로 써야하고, 상대 경로를 사용하였음. ex) ../bucket ~    
    - <옵션>에는 in, out, binary, app 옵션 등이 들어갈 수 있음.     

    참고: [https://psychoria.tistory.com/774](https://psychoria.tistory.com/774)

3. Hash join시 Partition

    - bucket이란걸 어떻게 구현할지 모르겠어서 bucket 디렉토리들을 만들어 줄까 하였는데 createdirectory라는 함수를 이용해야해서 그냥 파일명을 name의 앞 세글자로 구분할 수 있게 분류 하였다.   
   - 각 파일안에 들어간 record의 개수는 기존 양식에 맞춰 10개씩으로 하였다.   
   - 예를 들어 name이 abcd라면 hash function이 abc를 캐치하여 분류 해주는 알고리즘을 사용.    
   - 편의를 위해 ascii code로 분류 하였음. a→ 95 ~ j→106.   

4. Partition 후 Join

   - case 2, 3 모두 join 조건은 까다롭지 않아 해결되었다.    
   - 그러나 자꾸 결과가 예상 결과보다 적게 나와서 어떤 실수를 했나 찾아보던 중, open된 inner relation file에서 getline을 반복적으로 몇바퀴씩 할때, fstream 변수가 가리키는 파일의 위치가 이미 끝으로 가있는걸 확인했다.    
   - seekg라는 함수를 사용하여 위치를 변경해줄 수 있다고 한다.      

   참고: [https://m.blog.naver.com/kks227/220225345923](https://m.blog.naver.com/kks227/220225345923)
