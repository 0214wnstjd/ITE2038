<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="hopeclass.hopeclassDAO" %>
<%@ page import="hopeclass.hopeclassDTO" %>
<%
    //로그인 체크
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
    hopeclassDAO hopeclassDAO = new hopeclassDAO();
    int result = hopeclassDAO.addHopeclass(new hopeclassDTO(id, class_id));  //희망수업 추가
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('희망수업 담기가 완료되었습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('희망수업 담기에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>

