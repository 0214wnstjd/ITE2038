<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    //로그인체크
    request.setCharacterEncoding("UTF-8");
    String id = null;
    int state =0;
    if(request.getParameter("student_id") != null){
        id = request.getParameter("student_id");
    }
    //학적 값 받아옴
    if(request.getParameter("state") != null){
        try{
           state = Integer.parseInt(request.getParameter("state"));
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    if(id == null || state == 0 || id ==""){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    studentDAO studentDAO = new studentDAO();
    int result = studentDAO.changeState(id, state);             //학적 변경
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('학적 변경에 성공하였습니다.');");
        script.println("location.href = 'adminStudent.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>