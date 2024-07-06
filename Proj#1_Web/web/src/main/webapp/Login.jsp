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
    //로그인상태인지 체크
    if(id != null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인 되어있습니다.');");
        script.println("location.href = 'index.jsp';");
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
                    <a class="dropdown-item" href="logout.jsp">로그아웃</a>
                    <a class="dropdown-item" href="changePWD.jsp">비밀번호 변경</a>
                    <%
                        }
                    %>
                </div>
            </li>
        </ul>
    </div>
</nav>
<%--아이디 비밀번호 입력받아서 action페이지로 쏴줌--%>
    <section class="container mt-3" style="max_width: 560px;">
        <form method="post" action="./loginAction.jsp">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="id" class="form-control">
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="password" class ="form-control">
            </div>
            <div>
                <input type="checkbox" name="admin" value="admin"> 관리자 로그인
            </div>
            <button type="submit" class="btn btn-primary mt-2">로그인</button>
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