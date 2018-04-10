package com.realsport.model.entityDao;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class Playground {
    private String idplayground;
    private String name;
    private String latitude;
    private String longitude;
    private String links;
    private String сreator;
    private String sity;
    private String street;
    private String house;
    private byte[] image;
    private String sport;
    private String info;
    private Byte school;
    private List<MinUser> players = new ArrayList<>();


    public String getIdplayground() {
        return idplayground;
    }

    public void setIdplayground(String idplayground) {
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

    public String getSport() {
        return sport;
    }

    public void setSport(String sport) {
        this.sport = sport;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }



    public Byte getSchool() {
        return school;
    }

    public void setSchool(Byte school) {
        this.school = school;
    }


    public List<MinUser> getPlayers() {
        return players;
    }

    public void setPlayers(List<MinUser> players) {
        this.players = players;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Playground that = (Playground) o;
        return idplayground == that.idplayground &&
                Objects.equals(name, that.name) &&
                Objects.equals(latitude, that.latitude) &&
                Objects.equals(longitude, that.longitude) &&
                Objects.equals(sity, that.sity) &&
                Objects.equals(street, that.street) &&
                Objects.equals(house, that.house) &&
                Objects.equals(sport, that.sport);
    }

    @Override
    public int hashCode() {

        return Objects.hash(idplayground, name, latitude, longitude, sity, street, house, sport);
    }
}
