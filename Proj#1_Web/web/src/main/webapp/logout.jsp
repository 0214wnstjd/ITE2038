<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    //세션종료시킴
    session.invalidate();
%>
<%--첫페이지로 돌려보냄--%>
<script>
    location.href ='index.jsp';
</script>

