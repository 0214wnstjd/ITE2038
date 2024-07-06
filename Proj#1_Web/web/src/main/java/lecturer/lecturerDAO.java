package lecturer;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class lecturerDAO {

    public int validLecturer(int lecturer_id) { //입력받은 교수id를 가지는 교수가 있는지 체크
        String SQL = "SELECT * FROM lecturer WHERE lecturer_id = ?";    //lecturer 테이블에서 해당lecturer_id 튜플 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, lecturer_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return 1; //교수 id 유효
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
    public String getLecturerName(int lecturer_id) {    //교수 이름 반환
        String SQL = "SELECT name FROM lecturer WHERE lecturer_id = ?";     //lecturer 테이블에서 해당lecturer_id name을 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, lecturer_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1); //교수 id 존재
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

}

