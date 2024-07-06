package application;

public class applicationDTO {
    private String student_id;
    private int class_id;
    private int time_id;
    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getTime_id() {
        return time_id;
    }

    public void setTime_id(int time_id) {
        this.time_id = time_id;
    }

    public applicationDTO(String student_id, int class_id) {
        this.student_id = student_id;
        this.class_id = class_id;
    }

    public applicationDTO() {
    }

    public applicationDTO(String student_id, int class_id, int time_id) {
        this.student_id = student_id;
        this.class_id = class_id;
        this.time_id = time_id;
    }
}
