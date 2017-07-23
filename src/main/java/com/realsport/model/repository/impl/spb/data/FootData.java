package com.realsport.model.repository.impl.spb.data;

/**
 * Created by IgorR on 08.07.2017.
 */
public enum FootData {
    PLAYGROUND_1("1", "Школа 29", "55.750338", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис","Кораблестроителей", "21", "true"),
    PLAYGROUND_2("2", "Школа 29", "55.750008", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис", "Кораблестроителей", "22", "true"),
    PLAYGROUND_4("4", "Школа 29", "55.750118", "48.739751", "https://chat.whatsapp.com/9x1D6AEXv34JEuMXqhJhos", "https://vk.com/igor_ryabtcev","Иннополис", "Кораблестроителей", "23", "true"),
    PLAYGROUND_5("5", "Школа №12", "59.944858", "30.219880", "https://chat.whatsapp.com/GA8i4Xyfm0uLMVsLDgGGNW", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Кораблестроителей", "21", "true"),
    PLAYGROUND_6("6", "Светлановский, 5", "60.004867", "30.335858", "https://chat.whatsapp.com/B5jwqxaoBdN2sACYdR9SQb", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "Светлановский пр.", "5", "false"),
    PLAYGROUND_7("7", "Школа №90", "60.033307", "30.324836", "https://chat.whatsapp.com/7KBJyUUDFt090VrMI3sV3s", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Сикейроса", "5", "true"),
    PLAYGROUND_8("8", "Гимназия №73", "60.040004", "30.327709", "https://chat.whatsapp.com/8yrZPs9s8vE52Gi2pbCql9", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Энгельса", "115", "true"),
    PLAYGROUND_9("9", "Лицей №263", "60.046712", "30.333845", "https://chat.whatsapp.com/LrThczVjQn9ATQCsqEwO4I", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Есенина", "22", "true"),
    PLAYGROUND_10("10", "Опочинина, 10", "59.932666", "30.237443", "https://chat.whatsapp.com/AWjKELuSLTd8bC49SdrPNF", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Опочинина", "10", "false"),
    PLAYGROUND_11("11", "Школа №2", "59.944071", "30.222838", "https://chat.whatsapp.com/1eqYzWTEbjWGFlOD1EwM0K", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Наличная", "32к2", "true"),
    PLAYGROUND_12("12", "Школа №518", "60.047551", "30.335708", "https://chat.whatsapp.com/7yqYAkIOs8W59eS1ZrB4yc", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Есенина", "24", "true"),
    PLAYGROUND_13("13", "Карташихина улица, 19", "59.935642", "30.240288", "https://chat.whatsapp.com/DLiTL30SQDxIsM7Ikckk7J", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Карташихина ", "19", "false"),
    PLAYGROUND_14("14", "Школа №6", "59.930148", "30.247321", "https://chat.whatsapp.com/8tIr8EL5qXCLud4dnK028u", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "ул. Шевченко ", "3А", "true"),
    PLAYGROUND_15("15", "Школа №4", "59.929510", "30.251619", "https://chat.whatsapp.com/KWh5WtwC9Ks9fz2VfEPPik", "https://vk.com/igor_ryabtcev", "Санкт-Петербург", "пр. Большой", "88Б", "true"),
    ;



    FootData(String id, String name, String lattitude, String longitude, String links, String creator, String city, String street, String house, String subject) {
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


    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
}
