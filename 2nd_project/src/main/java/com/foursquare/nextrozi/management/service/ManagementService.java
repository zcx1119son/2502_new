package com.foursquare.nextrozi.management.service;

import com.foursquare.nextrozi.management.vo.ManagementVO;
import com.foursquare.nextrozi.management.vo.MenuVO;

import java.util.List;
import java.util.Map;

public interface ManagementService {
    List<ManagementVO> listEmployees(Map<String, Object> paramMap) throws Exception;
    int getTotalCount(Map<String, Object> paramMap) throws Exception;
    void updateSelectedStaff(List<ManagementVO> updateList) throws Exception;
    void deleteSelectedStaff(List<Integer> selectedmanagementIds) throws Exception;
    void insertEmployee(ManagementVO managementVO) throws Exception;
    List<String> getEmployeeNamesByIds(List<Integer> managementIds) throws Exception;
    List<MenuVO> getAllMenus() throws Exception;
    List<String> getUserMenuIds(int managementId) throws Exception;
    // 단일 사용자용:
    void updateUserAccessRights(List<Integer> managementIds, List<String> menuIds, String updateId) throws Exception;

    // 다중 사용자용 (새로 추가):
    void saveAllAccessRights(Map<String, List<String>> allAccessRightsData, String updateId) throws Exception;
}