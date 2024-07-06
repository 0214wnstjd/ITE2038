package application;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class applicationDAO {
    public int addApplication(applicationDTO applicationDTO){   //수강신청 추가
        String SQL = "insert into application values (?, ?, ?)";    //application 테이블에 입력받은 튜플 추가
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, applicationDTO.getStudent_id());
            pstmt.setInt(2, applicationDTO.getClass_id());
            pstmt.setInt(3, applicationDTO.getTime_id());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }
    public int deleteApplication(String student_id, int class_id){      //수강신청 삭제
        String SQL = "delete from application where student_id = ? and class_id = ?";   //application 테이블에서 입력받은 값 토대로 튜플 삭제
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            pstmt.setInt(2, class_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }
    public int deleteClassApplication(int class_id){    //수업 폐강시 수강신청 삭제
        String SQL = "delete from application where class_id = ?";  //application 테이블에서 해당 수업 관련 튜플 삭제
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, class_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //데이터베이스 오류
    }
    public int getHowManyApplication(int class_id) {        //해당수업 수강신청 개수 반환
        String SQL = "SELECT count(*) FROM application WHERE class_id = ?"; //applicaiton 테이블에서 해당수업관련 튜플 개수 반환
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, class_id);
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

    public ArrayList<applicationDTO> getList (String student_id){   //수강신청 전체를 Arraylist로 만들어 반환
        ArrayList<applicationDTO> applicationList = null;
        String SQL = "SELECT * FROM application where student_id = ?";  //application 테이블에서 해당 학생의 전체 attribute 받음
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,student_id);
            rs = pstmt.executeQuery();
            applicationList = new ArrayList<applicationDTO>();
            while(rs.next()){
                applicationDTO application = new applicationDTO(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getInt(3)
                );
                applicationList.add(application);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return applicationList;
    }
}
