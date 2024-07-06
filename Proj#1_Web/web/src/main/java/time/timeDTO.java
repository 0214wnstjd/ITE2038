package time;

public class timeDTO {
    private int time_id;
    private int class_id;
    private int period;
    private String begin;
    private String end;

    public timeDTO(int time_id, int class_id, int period, String begin, String end) {
        this.time_id = time_id;
        this.class_id = class_id;
        this.period = period;
        this.begin = begin;
        this.end = end;
    }

    public int getTime_id() {
        return time_id;
    }

    public void setTime_id(int time_id) {
        this.time_id = time_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public String getBegin() {
        return begin;
    }

    public void setBegin(String begin) {
        this.begin = begin;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
}
