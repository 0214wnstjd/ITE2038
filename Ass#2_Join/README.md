# 명세   

### 목표
3가지 Join Algorithm (Nested-loop, Merge, Hash)중   
주어진 상황에 가장 적합한 Join함수를 구현 및 적용하여 output을 출력
- 가장 적합하다는 의미는 open함수를 최소로 호출함을 의미합니다
- 주어진 상황에 대해 해당 Join이 왜 가장 적합한 Join Algorithm인지 자신의 논리를 wiki에 자세히 서술하여야 합니다

### 제약 조건
- 주어진 코드는 변형 불가능
- 주어진 class, function, variable, directory는 자유롭게 활용 가능
- int형 변수이외의 type은 선언 및 사용불가
- 각 문제에 대한 Join 결과는 하나의 파일로 출력

### 주어진 파일

- buckets/
- case1/
    - name_age/
    - name_salary/
    - test1.cpp
- case2/
    - name_age/
    - name_salary/
    - test2.cpp
- case3/
    - name_grade1/
    - name_grade2/
    - name_number/
    - test3.cpp

### 공통 조건
- 하나의 relation은 1000개의 파일에 나뉘어져있습니다
- 하나의 파일에는 튜플이 10개씩 들어있습니다
- name은 unique한 attribute입니다

  <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/c1baabc0-d47f-4ad4-8378-af2e2a5f3d58" width="450px" height="300px" title="이미지1" alt="common"></img><br/>

### 조건
- Case 1
    - 첫 번째 relation의 attribute는 name, age
    - 두 번째 relation의 attribute는 name, salary
    - 모든 tuple은 name을 기준으로 정렬되어 있음
    - name을 기준으로 natural join 수행
    - “(name),(age),(salary)” 형태로 output 파일에 출력
  
    <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/f99cabdf-c07c-4db3-a233-d1fcea4cb8c5" width="450px" height="300px" title="이미지2" alt="case1"></img><br/>

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
      
    <img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/dbffdaf8-a811-41c2-910a-e559f88d7235" width="300px" height="150px" title="이미지3" alt="case3"></img><br/>


### 방법

> [http://sqlfiddle.com/](http://sqlfiddle.com/)
> 
> Select MySQL
> 
> Copy and Paste insert.sql 
> 
> Run SQL
> 
> Check Result   
