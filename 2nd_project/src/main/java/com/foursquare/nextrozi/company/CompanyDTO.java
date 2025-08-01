package com.foursquare.nextrozi.company; // 패키지 경로를 여기에 맞춥니다.

public class CompanyDTO {
    private String role;
    private String name;
    private String mobilePhone;
    private String departmentPhone;
    private String email;
    private String department;

    // 기본 생성자
    public CompanyDTO() {
    }

    // 모든 필드를 포함하는 생성자
    public CompanyDTO(String role, String name, String mobilePhone, String departmentPhone, String email, String department) {
        this.role = role;
        this.name = name;
        this.mobilePhone = mobilePhone;
        this.departmentPhone = departmentPhone;
        this.email = email;
        this.department = department;
    }

    // Getter 및 Setter 메서드
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getDepartmentPhone() {
        return departmentPhone;
    }

    public void setDepartmentPhone(String departmentPhone) {
        this.departmentPhone = departmentPhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "CompanyDTO{" +
                "role='" + role + '\'' +
                ", name='" + name + '\'' +
                ", mobilePhone='" + mobilePhone + '\'' +
                ", departmentPhone='" + departmentPhone + '\'' +
                ", email='" + email + '\'' +
                ", department='" + department + '\'' +
                '}';
    }
}