package com.realsport.model.entityDao.pojo;

import java.util.Arrays;

/**
 * Created by IgorR on 02.07.2017.
 */
public class Voleyball {
    private int idvoleyball;
    private String name;
    private String latitude;
    private String longitude;
    private String links;
    private String сreator;
    private String sity;
    private String street;
    private String house;
    private byte[] image;
    private String subject;
    private String info;
    private String size;
    private String coating;
    private Byte school;

    public int getIdvoleyball() {
        return idvoleyball;
    }

    public void setIdvoleyball(int idvoleyball) {
        this.idvoleyball = idvoleyball;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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

    public String getСreator() {
        return сreator;
    }

    public void setСreator(String сreator) {
        this.сreator = сreator;
    }

    public String getSity() {
        return sity;
    }

    public void setSity(String sity) {
        this.sity = sity;
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

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getCoating() {
        return coating;
    }

    public void setCoating(String coating) {
        this.coating = coating;
    }

    public Byte getSchool() {
        return school;
    }

    public void setSchool(Byte school) {
        this.school = school;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Voleyball voleyball = (Voleyball) o;

        if (idvoleyball != voleyball.idvoleyball) return false;
        if (name != null ? !name.equals(voleyball.name) : voleyball.name != null) return false;
        if (latitude != null ? !latitude.equals(voleyball.latitude) : voleyball.latitude != null) return false;
        if (longitude != null ? !longitude.equals(voleyball.longitude) : voleyball.longitude != null) return false;
        if (links != null ? !links.equals(voleyball.links) : voleyball.links != null) return false;
        if (сreator != null ? !сreator.equals(voleyball.сreator) : voleyball.сreator != null) return false;
        if (sity != null ? !sity.equals(voleyball.sity) : voleyball.sity != null) return false;
        if (street != null ? !street.equals(voleyball.street) : voleyball.street != null) return false;
        if (house != null ? !house.equals(voleyball.house) : voleyball.house != null) return false;
        if (!Arrays.equals(image, voleyball.image)) return false;
        if (subject != null ? !subject.equals(voleyball.subject) : voleyball.subject != null) return false;
        if (info != null ? !info.equals(voleyball.info) : voleyball.info != null) return false;
        if (size != null ? !size.equals(voleyball.size) : voleyball.size != null) return false;
        if (coating != null ? !coating.equals(voleyball.coating) : voleyball.coating != null) return false;
        if (school != null ? !school.equals(voleyball.school) : voleyball.school != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idvoleyball;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (latitude != null ? latitude.hashCode() : 0);
        result = 31 * result + (longitude != null ? longitude.hashCode() : 0);
        result = 31 * result + (links != null ? links.hashCode() : 0);
        result = 31 * result + (сreator != null ? сreator.hashCode() : 0);
        result = 31 * result + (sity != null ? sity.hashCode() : 0);
        result = 31 * result + (street != null ? street.hashCode() : 0);
        result = 31 * result + (house != null ? house.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(image);
        result = 31 * result + (subject != null ? subject.hashCode() : 0);
        result = 31 * result + (info != null ? info.hashCode() : 0);
        result = 31 * result + (size != null ? size.hashCode() : 0);
        result = 31 * result + (coating != null ? coating.hashCode() : 0);
        result = 31 * result + (school != null ? school.hashCode() : 0);
        return result;
    }
}
