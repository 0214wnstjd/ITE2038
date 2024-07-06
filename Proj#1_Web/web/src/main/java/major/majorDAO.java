package major;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class majorDAO {

    public int validMajor(int major_id) {   //입력받은 전공id를 가지는 전공이 있는지 체크
        String SQL = "SELECT * FROM major WHERE major_id = ?";  //major테이블에서 해당major_id 튜플 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, major_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return 1; //전공 id 유효
            }
            return -1; //전공 id 없음
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }

    public String getName(int major_id) {   //전공 이름 반환
        String SQL = "SELECT name FROM major WHERE major_id = ?";   //major 테이블에서 해당major_id name 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, major_id);
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
        return null; // 데이터베이스 오류
    }

}


