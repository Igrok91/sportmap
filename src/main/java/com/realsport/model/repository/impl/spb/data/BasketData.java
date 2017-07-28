package com.realsport.model.repository.impl.spb.data;

/**
 * Created by IgorR on 08.07.2017.
 */
public enum BasketData {
    PLAYGROUND_1("1", "Коломенская, 31", "59.922996", "30.351791", "https://chat.whatsapp.com/DSiKkPD0afb0ioLPCs5yT4", "https://vk.com/igor_ryabtcev","Санкт-Петербург", "ул. Коломенская", "31", "false"),
    PLAYGROUND_2("2", "Школа №60", "60.035953", "30.349570", "https://chat.whatsapp.com/Hyvgyf6SQqkEa6Ubr6v57y", "https://vk.com/igor_ryabtcev","Санкт-Петербург", "пр. Художников", "9к3", "true"),
    PLAYGROUND_3("3", "ул. Славы", "60.059276", "30.479679", "https://chat.whatsapp.com/ABbCDGpjpAxKAhUEZryhoL", "https://vk.com/igor_ryabtcev","Санкт-Петербург", "ул. Славы", "", "false"),
    ;



    BasketData(String id, String name, String lattitude, String longitude, String links, String creator, String city, String street, String house, String subject) {
        this.id = id;
        this.name = name;
        this.lattitude = lattitude;
        this.longitude = longitude;
        this.links = links;
        this.creator = creator;
        this.city = city;
        this.street = street;
        this.house = house;
        this.subject = subject;
    }

    private String id;
    private String name;
    private String lattitude;
    private String longitude;
    private String links;
    private String creator;
    private String city;
    private String street;
    private String house;
    private String subject;

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

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getHouse() {
        return house;
    }

    public void setHouse(String house) {
        this.house = house;
    }
}
