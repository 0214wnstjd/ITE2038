# How to run
- `Install IntelliJ`
- `Insatll MySQL`
- `Install MySQL Workbench`
- `Start MySQL Server`
- `Add Connection in MySQL Workbench (port: 3306)`
- `Run Proj1 2019007892 Script.sql`
- `Create project in IntelliJ with default environment`
- `Build and Run`
  
# Specification

## To Do
**가상 수강 신청 사이트 구축**   

1. 주어진 수강신청 데이터를 기반으로 데이터베이스를 생성(Back-End)
2. 데이터베이스에 연결가능한 사용자 어플리케이션을 제작(Front-End)

- Data Set을 참고하여 Table을 만들고 Data를 Database에 추가합니다
  - 어디까지나 참고일 뿐이며, 자유롭게 스키마 변경 및 추가 가능

## Given File

- csv/
- mysql-connector-j-8.0.31.tar.gz

## Requirements

<img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/dd8f21f8-fc5f-462d-ac73-554be8bb8820" width="80%" height="80%" title="이미지1"></img><br/>
<img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/e9a837a4-0088-4107-9304-2ecdc4aff4a6" width="80%" height="80%" title="이미지2"> </img><br/>
  

## Schema Example

<img src="https://github.com/0214wnstjd/ITE2038/assets/109850168/b465fab2-4ed4-4f8c-9501-80a0cedd2fc7" width="60%" height="50%" title="이미지3"></img><br/>

- **강의실(room)**   
  강의실 개수의 합과 건물의 총 강의실 개수는 같아야 함
- **건물(building)**  
  건물의 총 강의실 개수는 강의실 개수의 합과 같아야 함
- **과목(course)**
- **전공(major)**
- **성적(credits)**    
  이수 년도(year)에는 학기를 구분하지 않음
- **교강사(lecturer)**
- **학생(student)**   
  학생의 지도교수는 교강사 목록에 실제로 존재해야 함
- **수업(class)**  
  신청 수강 정원이 강의실의 수용 인원을 넘을 수 없음

## Default Environment
- **IntelliJ IDEA** 2022.2
- **MySQL** 8.0
- **Tomcat** 9.0.65
- **SDK** Amazon Corretto version 15.0.2
- **Connector** mysql-connector-java-8.0.20.jar

# Implementation

## Design
기존 schema에 student relation에 state(학적) attribute 추가    
   
**Domain** (default: 1)
- 1: 재학
- 2: 휴학
- 3: 자퇴  

## Implement Details

### 수강편람

- 전체

```sql
select * 
from class 
where opened = 2022 
order by class_id
```

- 수업번호 검색

```sql
select * 
from class 
where opened = 2022 and class_no = ? 
order by class_id
```

- 학수번호 검색

```sql
select * 
from class 
where opened = 2022 and course_id = ? 
order by class_id
```

- 교과목명 키워드 포함 검색

```sql
select * 
from class 
where opened = 2022 and name like ? 
order by class_id
```

- 교강사이름 표시

```sql
SELECT name FROM lecturer WHERE lecturer_id = ?
```

- 신청인원/정원 표시

```sql
SELECT person_max 
FROM class 
WHERE class_id = ?

SELECT count(*) 
FROM application 
WHERE class_id = ?
```

- 강의실 표시

```sql
SELECT building_id FROM room WHERE room_id = ?

SELECT name FROM building WHERE building_id = ?
```

### 사용자 로그인

```sql
SELECT password 
FROM student 
WHERE student_id= ?
```

### 사용자 비밀번호 변경

```sql
update student set password = ? 
where student_id = ?
```

### 수강신청 및 취소

희망수업도 수강신청과 동일함

- 수강신청 내역 조회

```sql
SELECT * FROM application where student_id = ?
```

- 수강신청 추가

```sql
insert into application values (?, ?, ?)
```

- 수강신청 취소

```sql
delete from application 
where student_id = ? and class_id = ?
```

- 재수강 여부 체크

```sql
SELECT credits_id 
FROM credits 
WHERE student_id = ? and course_id = ?
```

조건1: 이전 성적이 B0이상일 경우 수강 신청 불가능

→ 이전 성적 중 최고 성적 조회

```sql
SELECT case when grade = 'A+' then 4.5 
	when grade = 'A0' then 4.0 when grade = 'B+' 
	then 3.5 when grade = 'B0' then 3.0 when 
	grade = 'C+' then 2.5 when grade = 'C0' then 
	2.0 when grade = 'D+' then 1.5 when grade = 'D0' 
	then 1.0 when grade = 'F' then 0.0 else 0.0 end 
	as gradeNum 
FROM credits 
where student_id = ? and course_id = ? 
order by gradeNum desc limit 1
```

조건2: 정원이 다 찼을 경우 해당 과목 수강 신청 불가능

→~~수업 정원 조회, 수강신청 인원 조회(수강편람과 동일)~~

조건3: 동일 시간대에 2개 이상의 과목 수강 신청은 불가능

→수업 시간 아이디 조회, ~~시간 조회(시간표 조회와 같음)~~

```sql
SELECT time_id 
FROM time 
WHERE class_id = ? and period = 1
```

조건4: 최대 학점은 18학점으로 제한하여 초과 신청은 불가능

→수업 학점 조회

```sql
SELECT credit FROM class WHERE class_id = ?
```

### 시간표 조회

- 시작시간

```sql
SELECT begin 
FROM time 
WHERE time_id = ?
```

- 종료시간

```sql
SELECT end 
FROM time 
WHERE time_id = ?
```

### 관리자-학생 정보 조회 및 변경

