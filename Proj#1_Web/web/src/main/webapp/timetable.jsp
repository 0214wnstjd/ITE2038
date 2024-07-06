<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import ="java.io.PrintWriter" %>
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
    // admin이 학생 시간표 출력시
    if(id.equals(admin.getId())){
      if(request.getParameter("student_id")!=null){
        id = request.getParameter("student_id");
      }
    }
%>
<%
    ArrayList<applicationDTO> applicationList = new ArrayList<applicationDTO>();
    lecturerDAO lecturer = new lecturerDAO();
    timeDAO time = new timeDAO();
    roomDAO room = new roomDAO();
    classesDAO classesDAO = new classesDAO();
    buildingDAO building = new buildingDAO();
    applicationDAO applicationDAO = new applicationDAO();
    applicationList = new applicationDAO().getList(id);
%>
<div class="mt-3"></div>
<h2 style="text-align: center">수강신청 시간표</h2>
<style>
  td.timetable{
    color:white;
  }
</style>
  <table mcellspacing="5" align="center" border="1" bordercolor="#2E2EFE"
         width="550" height="600" >
    <tr align="center">
      <td class="timetable" width="50"></td>
      <td class="timetable" width="150" bgcolor="#0080FF">월</td>
      <td class="timetable" width="150" bgcolor="#0080FF">화</td>
      <td class="timetable" width="150" bgcolor="#0080FF">수</td>
      <td class="timetable" width="150" bgcolor="#0080FF">목</td>
      <td class="timetable" width="150" bgcolor="#0080FF">금</td>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">12:00</td>
      <%
        String[] d = {"월", "화", "수", "목", "금"};          // 가로 순으로 월 화 수 목 금 5번 반복
        int j;                                             // begin end를 이용하여 시간대가 포함 되었는지 체크
        for(int i =0; i < 5; i++){
        for(j = 0; j < applicationList.size(); j++){
        applicationDTO applications = applicationList.get(j);       // 수강신청 Arraylist 이용
        String begin = time.getTimeBegin(applications.getTime_id());
        String end = time.getTimeEnd(applications.getTime_id());
        if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 0
        && Integer.parseInt(end.substring(7,8)) >=0){
        if(Integer.parseInt(begin.substring(7,8)) == 0 && Integer.parseInt(begin.substring(10,12)) == 30){;}
        else if(Integer.parseInt(end.substring(7,8)) == 0 && Integer.parseInt(end.substring(10,12)) == 0){;}
        else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">12:30</td>
      <%
        for(int i =0; i < 5; i++){
        for(j = 0; j < applicationList.size(); j++){
        applicationDTO applications = applicationList.get(j);
        String begin = time.getTimeBegin(applications.getTime_id());
        String end = time.getTimeEnd(applications.getTime_id());
        if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 0
        && Integer.parseInt(end.substring(7,8)) >=0){
        if(Integer.parseInt(end.substring(7,8)) == 0){;}
        else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%

              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">13:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 1
                    && Integer.parseInt(end.substring(7,8)) >=1){
              if(Integer.parseInt(begin.substring(7,8)) == 1 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 1 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">13:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 1
                    && Integer.parseInt(end.substring(7,8)) >=1){
              if(Integer.parseInt(end.substring(7,8)) == 1){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">14:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 2
                    && Integer.parseInt(end.substring(7,8)) >=2){
              if(Integer.parseInt(begin.substring(7,8)) == 2 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 2 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">14:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 2
                    && Integer.parseInt(end.substring(7,8)) >=2){
              if(Integer.parseInt(end.substring(7,8)) == 2){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">15:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 3
                    && Integer.parseInt(end.substring(7,8)) >=3){
              if(Integer.parseInt(begin.substring(7,8)) == 3 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 3 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
      }
      }
      }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">15:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 3
                    && Integer.parseInt(end.substring(7,8)) >=3){
              if(Integer.parseInt(end.substring(7,8)) == 3){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>


    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">16:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 4
                    && Integer.parseInt(end.substring(7,8)) >=4){
              if(Integer.parseInt(begin.substring(7,8)) == 4 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 4 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
            break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">16:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 4
                    && Integer.parseInt(end.substring(7,8)) >=4){
              if(Integer.parseInt(end.substring(7,8)) == 4 ){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">17:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 5
                    && Integer.parseInt(end.substring(7,8)) >=5){
              if(Integer.parseInt(begin.substring(7,8)) == 5 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 5 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">17:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 5
                    && Integer.parseInt(end.substring(7,8)) >=5){
              if(Integer.parseInt(end.substring(7,8)) == 5 ){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">18:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 6
                    && Integer.parseInt(end.substring(7,8)) >=6){
              if(Integer.parseInt(begin.substring(7,8)) == 6 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 6 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">18:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 6
                    && Integer.parseInt(end.substring(7,8)) >=6){
              if(Integer.parseInt(end.substring(7,8)) == 6 ){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>

    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">19:00</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 7
                    && Integer.parseInt(end.substring(7,8)) >=7){
              if(Integer.parseInt(begin.substring(7,8)) == 7 && Integer.parseInt(begin.substring(10,12)) == 30){;}
              else if(Integer.parseInt(end.substring(7,8)) == 7 && Integer.parseInt(end.substring(10,12)) == 0){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>
    <tr align="center">
      <td class="timetable" bgcolor="#0080FF">19:30</td>
      <%
        for(int i =0; i < 5; i++){
          for(j = 0; j < applicationList.size(); j++){
            applicationDTO applications = applicationList.get(j);
            String begin = time.getTimeBegin(applications.getTime_id());
            String end = time.getTimeEnd(applications.getTime_id());
            if(d[i].equals(begin.substring(0,1)) && Integer.parseInt(begin.substring(7,8)) <= 7
                    && Integer.parseInt(end.substring(7,8)) >=7){
              if(Integer.parseInt(end.substring(7,8)) == 7 ){;}
              else{
      %>
      <td class="timetable" bgcolor="#0080FF">
        <%= classesDAO.getName(applications.getClass_id()) %>
      </td>

      <%
              break;
            }
          }
        }if(j== applicationList.size()){
      %>
      <td class="timetable"></td>
      <%
        }
        }
      %>
    </tr>


  </table>
</section>
<!--제이쿼리 자바스크립트 추가하기-->
<script src="./js/jquery.min.js"></script>
<!--파퍼 자바스크립트 추가하기-->
<script src="./js/popper.js"></script>
<!--부트스트랩 자바스크립트 추가하기-->
<script src="./js/bootstrap.min.js"></script>
</body>
</html>