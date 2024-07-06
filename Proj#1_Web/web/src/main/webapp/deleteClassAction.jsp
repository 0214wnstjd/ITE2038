<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="classes.classesDAO"%>
<%@ page import="course.courseDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="time.timeDAO" %>
<%@ page import="application.applicationDAO" %>
<%@ page import="hopeclass.hopeclassDAO" %>
<%
    //관리자 로그인 체크
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
    int class_id =0;
    if(request.getParameter("class_id") != null){
        try {
            class_id = Integer.parseInt(request.getParameter("class_id"));
        } catch (Exception e){
            System.out.println("수업 아이디 데이터 오류");
        }
    }
    if (class_id == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 되지않았습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    timeDAO timeDAO = new timeDAO();
    applicationDAO applicationDAO = new applicationDAO();
    hopeclassDAO hopeclassDAO = new hopeclassDAO();
    classesDAO classesDAO = new classesDAO();
    int result = classesDAO.deleteClass(class_id);      //수업삭제
    if (result ==1){
        timeDAO.deleteTime(timeDAO.getTimeId(class_id));        //time에서 해당 수업 삭제
        applicationDAO.deleteClassApplication(class_id);    //수강신청리스트에서 해당 수업 신청리시트 삭제
        hopeclassDAO.deleteClassHopeclass(class_id);        //희망수업리스트에서 해당 수업 담기리스트 삭제
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수업이 정상적으로 삭제 되었습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수업을 삭제하는데 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>

