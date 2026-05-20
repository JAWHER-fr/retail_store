package com.electronicstore.model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password;
    private String phoneNumber;
    private String address;
    private String gender;
    private String profilePhoto; // ✅ nouveau champ

    public User() {}

    public User(int id, String fullName, String email, String password,
                String phoneNumber, String address, String gender, String profilePhoto) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.gender = gender;
        this.profilePhoto = profilePhoto;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getProfilePhoto() { return profilePhoto; }
    public void setProfilePhoto(String profilePhoto) { this.profilePhoto = profilePhoto; }

    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + "', email='" + email + "'}";
    }
}