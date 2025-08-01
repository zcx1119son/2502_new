package com.foursquare.nextrozi.management.service;

import com.foursquare.nextrozi.management.dao.ManagementDAO;
import com.foursquare.nextrozi.management.vo.ManagementVO;
import com.foursquare.nextrozi.management.vo.MenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service("managementService")
@Transactional(propagation = Propagation.REQUIRED)
public class ManagementServiceImpl implements ManagementService{

    @Autowired
    ManagementDAO managementDAO;

    @Override
    public List<ManagementVO> listEmployees(Map<String, Object> paramMap) throws Exception {
        return managementDAO.selectAllEmployeeList(paramMap);
    }

    @Override
    public int getTotalCount(Map<String, Object> paramMap) throws Exception {
        return managementDAO.getTotalCountByEmployee(paramMap);
    }

    @Override
    public void updateSelectedStaff(List<ManagementVO> updateList) throws Exception {
        managementDAO.updateSelectedStaff(updateList);
    }

    @Override
    public void deleteSelectedStaff(List<Integer> selectedmanagementIds) throws Exception {
        managementDAO.deleteSelectedStaff(selectedmanagementIds);
    }

    @Override
    public void insertEmployee(ManagementVO managementVO) throws Exception {
        managementDAO.insertEmployee(managementVO);
        // 기본 접근 권한 ('홈') 설정
        managementDAO.insertDefaultAccessRights(managementVO);
    }

    @Override
    public List<String> getEmployeeNamesByIds(List<Integer> managementIds) throws Exception {
        return managementDAO.selectEmployeeNamesByIds(managementIds);
    }

    @Override
    public List<MenuVO> getAllMenus() throws Exception {
        return managementDAO.selectAllMenus();
    }

    @Override
    public List<String> getUserMenuIds(int managementId) throws Exception {
        // !!! 여기 수정됨: DAO가 이제 List<String>을 바로 반환하므로 변환 로직 제거 !!!
        return managementDAO.selectUserMenuIds(managementId);
    }

    @Override
    public void updateUserAccessRights(List<Integer> managementIds, List<String> menuIds, String updateId) throws Exception {
        // 이 메서드는 단일 managementId에 대해 호출될 것으로 예상됩니다.
        // 리스트의 첫 번째 ID만 사용
        if (managementIds != null && !managementIds.isEmpty()) {
            Integer managementId = managementIds.get(0);

            // 1. 해당 직원의 기존 권한을 모두 삭제
            managementDAO.deleteAccessRightsByManagementId(managementId);

            // 2. 새로운 권한 목록을 삽입
            if (menuIds != null && !menuIds.isEmpty()) {
                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("managementId", managementId);
                paramMap.put("menuIds", menuIds);
                paramMap.put("updateId", updateId); // updateId 전달

                managementDAO.insertAccessRights(paramMap);
            }
        }
    }

    @Override
    public void saveAllAccessRights(Map<String, List<String>> allAccessRightsData, String updateId) throws Exception {
        for (Map.Entry<String, List<String>> entry : allAccessRightsData.entrySet()) {
            String managementIdStr = entry.getKey();
            // managementId가 Integer 타입이므로 String -> Integer 변환
            Integer managementId = Integer.parseInt(managementIdStr);
            List<String> menuIds = entry.getValue();

            // 1. 해당 직원의 기존 권한을 모두 삭제
            managementDAO.deleteAccessRightsByManagementId(managementId);

            // 2. 새로운 권한 목록을 삽입
            if (menuIds != null && !menuIds.isEmpty()) {
                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("managementId", managementId);
                paramMap.put("menuIds", menuIds);
                paramMap.put("updateId", updateId); // updateId 전달

                managementDAO.insertAccessRights(paramMap);
            }
        }
    }
}