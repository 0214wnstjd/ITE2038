package hopeclass;

public class hopeclassDTO {
    private String student_id;
    private int class_id;

    public hopeclassDTO(String student_id, int class_id) {
        this.student_id = student_id;
        this.class_id = class_id;
    }

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
}
