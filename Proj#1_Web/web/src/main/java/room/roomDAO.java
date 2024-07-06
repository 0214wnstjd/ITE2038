package room;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class roomDAO {

    public int validRoom(int room_id) { //입력받은 강의실id를 가지는 강의실이 존재하는지 체크
        String SQL = "SELECT * FROM room WHERE room_id = ?";    //room 테이블에서 해당room_id 튜플 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, room_id);
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

    public int getOccupancy(int room_id) {  //수용인원 반환
        String SQL = "SELECT occupancy FROM room WHERE room_id = ?";    //room 테이블에서 해당room_id occupancy 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, room_id);
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
    public int getBuildingId(int room_id) { //건물id 반환
        String SQL = "SELECT building_id FROM room WHERE room_id = ?";  //room테이블에서 해당room_id building_id 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, room_id);
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
}

