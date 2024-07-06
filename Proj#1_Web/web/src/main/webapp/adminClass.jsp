<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="classes.classesDAO"%>
<%@ page import ="classes.classesDTO"%>
<%@ page import ="lecturer.lecturerDAO"%>
<%@ page import ="application.applicationDAO"%>
<%@ page import ="room.roomDAO"%>
<%@ page import ="building.buildingDAO"%>
<%@ page import ="time.timeDAO"%>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.net.URLEncoder"%>
<%@ page import="credits.creditsDAO" %>
<%@ page import="util.admin" %>
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
    String searchType ="전체";
    String search ="";
    int pageNumber = 0;
    if(request.getParameter("searchType")!= null){
        searchType = request.getParameter("searchType");
    }
    if(request.getParameter("search")!= null){
        search = request.getParameter("search");
    }
    if(request.getParameter("pageNumber")!= null){
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }catch (Exception e){
            System.out.println("검색 페이지 번호 오류");
        }
    }

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
                    관리 메뉴
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
<section class="container">
    <form method="get" action="./adminClass.jsp" class="form-inline mt-3">
        <select name="searchType" class="form-control mx-1 mt-2">
            <option value="전체">전체</option>
            <option value="수업번호">수업번호</option>
            <option value="학수번호">학수번호</option>
            <option value="교과목명">교과목명</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
    </form>
    <%
        //수강편람 기능과 같은 동작 원리
        ArrayList<classesDTO> classesList = new ArrayList<classesDTO>();
        lecturerDAO lecturer = new lecturerDAO();
        timeDAO time = new timeDAO();
        roomDAO room = new roomDAO();
        applicationDAO applicationDAO = new applicationDAO();
        buildingDAO building = new buildingDAO();
        classesList = new classesDAO().getList(searchType, search, pageNumber);
        if(classesList != null)
            for(int i = 0; i < classesList.size(); i++){
                if(i == 5) break;
                classesDTO classes = classesList.get(i);
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
                    <%= classes.getClass_no()%>
                </div>
                <div class="col-sm">
                    <%= classes.getCourse_id()%>
                </div>
                <div class="col-sm-3">
                    <%= classes.getName()%>
                </div>
                <div class="col-sm">
                    <%= lecturer.getLecturerName(classes.getLecturer_id())%>
                </div>
                <div class="col-sm-2">
                    <%= time.getTimeBegin(time.getTimeId(classes.getClass_id()))%>
                </div>
                <div class="col-sm-2">
                    <%= applicationDAO.getHowManyApplication(classes.getClass_id())%>/<%= classes.getPerson_max()%>
                </div>
                <div class="col-sm-2">
                    <%= building.getName(room.getBuildingId(classes.getRoom_id()))%> <%= classes.getRoom_id()%>호
                </div>
            </div>
        </div>
    </div>
<%--정원 변경 버튼--%>
    <div class="custom-control-inline">
    <form class="form-inline" method="post" action="./adminChangeMaxpersonAction.jsp?class_id=<%= classes.getClass_id() %>">
        <div class="form-group" >
            <label>정원</label>
            <input type="text" name="max" class="form-control mt-2 ml-2 mr-2">
        </div>
        <button type="submit" class="btn btn-primary mt-2">변경</button>
    </form>
<%--수강 허용 버튼--%>
    <form class="form-inline ml-3" method="post" action="./applicationAction.jsp?class_id=<%= classes.getClass_id() %>">
        <div class="form-group">
            <label>학생id</label>
            <input type="text" name="student_id" class="form-control mt-2 ml-2 mr-2">
        </div>
        <button type="submit" class="btn btn-primary mt-2">수강허용</button>
    </form>
        </div>
<%
        }
%>
</section>
<ul class="pagination justify-content-center mt-3">
    <li class="page-item">
        <%
            if(pageNumber <=0 ) {
        %>
        <a class="page-link disabled">이전</a>
        <%
        } else{
        %>
        <a class="page-link" href="./adminClass.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber - 1 %>">이전</a>
        <%
            }
        %>
    </li>
    <li>
        <%
            if(classesList.size() < 6 ) {
        %>
        <a class="page-link disabled">다음</a>
        <%
        } else{
        %>
        <a class="page-link" href="./adminClass.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber + 1 %>">다음</a>
        <%
            }
        %>
    </li>
</ul>
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