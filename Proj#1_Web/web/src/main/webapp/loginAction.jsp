<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="student.studentDTO"%>
<%@ page import="util.admin"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = null;
    String password = null;
    if(request.getParameter("id") != null){
        id = request.getParameter("id");
    }
    if(request.getParameter("password") != null){
        password = request.getParameter("password");
    }
    //아이디 패스워드 다 입력했는지 확인
    if(id == null || password == null || id =="" || password ==""){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    //관리자 로그인 체크박스 체크여부 확인
    String adminOrNot = request.getParameter("admin");
    admin admin = new admin();
    if (adminOrNot != null ){
        if(id.equals(admin.getId()) && password.equals(admin.getPwd())){
            session.setAttribute("id", id);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('관리자 페이지로 이동합니다.');");
            script.println("location.href = 'admin.jsp'");
            script.println("</script>");
            script.close();
            return;
        }
        else{
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('관리자 로그인에 실패하였습니다.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }
    }
    studentDAO studentDAO = new studentDAO();
    int result = studentDAO.login(id, password);
    if (result ==1){
        session.setAttribute("id", id);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디가 존재하지 않습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>