- 학생 리스트 출력

```sql
select * from student order by student_id
```

- 성적 조회

```sql
SELECT * FROM credits WHERE student_id= ? 
order by year, credits_id
```

- 학적  변경

```sql
update student set state = ? where student_id = ?
```

### 관리자-과목 상태 조회 및 변경

- ~~과목 조회 (수강편람과 동일)~~
- 과목 정원 변경

```sql
update class set person_max = ? 
where class_id = ?
```

- ~~수강 허용(한자리 증원, 수강신청)~~

### 관리자-과목 설강 및 폐강

- 설강

```sql
insert into class values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
```

- 폐강

```sql
delete from class where class_id = ?
```

조건1: 수강 정원이 강의실 수용 인원보다 초과할 경우 과목 개설 불가능

→~~수강 정원 조회(수강편람과 동일)~~, 강의실 수용 인원 조회

```sql
SELECT occupancy FROM room WHERE room_id = ?
```

조건2: 수업이 폐강되면 해당 수업을 신청/희망 한 학생들의 목록에서 과목 내역 삭제

```sql
delete from application where class_id = ?

delete from hopeclass where class_id = ?
```

~~조건3: 토요일과 평일 18시 이후 수업은 E-러닝 강의로 분류, 일요일은 과목 개설 불가능~~

~~→입력 받을때 처리~~

### 관리자-통계

- 학생 평점 평균 조회

```sql
SELECT avg(gradeNum) as gradeAverage 
from (select case when grade = 'A+' then 4.5 
	when grade = 'A0' then 4.0 when grade = 'B+' 
	then 3.5 when grade = 'B0' then 3.0 when grade = 
	'C+' then 2.5 when grade = 'C0' then 2.0 when grade
	 = 'D+' then 1.5 when grade = 'D0' then 1.0 when 
	grade = 'F' then 0.0 else 0.0 end as gradeNum 
	from credits where student_id = ?) as a
```

- 해당 과목을 이수한 총 인원 조회

```sql
SELECT count(*) FROM credits WHERE course_id = ?
```

- 학생 과목 평점 조회(수강 이력이 여러번이면 평균)

```sql
select avg(gradeNum) 
from (SELECT case when grade = 'A+' then 4.5 
		when grade = 'A0' then 4.0 when grade = 'B+' 
	then 3.5 when grade = 'B0' then 3.0 when grade = 
	'C+' then 2.5 when grade = 'C0' then 2.0 when 
	grade = 'D+' then 1.5 when grade = 'D0' then 1.0 
	when grade = 'F' then 0.0 else 0.0 end as gradeNum 
	FROM credits WHERE student_id = ? and course_id = ?)
as a
```

- 학생 과목 이수 횟수 조회

```sql
select count(*) from credits 
where student_id = ? and course_id = ?
```

## Result
[노션 - Proj #1 수강신청 만들기](https://roan-fin-633.notion.site/Proj-1-fcb10722160c45ce9f753ab53c61c27e?pvs=4)

## Trouble shooting

1. 웹구현   
    
   참고: [https://youtu.be/hke9FKluXow](https://youtu.be/hke9FKluXow)

2. 시간표 구현  

    \<table/>, \<tr/>, \<td/>로 시간표를 구현하였음

    행이 시간대를, 열이 요일을 나타내게 하였음   

    - Ex 1) 시간대가 A시 B분 ~ C시 D분 일때, 0:00~0:30에 포함 되는지 체크? 

      조건: 시간대는 String으로 시작시간, 종료시간 따로 주어짐, B와 D는 0 또는 30

      → String의 substring을 이용하여 시, 분 따로 체크   

      - 1.**시** 먼저 체크

        시간이 만족해야하는 조건: A ≤ 0, C ≥ 0

      - 2.**분**으로 예외 체크 
        - case1: A=0, B=30

        - case2: C = 0, D=0

      ```java
      //코드의 일부
      if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 0
        && Integer.parseInt(end.substring(7,8)) >=0){
        if(Integer.parseInt(begin.substring(7,8)) == 0 && Integer.parseInt(begin.substring(10,12)) == 30){;}
        else if(Integer.parseInt(end.substring(7,8)) == 0 && Integer.parseInt(end.substring(10,12)) == 0){;}
        else{
      ```

    - Ex2) 시간대가 A시 B분 ~ C시 D분 일때, 0:30~1:00에 포함 되는지 체크? 

      시간만 체크 : A≤0, C>0

      30분 간격으로 반복문을 사용하였음 

      → 시간표 출력 시간 오래 걸림

3. 통계 구현

    **학점을 잘 안 주는 과목 찾기**

    필요한 정보: 학생 평점 평균, 학생 과목별 평점, 과목을 이수한 학생 수

    → 모든학생(학생 과목 평점 - 학생 평점 평균)의 합 / 과목을 이수한 학생 수

    SQL문으로 구현할 방법을 못찾아서, 

    - creditsDAO 내에 학생 평점 평균을 반환하는 `getAverageGradeStudent` 함수,

    - 재수강 일 수 있기에 해당 학생이 이수한 횟수를 반환하는 `getHowManyTime` 함수,

    - 학생이 해당 과목에 대한 평점을 반환하는`getCredit` 함수,

    - 해당과목으로 성적이 몇개 있는지 반환하는 `getHowManyStudent` 함수를 구현.

    학생이 한 과목에 성적이 여러개인 경우를 위해, getCredit은 그 성적들의 평균을 구하게 하고, getHowManyStudent로 (해당 과목 평점 - 학생 평점 평균)을 곱해 주었음.
