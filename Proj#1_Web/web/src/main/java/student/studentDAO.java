package student;

import classes.classesDTO;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class studentDAO {
    public int login(String student_id, String password) {  //로그인
        String SQL = "SELECT password FROM student WHERE student_id= ?";    //student 테이블에서 해당student_id password 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                if(rs.getString(1).equals(password)){   //불러온 password와 입력한 password 일치시
                    return 1; //로그인 성공
                }
                else {
                    return 0; //비밀번호 틀림
                }
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

    public int changePWD(String student_id, String password) {  //비밀번호 변경
        String SQL = "update student set password = ? where student_id = ?";    //student 테이블에서 해당 student_id password 변경
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, password);
            pstmt.setString(2, student_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //비번 변경 실패
    }
    public int changeState(String student_id, int state) {  //학적 변경
        String SQL = "update student set state = ? where student_id = ?";   //student 테이블에서 해당학생 학적 변경
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, state);
            pstmt.setString(2, student_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return -1; //학적 변경 실패
    }
    public int validStudentid(String student_id) {  //해당 student_id를 가진 student가 있는지 체크
        String SQL = "SELECT * FROM student WHERE student_id = ?";  //student 테이블에서 해당 student_id 튜플 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, student_id);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return 1; //student id 유효
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

    //DB에서 student tuple을 받아 만든
    //studentDTO를 담은 arraylist를 만들어 반환
    public ArrayList<studentDTO> getList(){
        ArrayList<studentDTO> studentList = null;
        String SQL = "select * from student order by student_id";   //student테이블에서 튜플들 불러옴
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            studentList = new ArrayList<studentDTO>();
            while(rs.next()){
                studentDTO student = new studentDTO(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getInt(8)
                );
                studentList.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try{if(conn!=null) conn.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(pstmt!=null) pstmt.close(); } catch (Exception e){ e.printStackTrace();}
            try{if(rs!=null) rs.close(); } catch (Exception e){ e.printStackTrace();}
        }
        return studentList;
    }


}
