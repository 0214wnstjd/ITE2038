<%@ page import="java.io.PrintWriter" %>
<%@ page import="util.admin" %>
<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>수강신청 웹사이트</title>
    <!--부트스트랩 CSS 추가하기-->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <!--커스텀 CSS 추가하기-->
    <link rel="stylesheet" href="./css/custom.css">
    <style>
        input[type=password]{
            font-family : "Times New Roman";
        }
    </style>
</head>
<body>

<%
    //로그인 여부 체크 부분
    String id = null;
    if(session.getAttribute("id")!=null){
        id = (String)session.getAttribute("id");
    }
    admin admin = new admin();
    if(id == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'Login.jsp';");
        script.println("</script>");
        script.close();
    }
    //관리자 여부 체크 부분
    if(!id.equals(admin.getId())){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자가 아닙니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="admin.jsp">수강신청 관리자 페이지</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="admin.jsp">메인</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                    회원 관리
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <a class="dropdown-item" href="adminStudent.jsp">학생 정보 조회 및 변경</a>
                    <a class="dropdown-item" href="adminClass.jsp">과목 정보 조회 및 변경</a>
                    <a class="dropdown-item" href="addClass.jsp">과목 설강</a>
                    <a class="dropdown-item" href="deleteClass.jsp">과목 폐강</a>
                    <a class="dropdown-item" href="OLAP.jsp">통계</a>
                    <a class="dropdown-item" href="logout.jsp">로그아웃</a>
                </div>
            </li>
        </ul>

    </div>
</nav>
<%--입력 받아서 Action 페이지로 전달--%>
<section class="container mt-3" style="max_width: 560px;">
    <form method="post" action="./addClassAction.jsp">
        <div class="form-group">
            <label>수업 아이디</label>
            <input type="text" name="class_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>수업 번호</label>
            <input type="text" name="class_no" class ="form-control">
        </div>
        <div class="form-group">
            <label>학수 번호</label>
            <input type="text" name="course_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>수업 이름</label>
            <input type="text" name="name" class ="form-control">
        </div>
        <div class="form-group">
            <label>전공 아이디</label>
            <input type="text" name="major_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>학년</label>
            <input type="text" name="year" class ="form-control">
        </div>
        <div class="form-group">
            <label>학점</label>
            <input type="text" name="credit" class ="form-control">
        </div>
        <div class="form-group">
            <label>교수 아이디</label>
            <input type="text" name="lecturer_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>정원</label>
            <input type="text" name="person_max" class ="form-control">
        </div>
        <div class="form-group">
            <label>설강 연도</label>
            <input type="text" name="open_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>강의실 아이디</label>
            <input type="text" name="room_id" class ="form-control">
        </div>
        <div class="form-group">
            <label>시작 시간</label>
            <input type="text" name="begin" class ="form-control" placeholder="A요일 B시 C분 형태로 입력하셔야하며 분은 30분 단위입니다.">
        </div>
        <div class="form-group">
            <label>종료 시간</label>
            <input type="text" name="end" class ="form-control" placeholder="A요일 B시 C분 형태로 입력하셔야하며 분은 30분 단위입니다.">
        </div>
        <button type="submit" class="btn btn-primary mt-2">추가</button>
    </form>

</section>
<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
    Copyright &copy; 2019007892 박준성 All Rights Reserved.
</footer>
<!--제이쿼리 자바스크립트 추가하기-->
<script src="./js/jquery.min.js"></script>
<!--파퍼 자바스크립트 추가하기-->
<script src="./js/popper.js"></script>
<!--부트스트랩 자바스크립트 추가하기-->
<script src="./js/bootstrap.min.js"></script>
</body>
</html>