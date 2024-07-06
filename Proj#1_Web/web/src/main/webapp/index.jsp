<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    // 검색을 위해 검색 유형, 검색내용, 페이지 번호를 request 로 받음
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
%>
<%--위에 nav 바에 메뉴를 띄움--%>
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
    //로그인 하지 않았을시 로그인 메뉴만 뜨게함
    if(id == null){
%>
                        <a class="dropdown-item" href="Login.jsp">로그인</a>
<%
    } else {
        //로그인 세션이 아닐시 로그인 외의 메뉴들 뜨게 함
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
<%--form get을 이용해 검색유형(searchType), 검색내용(search)를 쏴줌--%>
        <form method="get" action="./index.jsp" class="form-inline mt-3">
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
            //수강편람 내역
            ArrayList<classesDTO> classesList = new ArrayList<classesDTO>();
            lecturerDAO lecturer = new lecturerDAO();
            timeDAO time = new timeDAO();
            roomDAO room = new roomDAO();
            creditsDAO credits = new creditsDAO();
            applicationDAO applicationDAO = new applicationDAO();
            buildingDAO building = new buildingDAO();
            classesList = new classesDAO().getList(searchType, search, pageNumber);
            //getList를 이용해 수업 리스트를 받음
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
        <%
            //해당과목이 재수강과목인지 체크
            //재수강이 이라면  -> 재수강 버튼
            if(credits.getCreditid(id, classes.getCourse_id()) >0 && credits.getCreditid(id, classes.getCourse_id()) != -2){
        %>
        <a onclick="return confird('신청하시겠습니까?')" href="./applicationAction.jsp?class_id=<%= classes.getClass_id() %>">재수강</a>
        <%
            } else{
                //재수강이 아니라면 -> 수강신청 버튼
        %>
        <a onclick="return confird('신청하시겠습니까?')" href="./applicationAction.jsp?class_id=<%= classes.getClass_id() %>">수강신청</a>
        <%
            }
            //희망수업 담기 버튼
        %>
        <a>      </a>
        <a onclick="return confird('담으시겠습니까?')" href="./hopeclassAction.jsp?class_id=<%= classes.getClass_id() %>">희망수업 담기</a>

        <%
                }
        %>
    </section>
    <ul class="pagination justify-content-center mt-3">
        <li class="page-item">
            <%
                //현재페이지가 첫페이지일 경우는 이전버튼 비활성화
                if(pageNumber <=0 ) {
            %>
            <a class="page-link disabled">이전</a>
            <%
                } else{
                    //이전페이지로 이동 버튼
            %>
            <a class="page-link" href="./index.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber - 1 %>">이전</a>
            <%
                }
            %>
        </li>
        <li>
            <%
                //마지막페이지면 (남은 수업 개수 6개 미만) 다음 버튼 비활성화
                if(classesList.size() < 6 ) {
            %>
            <a class="page-link disabled">다음</a>
            <%
                } else{
                    //다음페이지로 이동 버튼
            %>
            <a class="page-link" href="./index.jsp?searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber + 1 %>">다음</a>
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