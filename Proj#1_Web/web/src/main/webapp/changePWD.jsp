<%@ page import="java.io.PrintWriter" %>
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
    String id = null;
    if(session.getAttribute("id")!=null){
        id = (String)session.getAttribute("id");
    }
    if(id == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 상태가 아닙니다.');");
        script.println("location.href = 'Login.jsp';");
        script.println("</script>");
        script.close();
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">수강신청 홈페이지</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">메인</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                    회원 관리
                </a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <%
                        if(id == null){
                    %>
                    <a class="dropdown-item" href="Login.jsp">로그인</a>
                    <%
                    } else {
                    %>
                    <a class="dropdown-item" href="showApplication.jsp">수강신청 내역</a>
                    <a class="dropdown-item" href="showHopeclass.jsp">희망수업 내역</a>
                    <a class="dropdown-item" href="timetable.jsp" onclick="window.open(this.href, '시간표', 'width=700, height=900, toolbars=no, scrollbars=yes'); return false;">시간표</a>
                    <a class="dropdown-item" href="logout.jsp">로그아웃</a>
                    <a class="dropdown-item" href="changePWD.jsp">비밀번호 변경</a>
                    <%
                        }
                    %>
                </div>
            </li>
        </ul>
<%--        <form class="form-inline my-2 my-lg-0">--%>
<%--            <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">--%>
<%--            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>--%>
<%--        </form>--%>
    </div>
</nav>
<section class="container mt-3" style="max_width: 560px;">
    <form method="post" action="./changePWDAction.jsp">
        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" name="password" class ="form-control">
        </div>
        <button type="submit" class="btn btn-primary mt-2">변경</button>
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