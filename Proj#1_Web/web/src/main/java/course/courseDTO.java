package course;

public class courseDTO {
    private String course_id;
    private String name;
    private int credit;

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public courseDTO(String course_id, String name, int credit) {
        this.course_id = course_id;
        this.name = name;
        this.credit = credit;
    }
}
