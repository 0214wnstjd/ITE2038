<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import="credits.creditsDAO" %>
<%@ page import="util.admin" %>
<%@ page import="credits.creditsDTO" %>
<%@ page import="course.courseDAO" %>
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
    //관리자 로그인 체크
    request.setCharacterEncoding("UTF-8");
    String id = null;
    String student_id = null;
    if(session.getAttribute("id")!=null){
        id = (String)session.getAttribute("id");
    }
    if(request.getParameter("student_id")!=null){
        student_id = request.getParameter("student_id");
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
    if(!id.equals(admin.getId())){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자가 아닙니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
    }
%>
<section class="container">
    <h2 style="margin-top : 1em; margin-bottom: 1em">성적</h2>
    <table id="userList" class="table table-hover">
        <tr>
            <th>과목이름</th>
            <th>학수번호</th>
            <th>이수연도</th>
            <th>성적</th>
        </tr>
        <%
            ArrayList<creditsDTO> creditsList = new ArrayList<creditsDTO>();        //성적 리스트
            courseDAO course = new courseDAO();
            creditsList = new creditsDAO().getList(student_id);         //getList로 성적 리스트 받아옴
            if(creditsList != null)
                for(int i = 0; i < creditsList.size(); i++){
                    creditsDTO credits = creditsList.get(i);
        %>
        <tr>
            <td style="vertical-align: middle">
                <%= course.getName(credits.getCourse_id()) %>
            </td>
            <td style="vertical-align: middle">
                <%= credits.getCourse_id() %>
            </td>
            <td style="vertical-align: middle">
                <%= credits.getYear() %>
            </td>
            <td style="vertical-align: middle">
                <%= credits.getGrade() %>
            </td>
        <%
                }
        %>
    </table>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
        Copyright &copy; 2019007892 박준성 All Rights Reserved.
    </footer>
</section>
<!--제이쿼리 자바스크립트 추가하기-->
<script src="./js/jquery.min.js"></script>
<!--파퍼 자바스크립트 추가하기-->
<script src="./js/popper.js"></script>
<!--부트스트랩 자바스크립트 추가하기-->
<script src="./js/bootstrap.min.js"></script>
</body>
</html>