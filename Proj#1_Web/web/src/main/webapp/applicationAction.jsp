<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="student.studentDAO"%>
<%@ page import="application.applicationDAO"%>
<%@ page import="time.timeDAO"%>
<%@ page import="classes.classesDAO"%>
<%@ page import="application.applicationDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="credits.creditsDAO" %>
<%@ page import="util.admin" %>
<%
    //로그인체크
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
    studentDAO studentDAO = new studentDAO();
    classesDAO classesDAO = new classesDAO();
    applicationDAO applicationDAO = new applicationDAO();
    //관리자 로그인이라면 수강허용 action
    if(id.equals(admin.getId())){
        id = request.getParameter("student_id");
        if (studentDAO.validStudentid(id) != 1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('올바르지 않은 학생 아이디입니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
        }
        else if(applicationDAO.getHowManyApplication(class_id) == classesDAO.getPersonMax(class_id)){
            classesDAO.changeMax(class_id, classesDAO.getPersonMax(class_id) + 1);  //관리자가 따로 수강허용할시 정원이 꽉차도 1 늘리고 추가
        }
    }

    int time_id = 0;
    int totalCredit = 0;
    timeDAO timeDAO = new timeDAO();
    time_id = timeDAO.getTimeId(class_id);
    creditsDAO creditsDAO = new creditsDAO();
    ArrayList<applicationDTO> applicationList = new ArrayList<applicationDTO>();
    applicationList = new applicationDAO().getList(id);
    if(applicationList != null)
        for(int i = 0; i < applicationList.size(); i++) {
            applicationDTO applications = applicationList.get(i);
            totalCredit += classesDAO.getCredit(applications.getClass_id());
        }
    if(creditsDAO.getCreditid(id, classesDAO.getCourseid(class_id)) != -1 && creditsDAO.getCreditid(id, classesDAO.getCourseid(class_id)) != -2) {
        PrintWriter script = response.getWriter();
        if (creditsDAO.getHighestGrade(id, classesDAO.getCourseid(class_id)) >= 3.0) {      //재수강 B0 이상 실패 조건
            script.println("<script>");
            script.println("alert('B0이상 성적을 받은 과목은 재수강 할 수 없습니다.');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
    }
        String begin = timeDAO.getTimeBegin(time_id);
        if(!begin.equals("E러닝") && !begin.equals("미지정")){           //동일 시간대 수강 여부 조건
            String end = timeDAO.getTimeEnd(time_id);
            String beginD = begin.substring(0,1);
            String beginHH = begin.substring(7,8);
            String beginMM = begin.substring(10,12);
            String endD = end.substring(0,1);
            String endHH = end.substring(7,8);
            String endMM = end.substring(10,12);
            if(applicationList != null)
                for(int i = 0; i < applicationList.size(); i++) {
                    applicationDTO applications = applicationList.get(i);
                    String tempBegin= timeDAO.getTimeBegin(applications.getTime_id());
                    String tempEnd= timeDAO.getTimeEnd(applications.getTime_id());
                    if(tempBegin.substring(0,1).equals(beginD)){
                        if(Integer.parseInt(beginHH) >= Integer.parseInt(tempBegin.substring(7,8))
                                && Integer.parseInt(beginHH) <= Integer.parseInt(tempEnd.substring(7,8))
                            || Integer.parseInt(endHH) >= Integer.parseInt(tempBegin.substring(7,8))
                                && Integer.parseInt(endHH) <= Integer.parseInt(tempEnd.substring(7,8))){
                            if(beginHH.equals(tempEnd.substring(7,8))
                                    && Integer.parseInt(beginMM) >= Integer.parseInt(tempEnd.substring(10,12))){;}
                            if(endHH.equals(tempBegin.substring(7,8))
                                    && Integer.parseInt(endMM) <= Integer.parseInt(tempBegin.substring(10,12))){;}
                            else{
                                PrintWriter script = response.getWriter();
                                script.println("<script>");
                                script.println("alert('동일 시간대에 2개 이상의 과목은 신청이 불가합니다.');");
                                script.println("history.back()");
                                script.println("</script>");
                                script.close();
                                return;
                            }
                        }
                    }
                }
        }
    if(totalCredit + classesDAO.getCredit(class_id) > 18){         //최대 학점 조건
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('최대 수강 가능 학점을 초과하였습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if(applicationDAO.getHowManyApplication(class_id) >= classesDAO.getPersonMax(class_id) ){      //정원 초과 조건
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정원을 초과하였습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    int result = applicationDAO.addApplication(new applicationDTO(id, class_id, time_id));
    if (result ==1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강신청이 완료되었습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강신청에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


%>

