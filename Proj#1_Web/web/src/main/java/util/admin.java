package util;

public class admin {    //관리자

    static private String id = "admin";
    static private String pwd = "1234";

    public admin(String id, String pwd) {
        this.id = id;
        this.pwd = pwd;
    }

    public admin() {
    }

    public static String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public static String getPwd() {
        return pwd;
    }

    public static void setPwd(String pw) {
        pwd=pw;
    }
}

