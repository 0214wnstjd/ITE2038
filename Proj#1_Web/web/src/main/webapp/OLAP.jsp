<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="student.studentDAO"%>
<%@ page import ="java.util.ArrayList"%>
<%@ page import="credits.creditsDAO" %>
<%@ page import="util.admin" %>
<%@ page import="student.studentDTO" %>
<%@ page import="course.courseDAO" %>
<%@ page import="course.courseDTO" %>
<%@ page import="credits.OLAP" %>
<%@ page import="java.util.Collections" %>
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
    //관리자 로그인 인지 체크
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
    <h2 style="margin-top : 1em; margin-bottom: 1em">통계</h2>
    <table id="userList" class="table table-hover">
        <tr>
            <th>과목이름</th>
            <th>평점평균과 과목평점 차이의 평균</th>
        </tr>
        <%
            ArrayList<courseDTO> courseList = new ArrayList<courseDTO>();
            ArrayList<studentDTO> studentList = new ArrayList<studentDTO>();
            ArrayList<OLAP> diff = new ArrayList<OLAP>();               //평점 차이를 저장할 OLAP클래스 리스트
            creditsDAO creditsDAO = new creditsDAO();
            courseDAO course = new courseDAO();
            courseList = new courseDAO().getList();                 //과목리스트
            studentList = new studentDAO().getList();               //학생리스트
            for(int i = 0; i < courseList.size(); i++) {
                float sum=0;
                courseDTO courses = courseList.get(i);
                float courseGradeAverage = creditsDAO.getAverageGradeCourse(courses.getCourse_id());    //과목평점평균
                diff.add(new OLAP(course.getName(courses.getCourse_id()), 0));//과목 개수만큼 diff에 객체 추가
                for (int j = 0; j < studentList.size(); j++) {
                    studentDTO students = studentList.get(j);
                    float studentGradeAverage = creditsDAO.getAverageGradeStudent(students.getStudent_id());    //학생평점평균
                    int hm = creditsDAO.getHowManyTime(students.getStudent_id(), courses.getCourse_id());  //해당과목을 이수 횟수
                    if (hm != 0) {
                        float rt = creditsDAO.getCredit(students.getStudent_id(),courses.getCourse_id()) - studentGradeAverage;        //과목평점-평점평균
                        sum+=Math.abs(rt)*hm;
                    }
                }
                diff.get(i).setDiff(sum/creditsDAO.getHowManyStudent(courses.getCourse_id()));//diff에 추가
            }

            Collections.sort(diff, Collections.reverseOrder());             //diff값을 기준으로 오름차순 정렬함
            for(int m = 0; m < 10; m++){                // 10과목 출력
                OLAP olap = diff.get(m);
        %>
        <tr>
            <td style="vertical-align: middle">
                <%= olap.getName() %>
            </td>
            <td style="vertical-align: middle">
                <%= olap.getDiff() %>
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