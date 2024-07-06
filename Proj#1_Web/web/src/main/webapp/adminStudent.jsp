<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="student.studentDAO"%>
<%@ page import ="lecturer.lecturerDAO"%>
<%@ page import ="application.applicationDAO"%>
<%@ page import ="room.roomDAO"%>
<%@ page import ="building.buildingDAO"%>
<%@ page import ="time.timeDAO"%>
<%@ page import ="java.util.ArrayList"%>
<%@ page import="credits.creditsDAO" %>
<%@ page import="util.admin" %>
<%@ page import="student.studentDTO" %>
<%@ page import="major.majorDAO" %>
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
    <h2 style="margin-top : 1em; margin-bottom: 1em">학생 목록</h2>
    <table id="userList" class="table table-hover">
        <tr>
            <th>아이디</th>
            <th>비밀번호</th>
            <th>이름</th>
            <th>성별</th>
            <th>전공</th>
            <th>지도교수</th>
            <th>학년</th>
            <th>      학적</th>
            <th>시간표</th>
            <th>성적</th>
        </tr>
    <%
        ArrayList<studentDTO> studentList = new ArrayList<studentDTO>();
        lecturerDAO lecturer = new lecturerDAO();
        majorDAO major = new majorDAO();
        String[] state ={"재학", "휴학", "자퇴"}; //학적 1, 2, 3 -> 재학, 휴학, 자퇴 형태로 바꾸기 위한 array
        studentList = new studentDAO().getList();
        if(studentList != null)
            for(int i = 0; i < studentList.size(); i++){
                studentDTO student = studentList.get(i);
    %>
            <tr>
                <td style="vertical-align: middle">
                    <%= student.getStudent_id() %>
                </td>
                <td style="vertical-align: middle">
                    <%= student.getPassword() %>
                </td>
                <td style="vertical-align: middle">
                    <%= student.getName() %>
                </td>
                <td style="vertical-align: middle">
                    <%= student.getSex().equals("male") ? "남자" : "여자" %>
                </td>
                <td style="vertical-align: middle">
                    <%= major.getName(student.getMajor_id()) %>
                </td>
                <td style="vertical-align: middle">
                    <%= lecturer.getLecturerName(student.getLecturer_id()) %>
                </td>
                <td style="vertical-align: middle">
                    <%= student.getYear() %>
                </td>
                <td style="vertical-align: middle">
                    <%= state[student.getState() - 1] %>
                     
                    <button class="btn btn-secondary pull-right" type="button" data-toggle="modal" data-target="#modal<%= student.getStudent_id() %>">변경</button>
                    </td>
                <td style="vertical-align: middle">
                    <button class="btn btn-secondary pull-right" type="button" onclick="window.open('timetable.jsp?student_id=<%= student.getStudent_id() %>', '시간표', 'width=700, height=900, toolbars=no, scrollbars=yes'); return false;">조회</button>
                </td>
                <td style="vertical-align: middle">
                    <button class="btn btn-secondary pull-right" type="button" onclick="window.open('credittable.jsp?student_id=<%= student.getStudent_id() %>', '성적표', 'width=700, height=900, toolbars=no, scrollbars=yes'); return false;">조회</button>
                </td>
            </tr>
        <div class="modal fade" id=modal<%= student.getStudent_id() %> tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">학적 변경</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
<%--                        student id 를 학적변동 액션에 쏴줌--%>
                        <form method="post" action="./adminChangeStudentState.jsp?student_id=<%= student.getStudent_id() %>">
                            <div class="form-group">
                                <label>학적</label>
<%--                                학적 값을 선택해 학적변동 액션에 쏴줌--%>
                                <select name="state" class="form-control mx-1 mt-2">
                                    <option value="1">재학</option>
                                    <option value="2">휴학</option>
                                    <option value="3">자퇴</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary mt-2">변경</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
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