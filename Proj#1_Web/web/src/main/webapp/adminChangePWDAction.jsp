<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.admin"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String password = null;
    if(request.getParameter("password") != null){
        password = request.getParameter("password");
    }
    if(password == null || password =="") {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    admin.setPwd(password);
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('비밀번호가 정상적으로 변경되었습니다.');");
    script.println("location.href = 'admin.jsp'");
    script.println("</script>");
    script.close();
    return;
%>

