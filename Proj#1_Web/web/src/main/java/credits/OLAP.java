package credits;
import java.util.ArrayList;
import java.util.Collections;

public class OLAP implements Comparable<OLAP> {
    private String name;
    private float diff;

    public OLAP(String name, float diff) {
        this.name = name;
        this.diff = diff;
    }
    @Override
    public int compareTo(OLAP olap) {
        if (olap.diff < diff) {
            return 1;
        } else if (olap.diff > diff) {
            return -1;
        }
        return 0;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getDiff() {
        return diff;
    }

    public void setDiff(float diff) {
        this.diff = diff;
    }
}
