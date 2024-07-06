package hopeclass;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class hopeclassDAO {
    public int addHopeclass(hopeclassDTO hopeclassDTO){     //희망수업 추가
        String SQL = "insert into hopeclass values (?, ?)"; //hopeclass 테이블에 튜플 추가
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, hopeclassDTO.getStudent_id());
            pstmt.setInt(2, hopeclassDTO.getClass_id());
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
    public int deleteHopeclass(String student_id, int class_id){    //희망수업 삭제
        String SQL = "delete from hopeclass where student_id = ? and class_id = ?"; //hopeclass 테이블에서 해당학생 해당수업 튜플 삭제
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

    //수업폐강시 희망수업 삭제를 위해 사용
    public int deleteClassHopeclass(int class_id){  //해당수업 희망수업 삭제
        String SQL = "delete from hopeclass where class_id = ?";    //hopeclass에서 해당수업 튜플들 삭제
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

    public ArrayList<hopeclassDTO> getList (String student_id){ //희망수업 리스트 반환
        ArrayList<hopeclassDTO> hopeclassList = null;
        String SQL = "SELECT * FROM hopeclass where student_id = ?";    //hopeclass 테이블에서 해당 학생 튜플들 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,student_id);
            rs = pstmt.executeQuery();
            hopeclassList = new ArrayList<hopeclassDTO>();
            while(rs.next()){
                hopeclassDTO hopeclass = new hopeclassDTO(
                        rs.getString(1),
                        rs.getInt(2)
                );
                hopeclassList.add(hopeclass);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return hopeclassList;
    }
}
