package course;

import student.studentDTO;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class courseDAO {

    public int validCourse(String course_id) {  //해당과목id인 과목이 존재하는 확인
        String SQL = "SELECT * FROM course WHERE course_id = ?"; //course 테이블에서 해당 course_id 튜플 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return 1; //과목 id 유효
            }
            return -1; //아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }
    // 과목 이름 반환
    //성적 조회시 사용
    public String getName(String course_id) {
        String SQL = "SELECT name FROM course WHERE course_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, course_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return null; //데이터베이스 오류
    }

    public ArrayList<courseDTO> getList(){  //과목리스트 반환
        ArrayList<courseDTO> courseList = null;
        String SQL = "select * from course order by course_id"; //course 테이블에서 전체 과목 리스트 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            courseList = new ArrayList<courseDTO>();
            while(rs.next()){
                courseDTO course = new courseDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3)
                );
                courseList.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return courseList;
    }

}

