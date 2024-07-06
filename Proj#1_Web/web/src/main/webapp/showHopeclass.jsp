<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="student.studentDAO"%>
<%@ page import ="classes.classesDAO"%>
<%@ page import ="classes.classesDTO"%>
<%@ page import ="lecturer.lecturerDAO"%>
<%@ page import ="room.roomDAO"%>
<%@ page import ="building.buildingDAO"%>
<%@ page import ="time.timeDAO"%>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.net.URLEncoder"%>
<%@ page import="application.applicationDTO" %>
<%@ page import="application.applicationDAO" %>
<%@ page import="hopeclass.hopeclassDTO" %>
<%@ page import="hopeclass.hopeclassDAO" %>
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
        script.println("alert('로그인을 해주세요.');");
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
    </div>
</nav>
<section class="container">
    <%
        //hopeclass를 getList로 리스트를 다 받음
        ArrayList<hopeclassDTO> hopeclassList = new ArrayList<hopeclassDTO>();
        lecturerDAO lecturer = new lecturerDAO();
        timeDAO time = new timeDAO();
        roomDAO room = new roomDAO();
        classesDAO classesDAO = new classesDAO();
        buildingDAO building = new buildingDAO();
        applicationDAO applicationDAO = new applicationDAO();
        hopeclassList = new hopeclassDAO().getList(id);
        if(hopeclassList != null)
            for(int i = 0; i < hopeclassList.size(); i++){
                hopeclassDTO hopeclasses = hopeclassList.get(i);
                //각각 희망수업마다 출력
    %>
    <div class ="card bg-light mt-3">
        <div class="card-body bg-light">
            <div class="row">
                <div class="col-sm-1">
                    수업번호
                </div>
                <div class="col-sm">
                    학수번호
                </div>
                <div class="col-sm-3">
                    교과목명
                </div>
                <div class="col-sm">
                    교수이름
                </div>
                <div class="col-sm-2">
                    수업시간
                </div>
                <div class="col-sm-2">
                    신청인원/수강정원
                </div>
                <div class="col-sm-2">
                    강의실
                </div>
            </div>
            <div class="row">
                <div class="col-sm-1">
                    <%= classesDAO.getClassno(hopeclasses.getClass_id())%>
                </div>
                <div class="col-sm">
                    <%= classesDAO.getCourseid(hopeclasses.getClass_id())%>
                </div>
                <div class="col-sm-3">
                    <%= classesDAO.getName(hopeclasses.getClass_id())%>
                </div>
                <div class="col-sm">
                    <%= lecturer.getLecturerName(classesDAO.getLecturerid(hopeclasses.getClass_id()))%>
                </div>
                <div class="col-sm-2">
                    <%= time.getTimeBegin(time.getTimeId(hopeclasses.getClass_id()))%>
                </div>
                <div class="col-sm-2">
                    <%= applicationDAO.getHowManyApplication(hopeclasses.getClass_id())%>/<%= classesDAO.getPersonMax(hopeclasses.getClass_id())%>
                </div>
                <div class="col-sm-2">
                    <%= building.getName(room.getBuildingId(classesDAO.getRoomid(hopeclasses.getClass_id())))%> <%= classesDAO.getRoomid(hopeclasses.getClass_id())%>호
                </div>
                <div class="col-sm-1">
                </div>
            </div>
        </div>
    </div>
<%--    수강신청버튼과, 희망수업 취소버튼--%>
    <a onclick="return confird('신청하시겠습니까?')" href="./applicationAction.jsp?class_id=<%= hopeclasses.getClass_id() %>">수강신청</a>
    <a>     </a>
    <a onclick="return confird('취소하시겠습니까?')" href="./hopeclassCancleAction.jsp?class_id=<%= hopeclasses.getClass_id() %>">희망취소</a>
    <%
            }
    %>
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