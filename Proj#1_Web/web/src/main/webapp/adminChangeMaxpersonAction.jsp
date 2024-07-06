<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="classes.classesDAO" %>
<%@ page import="application.applicationDAO" %>
<%@ page import="room.roomDAO" %>
<%
    //로그인 체크
    request.setCharacterEncoding("UTF-8");
    int class_id = 0;
    int max = 0;
    if(request.getParameter("class_id") != null){
        try{
            class_id = Integer.parseInt(request.getParameter("class_id"));
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    if(request.getParameter("max") != null){
        try{
            max = Integer.parseInt(request.getParameter("max"));
        } catch (Exception e){
            e.printStackTrace();
        }
    }
    if( max == 0 ){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 되지 않았습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    applicationDAO applicationDAO = new applicationDAO();
    if(max < applicationDAO.getHowManyApplication(class_id)){           //현재 변경하려는 정원이 수강신청한 인원보다 적은지 체크
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강신청 인원이 변경하려는 정원을 초과합니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    roomDAO room = new roomDAO();
    classesDAO classesDAO = new classesDAO();
    if(max > room.getOccupancy(classesDAO.getRoomid(class_id))){            //정원이 강의실 수용인원 초과하는지 체크
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('변경하려는 정원이 강의실 수용인원을 초과합니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    int result = classesDAO.changeMax(class_id,max);                //정원 변경
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정원이 정상적으로 변경되었습니다.');");
        script.println("location.href = 'adminClass.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정원 변경에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>

