package com.realsport.model.entityDao;

import java.util.Arrays;

public class Playground {
    private int idplayground;
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
    private String institutions;

    public int getIdplayground() {
        return idplayground;
    }

    public void setIdplayground(int idplayground) {
        this.idplayground = idplayground;
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

    public String getInstitutions() {
        return institutions;
    }

    public void setInstitutions(String institutions) {
        this.institutions = institutions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Playground that = (Playground) o;

        if (idplayground != that.idplayground) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (latitude != null ? !latitude.equals(that.latitude) : that.latitude != null) return false;
        if (longitude != null ? !longitude.equals(that.longitude) : that.longitude != null) return false;
        if (links != null ? !links.equals(that.links) : that.links != null) return false;
        if (сreator != null ? !сreator.equals(that.сreator) : that.сreator != null) return false;
        if (sity != null ? !sity.equals(that.sity) : that.sity != null) return false;
        if (street != null ? !street.equals(that.street) : that.street != null) return false;
        if (house != null ? !house.equals(that.house) : that.house != null) return false;
        if (!Arrays.equals(image, that.image)) return false;
        if (subject != null ? !subject.equals(that.subject) : that.subject != null) return false;
        if (info != null ? !info.equals(that.info) : that.info != null) return false;
        if (size != null ? !size.equals(that.size) : that.size != null) return false;
        if (coating != null ? !coating.equals(that.coating) : that.coating != null) return false;
        if (school != null ? !school.equals(that.school) : that.school != null) return false;
        return institutions != null ? institutions.equals(that.institutions) : that.institutions == null;
    }

    @Override
    public int hashCode() {
        int result = idplayground;
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
        result = 31 * result + (institutions != null ? institutions.hashCode() : 0);
        return result;
    }
}
