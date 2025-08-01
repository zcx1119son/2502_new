package com.foursquare.nextrozi.management.dto;

import java.util.List;

public class AccessRightsRequest {
    private List<Integer> managementIds;
    private List<Integer> menuIds;

    // Getters and Setters
    public List<Integer> getManagementIds() {
        return managementIds;
    }

    public void setManagementIds(List<Integer> managementIds) {
        this.managementIds = managementIds;
    }

    public List<Integer> getMenuIds() {
        return menuIds;
    }

    public void setMenuIds(List<Integer> menuIds) {
        this.menuIds = menuIds;
    }
}