package student;

public class studentDTO {
    private String student_id;
    private String password;
    private String name;
    private String sex;
    private int major_id;
    private int lecturer_id;
    private int year;

    private int state;

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getMajor_id() {
        return major_id;
    }

    public void setMajor_id(int major_id) {
        this.major_id = major_id;
    }

    public int getLecturer_id() {
        return lecturer_id;
    }

    public void setLecturer_id(int lecturer_id) {
        this.lecturer_id = lecturer_id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public studentDTO(){
    }

    public studentDTO(String student_id, String password, String name, String sex, int major_id, int lecturer_id, int year, int state) {
        this.student_id = student_id;
        this.password = password;
        this.name = name;
        this.sex = sex;
        this.major_id = major_id;
        this.lecturer_id = lecturer_id;
        this.year = year;
        this.state = state;
    }
}
