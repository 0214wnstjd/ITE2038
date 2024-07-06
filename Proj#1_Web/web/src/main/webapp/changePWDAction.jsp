<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = null;
    String password = null;
    if(session.getAttribute("id") != null){
        id = (String)session.getAttribute("id");
    }
    if(request.getParameter("password") != null){
        password = request.getParameter("password");
    }
    if(password == null || password == ""){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    studentDAO studentDAO = new studentDAO();
    int result = studentDAO.changePWD(id, password);            //비밀번호 변경
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 정상적으로 변경되었습니다.');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호 변경에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>

