package com.realsport.model.repository.impl.spb.data;

/**
 * Created by IgorR on 08.07.2017.
 */
public enum FootData {
    PLAYGROUND_1("1", "Школа 29", "55.750338", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис"),
    PLAYGROUND_2("2", "Школа 29", "55.750008", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис"),
    PLAYGROUND_4("4", "Школа 29", "55.750118", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис");



    FootData(String id, String name, String lattitude, String longitude, String links, String creator, String city) {
        this.id = id;
        this.name = name;
        this.lattitude = lattitude;
        this.longitude = longitude;
        this.links = links;
        this.creator = creator;
        this.city = city;
    }

    private String id;
    private String name;
    private String lattitude;
    private String longitude;
    private String links;
    private String creator;
    private String city;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLattitude() {
        return lattitude;
    }

    public void setLattitude(String lattitude) {
        this.lattitude = lattitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLinks() {
        return links;
    }

    public void setLinks(String links) {
        this.links = links;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
