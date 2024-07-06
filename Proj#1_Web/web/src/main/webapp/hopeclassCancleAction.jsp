<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="student.studentDTO"%>
<%@ page import="application.applicationDAO"%>
<%@ page import="time.timeDAO"%>
<%@ page import="classes.classesDAO"%>
<%@ page import="application.applicationDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="hopeclass.hopeclassDAO" %>
<%
    //로그인여부 체크
    String id = null;
    int class_id =0;
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
    if(request.getParameter("class_id") !=null) {
        try {
            class_id = Integer.parseInt(request.getParameter("class_id"));
        } catch(Exception e){
            System.out.println("강의 아이디 데이터 오류");
        }
    }
    //희망수업취소
    hopeclassDAO hopeclassDAO = new hopeclassDAO();
    classesDAO classesDAO = new classesDAO();
    int result = hopeclassDAO.deleteHopeclass(id, class_id);
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('희망 취소가 완료되었습니다.');");
        script.println("location.href = 'showHopeclass.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('희망 취소에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>

