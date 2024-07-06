package time;

import classes.classesDTO;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class timeDAO {

    public int getTimeId(int class_id) {    //타임id 반환
        String SQL = "SELECT time_id FROM time WHERE class_id = ? and period = 1";  //time 테이블에서 해당수업 time_id 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, class_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return rs.getInt(1); // time id 반환
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -2; //데이터베이스 오류
    }

    public String getTimeBegin(int time_id) {   //시작시간 반환
        String SQL = "SELECT begin FROM time WHERE time_id = ?";    //time 테이블에서 해당시간 시작시간 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String day = null;
        String hh = null;
        String mm = null;
        String begin = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, time_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals("NO")){
                    return "미지정";
                }
                day = rs.getString(1).substring(9, 10);     //요일부분
                hh = rs.getString(1).substring(11, 13);     //시간부분
                if(Integer.parseInt(hh) >= 6 ){
                    return "E러닝";
                }
                mm = rs.getString(1).substring(14,16);      //분 부분
                if(day.equals("1")){
                    day = "월요일";
                }
                if(day.equals("2")){
                    day = "화요일";
                }
                if(day.equals("3")){
                    day = "수요일";
                }
                if(day.equals("4")){
                    day = "목요일";
                }
                if(day.equals("5")){
                    day = "금요일";
                }
                if(day.equals("6")){
                    return "E러닝";
                }
                begin = day+" 오후 "+hh.substring(1)+"시 "+mm+"분";     //시간형태로 변환
                return begin;

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
    public String getTimeEnd(int time_id) { //종료시간 반환
        String SQL = "SELECT end FROM time WHERE time_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String day = null;
        String hh = null;
        String mm = null;
        String end = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, time_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                day = rs.getString(1).substring(9, 10);
                hh = rs.getString(1).substring(11, 13);
                mm = rs.getString(1).substring(14,16);
                if(day.equals("1")){
                    day = "월요일";
                }
                if(day.equals("2")){
                    day = "화요일";
                }
                if(day.equals("3")){
                    day = "수요일";
                }
                if(day.equals("4")){
                    day = "목요일";
                }
                if(day.equals("5")){
                    day = "금요일";
                }
                if(day.equals("6")){
                    return "E러닝";
                }
                end = day+" 오후 "+hh.substring(1)+"시 "+mm+"분";
                return end;
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
    public int maxTimeid(){ //time_id 최대값 반환
    String SQL = "select max(time_id) from time";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
        try {
        conn = DatabaseUtil.getConnection();
        pstmt = conn.prepareStatement(SQL);
        rs = pstmt.executeQuery();
        if(rs.next()){
            return rs.getInt(1); // 최고값 Time Id 반환
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally{
        try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
        try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
        try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
    }
        return -2; //데이터베이스 오류
}

    public int addTime(timeDTO timeDTO){    //타임 추가
        String SQL = "insert into time values (?, ?, ?, ?, ?)"; //time 테이블에 튜플 추가
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, timeDTO.getTime_id());
            pstmt.setInt(2, timeDTO.getClass_id());
            pstmt.setInt(3, timeDTO.getPeriod());
            pstmt.setString(4, timeDTO.getBegin());
            pstmt.setString(5, timeDTO.getEnd());
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

    public int deleteTime(int time_id){ //타임 삭제
        String SQL = "delete from time where time_id = ?";  //time 테이블에서 해당타임 삭제
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, time_id);
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

}

