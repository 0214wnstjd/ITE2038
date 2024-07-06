package building;

public class buildingDTO {
    private int building_id;
    private String name;
    private String admin;
    private int rooms;

    public buildingDTO(int building_id, String name, String admin, int rooms) {
        this.building_id = building_id;
        this.name = name;
        this.admin = admin;
        this.rooms = rooms;
    }

    public int getBuilding_id() {
        return building_id;
    }

    public void setBuilding_id(int building_id) {
        this.building_id = building_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public int getRooms() {
        return rooms;
    }

    public void setRooms(int rooms) {
        this.rooms = rooms;
    }
}
