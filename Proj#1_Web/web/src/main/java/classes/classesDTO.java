package classes;

public class classesDTO {
    int class_id;
    int class_no;
    String course_id;
    String name;
    int major_id;
    int year;
    int credit;
    int lecturer_id;
    int person_max;
    int opened;
    int room_id;

    public classesDTO() {
    }

    public classesDTO(int class_id) {
        this.class_id = class_id;
    }

    public classesDTO(int class_id, int class_no, String course_id, String name, int major_id, int year, int credit, int lecturer_id, int person_max, int opened, int room_id) {
        this.class_id = class_id;
        this.class_no = class_no;
        this.course_id = course_id;
        this.name = name;
        this.major_id = major_id;
        this.year = year;
        this.credit = credit;
        this.lecturer_id = lecturer_id;
        this.person_max = person_max;
        this.opened = opened;
        this.room_id = room_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getClass_no() {
        return class_no;
    }

    public void setClass_no(int class_no) {
        this.class_no = class_no;
    }

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

    public int getMajor_id() {
        return major_id;
    }

    public void setMajor_id(int major_id) {
        this.major_id = major_id;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public int getLecturer_id() {
        return lecturer_id;
    }

    public void setLecturer_id(int lecturer_id) {
        this.lecturer_id = lecturer_id;
    }

    public int getPerson_max() {
        return person_max;
    }

    public void setPerson_max(int person_max) {
        this.person_max = person_max;
    }

    public int getOpened() {
        return opened;
    }

    public void setOpened(int opened) {
        this.opened = opened;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }
}
