package classes;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class classesDAO {
    public int addClass(classesDTO classesDTO){     //수업 추가
        String SQL = "insert into class values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";  //class 테이블에 해당 튜플 추가
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, classesDTO.getClass_id());
            pstmt.setInt(2, classesDTO.getClass_no());
            pstmt.setString(3, classesDTO.getCourse_id());
            pstmt.setString(4, classesDTO.getName());
            pstmt.setInt(5, classesDTO.getMajor_id());
            pstmt.setInt(6, classesDTO.getYear());
            pstmt.setInt(7, classesDTO.getCredit());
            pstmt.setInt(8, classesDTO.getLecturer_id());
            pstmt.setInt(9, classesDTO.getPerson_max());
            pstmt.setInt(10, classesDTO.getOpened());
            pstmt.setInt(11, classesDTO.getRoom_id());
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

    public int deleteClass(int class_id){       //수업 삭제
        String SQL = "delete from class where class_id = ?";    //class 테이블에서 해당 튜플 삭제
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

    public ArrayList<classesDTO> getList (String searchType, String search, int pageNumber){    //class 테이블 리스트로 반환
        ArrayList<classesDTO> classesList = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            if(searchType.equals("전체")){    //전체 검색시, class 테이블에서 튜플 6개씩 불러옴
                SQL = "select * from class where opened = 2022 order by class_id limit "+ pageNumber*5 +", "+pageNumber*5+6;
            }
            else if(searchType.equals("수업번호")){ //수업번호 지정검색시, class 테이블에서 수업번호 일치하는 튜플 6개씩 불러옴
                SQL = "select * from class where opened = 2022 and class_no = ? order by class_id limit "+ pageNumber*5+", "+pageNumber*5+6;
            }
            else if(searchType.equals("학수번호")){ //학수번호 지정검색시, class 테이블에서 학수번호 일치하는 튜플 6개씩 불러옴
                SQL = "select * from class where opened = 2022 and course_id = ? order by class_id limit "+ pageNumber*5+", "+pageNumber*5+6;
            }
            else if(searchType.equals("교과목명")){ //교과목명 키워드검색시, class 테이블에서 입력값 포함된 교과목명 가진 튜플 6개씩 불러옴
                SQL = "select * from class where opened = 2022 and name like ? order by class_id limit "+ pageNumber*5+", "+pageNumber*5+6;
            }
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            if(searchType.equals("수업번호") || searchType.equals("학수번호")) {
                pstmt.setString(1, search);
            }
            if(searchType.equals("교과목명")){
                pstmt.setString(1, "%"+search+"%");
            }
            rs = pstmt.executeQuery();
            classesList = new ArrayList<classesDTO>();
            while(rs.next()){
                classesDTO classes = new classesDTO(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getInt(11)
                );
                classesList.add(classes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return classesList;
    }
    public int getPersonMax(int class_id) { //수업 정원 반환
        String SQL = "SELECT person_max FROM class WHERE class_id = ?"; //class 테이블에서 해당 수업 person_max 불러옴
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
    public int getClassno(int class_id) {   //수업번호 반환
        String SQL = "SELECT class_no FROM class WHERE class_id = ?";   //class 테이블에서 해당 수업 claas_no 불러옴
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
    public String getCourseid(int class_id) {   //학수번호 반환
        String SQL = "SELECT course_id FROM class WHERE class_id = ?"; //class 테이블에서 해당 수업 course_id 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, class_id);
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
    public String getName(int class_id) {   //수업 이름 반환
        String SQL = "SELECT name FROM class WHERE class_id = ?";   //class 테이블에서 해당 수업 name 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, class_id);
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
    public int getLecturerid(int class_id) {    //담당교수id 반환
        String SQL = "SELECT lecturer_id FROM class WHERE class_id = ?";    //class 테이블에서 해당 수업 lecturer_id 불러옴
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
    public int getRoomid(int class_id) {    //강의실id 반환
        String SQL = "SELECT room_id FROM class WHERE class_id = ?";    //class 테이블에서 해당 수업 room_id 불러옴
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
    public int getCredit(int class_id) {    //학점 반환
        String SQL = "SELECT credit FROM class WHERE class_id = ?"; //class 테이블에서 해당 수업 credit 불러옴
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

    public int changeMax(int class_id, int max) {   //수업 정원 변경
        String SQL = "update class set person_max = ? where class_id = ?";  //class 테이블에서 해당 수업 person_max 변경
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, max);
            pstmt.setInt(2, class_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //정원 변경 실패
    }

}
