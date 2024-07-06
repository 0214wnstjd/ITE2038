package credits;

public class creditsDTO {
    private int credits_id;
    private String student_id;
    private String course_id;
    private int year;
    private String grade;

    public creditsDTO(int credits_id, String student_id, String course_id, int year, String grade) {
        this.credits_id = credits_id;
        this.student_id = student_id;
        this.course_id = course_id;
        this.year = year;
        this.grade = grade;
    }

    public int getCredits_id() {
        return credits_id;
    }

    public void setCredits_id(int credits_id) {
        this.credits_id = credits_id;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
