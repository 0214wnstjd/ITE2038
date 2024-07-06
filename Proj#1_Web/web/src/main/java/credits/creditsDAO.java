package credits;

import classes.classesDTO;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class creditsDAO {
    //모든 select문에 case when은 성적을 평점으로 표현하기 위함

    //재수강 B0이상 조건 체크시 사용
    //해당 학수번호에서 받은 가장 높은 성적 반환
    public int getHighestGrade(String student_id, String course_id ) {
        //credits 테이블에서 해당 학생 해당 과목 grade를 평점으로 치환해서 제일 큰 값 불러옴
        String SQL = "SELECT case when grade = 'A+' then 4.5 when grade = 'A0' then 4.0 when grade = 'B+' then 3.5 when grade = 'B0' then 3.0 when grade = 'C+' then 2.5 when grade = 'C0' then 2.0 when grade = 'D+' then 1.5 when grade = 'D0' then 1.0 when grade = 'F' then 0.0 else 0.0 end as gradeNum FROM credits where student_id = ? and course_id = ? order by gradeNum desc limit 1";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            pstmt.setString(2, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }

    //특정 학생의 평점 평균 구함
    public float getAverageGradeStudent(String student_id) {
        //credits테이블에서 해당 학생 grade를 평점으로 치환해서 평균값 불러옴
        String SQL = "SELECT avg(gradeNum) as gradeAverage from (select case when grade = 'A+' then 4.5 when grade = 'A0' then 4.0 when grade = 'B+' then 3.5 when grade = 'B0' then 3.0 when grade = 'C+' then 2.5 when grade = 'C0' then 2.0 when grade = 'D+' then 1.5 when grade = 'D0' then 1.0 when grade = 'F' then 0.0 else 0.0 end as gradeNum from credits where student_id = ?) as a";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }

    //특정 과목 평균 반환
    public float getAverageGradeCourse(String course_id) {
        //credits 테이블에서 해당 과목 grade를 평점으로 치환해 평균값 불러옴
        String SQL = "SELECT avg(gradeNum) as gradeAverage from (select case when grade = 'A+' then 4.5 when grade = 'A0' then 4.0 when grade = 'B+' then 3.5 when grade = 'B0' then 3.0 when grade = 'C+' then 2.5 when grade = 'C0' then 2.0 when grade = 'D+' then 1.5 when grade = 'D0' then 1.0 when grade = 'F' then 0.0 else 0.0 end as gradeNum from credits where course_id = ?) as a";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }

    //학생이 같은 수업에 성적이 몇개인지 반환
    public int getHowManyTime(String student_id, String course_id) {
        //credits 테이블에서 해당학생 해당과목 튜플들 개수 불러옴
        String SQL = "select count(*) from credits where student_id = ? and course_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            pstmt.setString(2, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }

    //성적id 반환
    //재수강여부 체크할때 사용
    public int getCreditid(String student_id, String course_id) {
        //credits테이블에서 해당학생 해당과목 credits_id 불러옴
        String SQL = "SELECT credits_id FROM credits WHERE student_id = ? and course_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            pstmt.setString(2, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
            return -1; //수강 기록 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }

    public int getHowManyStudent(String course_id) {    //해당과목에 성적이 몇개인지 반환
        //credits테이블에서 해당학생 해당과목 credits_id 불러옴
        String SQL = "SELECT count(*) FROM credits WHERE course_id = ?";    //credits 테이블에서 해당과목 튜플개수 반환
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
            return -1; //수강 기록 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }

    //평점 반환
    public float getCredit(String student_id, String course_id) {
        //credits테이블에서 해당학생 해당과목 grade를 평점으로 치환해 불러옴, 여러개면 평균을 불러옴
        String SQL = "select avg(gradeNum) from (SELECT case when grade = 'A+' then 4.5 when grade = 'A0' then 4.0 when grade = 'B+' then 3.5 when grade = 'B0' then 3.0 when grade = 'C+' then 2.5 when grade = 'C0' then 2.0 when grade = 'D+' then 1.5 when grade = 'D0' then 1.0 when grade = 'F' then 0.0 else 0.0 end as gradeNum FROM credits WHERE student_id = ? and course_id = ?) as a";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            pstmt.setString(2, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getFloat(1);
            }
            return -1; //수강 기록 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }

    //성적표 출력을 위한 credits arraylist 를 반환
    public ArrayList<creditsDTO> getList (String student_id){
        ArrayList<creditsDTO> creditsList = null;
        //credits테이블에서 해당학생 튜플들을 year 순으로, 같으면 credits_id 순으로 불러옴
        String SQL = "SELECT * FROM credits WHERE student_id= ? order by year, credits_id";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {

            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            creditsList = new ArrayList<creditsDTO>();
            while(rs.next()){
                creditsDTO credits = new creditsDTO(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5)
                );
                creditsList.add(credits);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return creditsList;
    }
}

