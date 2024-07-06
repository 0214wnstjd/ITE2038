<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="classes.classesDAO"%>
<%@ page import="classes.classesDTO"%>
<%@ page import="course.courseDAO"%>
<%@ page import="room.roomDAO"%>
<%@ page import="major.majorDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.SQLOutput" %>
<%@ page import="major.majorDAO" %>
<%@ page import="lecturer.lecturerDAO" %>
<%@ page import="room.roomDAO" %>
<%@ page import="time.timeDAO" %>
<%@ page import="time.timeDTO" %>
<%
    //로그인 여부 체크
    request.setCharacterEncoding("UTF-8");
    String id = null;
    if(session.getAttribute("id") != null){
        id = (String)session.getAttribute("id");
    }
    if(id == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('관리자 로그인 후 이용 바랍니다.');");
        script.println("location.href = 'Login.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
    //수업 데이터
    int class_id =0;
    int class_no =0;
    String course_id =null;
    String name =null;
    int major_id =0;
    int year=0;
    int credit=0;
    int lecturer_id=0;
    int person_max=0;
    int opened=0;
    int room_id=0;
    String begin = null;
    String end = null;

    if(request.getParameter("class_id") != null){
        try {
            class_id = Integer.parseInt(request.getParameter("class_id"));
        } catch (Exception e){
            System.out.println("수업 아이디 데이터 오류");
        }
    }
    if(request.getParameter("class_no") != null){
        try {
            class_no = Integer.parseInt(request.getParameter("class_no"));
        } catch (Exception e){
            System.out.println("수업 번호 데이터 오류");
        }
    }
    if(request.getParameter("course_id") != null){
        course_id = request.getParameter("course_id");
    }
    if(request.getParameter("name") != null){
        name = request.getParameter("name");
    }
    if(request.getParameter("major_id") != null){
        try {
            major_id = Integer.parseInt(request.getParameter("major_id"));
        } catch (Exception e){
            System.out.println("전공 아이디 데이터 오류");
        }
    }
    if(request.getParameter("year") != null){
        try {
            year = Integer.parseInt(request.getParameter("year"));
        } catch (Exception e){
            System.out.println("학년 데이터 오류");
        }
    }
    if(request.getParameter("credit") != null){
        try {
            credit = Integer.parseInt(request.getParameter("credit"));
        } catch (Exception e){
            System.out.println("학점 데이터 오류");
        }
    }
    if(request.getParameter("lecturer_id") != null){
        try {
            lecturer_id = Integer.parseInt(request.getParameter("lecturer_id"));
        } catch (Exception e){
            System.out.println("교수 아이디 데이터 오류");
        }
    }
    if(request.getParameter("person_max") != null){
        try {
            person_max = Integer.parseInt(request.getParameter("person_max"));
        } catch (Exception e){
            System.out.println("정원 데이터 오류");
        }
    }
    if(request.getParameter("open_id") != null){
        try {
            opened= Integer.parseInt(request.getParameter("open_id"));
        } catch (Exception e){
            System.out.println("설강 연도 데이터 오류");
        }
    }
    if(request.getParameter("room_id") != null){
        try {
            room_id = Integer.parseInt(request.getParameter("room_id"));
        } catch (Exception e){
            System.out.println("강의실 아이디 데이터 오류");
        }
    }
    if(request.getParameter("begin") != null){
        begin = request.getParameter("begin");
    }
    if(request.getParameter("end") != null){
        end = request.getParameter("end");
    }
    if (class_id == 0 || class_no == 0 || course_id == null || name== null ||
            major_id== 0 || year == 0 || credit == 0 || lecturer_id == 0
            || person_max == 0 || opened == 0 || room_id == 0 || begin == null || end == null ||
            course_id == "" || name== "" || begin == "" || end ==""
            ){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    //과목 아이디가 올바른지 체크
    courseDAO courseDAO = new courseDAO();
    int courseValid = courseDAO.validCourse(course_id);
    if (courseValid == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 과목 아이디입니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    //전공 아이디가 올바른지 체크
    majorDAO majorDAO = new majorDAO();
    int majorValid = majorDAO.validMajor(major_id);
    if (majorValid == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 전공 아이디입니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    //교수 아이디가 올바른지 체크
    lecturerDAO lecturerDAO = new lecturerDAO();
    int lecturerValid = lecturerDAO.validLecturer(lecturer_id);
    if (majorValid == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 교수 아이디입니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    //강의실 아이디 올바른지 체크
    roomDAO roomDAO = new roomDAO();
    int roomValid = roomDAO.validRoom(room_id);
    if (roomValid == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 강의실 아이디입니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (courseValid == -2 || majorValid == -2 || lecturerValid == -2 || roomValid == -2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생하였습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    //조건 : 정원이 강의실 수용인원 초과하지 않아야함
    roomDAO room = new roomDAO();
    if(person_max > room.getOccupancy(room_id)){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정원이 강의실 수용인원을 초과합니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    //조건 : 일요일은 개설할 수 없음
    //begin, end를 substring을 이용하여 형태를 변환
    timeDAO timeDAO = new timeDAO();
    String beginChanged = "1900-01-0";
    String endChanged = "1900-01-0";
    if (begin.substring(0,1).equals("일")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('일요일은 과목 개설이 불가합니다');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    else{
        if(begin.substring(0,1).equals("월")){
            beginChanged+="1";
        }
        else if(begin.substring(0,1).equals("화")){
            beginChanged+="2";
        }
        else if(begin.substring(0,1).equals("수")){
            beginChanged+="3";
        }
        else if(begin.substring(0,1).equals("목")){
            beginChanged+="4";
        }
        else if(begin.substring(0,1).equals("금")){
            beginChanged+="5";
        }
        else if(begin.substring(0,1).equals("토")){
            beginChanged+="6";
        }
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('요일을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        beginChanged+="T";
        if(Integer.parseInt(begin.substring(4,6)) > 24){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('시간을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        beginChanged+=begin.substring(4,6) +":";
        if(!begin.substring(8,10).equals("00") && !begin.substring(8,10).equals("30")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('분을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        beginChanged+=begin.substring(8,10) +":00.000Z";

    }
    if (end.substring(0,1).equals("일")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('일요일은 과목 개설이 불가합니다');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    else{
        if(end.substring(0,1).equals("월")){
            endChanged+="1";
        }
        else if(end.substring(0,1).equals("화")){
            endChanged+="2";
        }
        else if(end.substring(0,1).equals("수")){
            endChanged+="3";
        }
        else if(end.substring(0,1).equals("목")){
            endChanged+="4";
        }
        else if(end.substring(0,1).equals("금")){
            endChanged+="5";
        }
        else if(end.substring(0,1).equals("토")){
            endChanged+="6";
        }
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('요일을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        endChanged+="T";
        if(Integer.parseInt(end.substring(4,6)) > 24){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('시간을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        endChanged+=end.substring(4,6) +":";
        if(!end.substring(8,10).equals("00") && !end.substring(8,10).equals("30")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('분을 잘 못 입력하셨습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
        endChanged+=begin.substring(8,10) +":00.000Z";
    }
    classesDAO classesDAO = new classesDAO();
//수업추가
    //class_id가 중복되지 않게 현존하는 class_id의 최대값에서 +1 한 값으로 추가
    int result = classesDAO.addClass(new classesDTO(class_id, class_no, course_id, name, major_id, year, credit, lecturer_id, person_max, opened, room_id));
    if (result ==1){
        timeDAO.addTime(new timeDTO(timeDAO.maxTimeid()+1, class_id, 1 ,beginChanged, endChanged));
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수업이 정상적으로 추가 되었습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    // 오류 발생
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수업을 추가하는데 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>

