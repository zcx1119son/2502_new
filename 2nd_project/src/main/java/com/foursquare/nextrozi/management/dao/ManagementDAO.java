package com.foursquare.nextrozi.management.dao;

import com.foursquare.nextrozi.management.vo.ManagementVO;
import com.foursquare.nextrozi.management.vo.MenuVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface ManagementDAO {
    List<ManagementVO> selectAllEmployeeList(Map<String, Object> paramMap) throws DataAccessException;
    int updateSelectedStaff(List<ManagementVO> updateList) throws DataAccessException;
    int deleteSelectedStaff(List<Integer> selectedmanagementIds) throws DataAccessException;
    int getTotalCountByEmployee(Map<String, Object> paramMap) throws DataAccessException;
    int insertEmployee(ManagementVO managementVO) throws DataAccessException;
    int insertDefaultAccessRights(ManagementVO managementVO) throws DataAccessException;
    ManagementVO selectedEmployeeByStaffId(int managementId) throws DataAccessException;

    List<String> selectEmployeeNamesByIds(List<Integer> managementIds) throws DataAccessException;
    List<MenuVO> selectAllMenus() throws DataAccessException; // 모든 메뉴를 가져옴 (팝업창 버튼 생성용)

    // !!! 여기 수정됨: 반환 타입을 List<String>으로 변경 !!!
    List<String> selectUserMenuIds(int managementId) throws DataAccessException;

    // 기존 접근 권한 삭제 메서드
    int deleteAccessRightsByManagementId(@Param("managementId") int managementId) throws DataAccessException;

    // 새로운 접근 권한 삽입 메서드: 여러 menuId를 한 번에 삽입
    int insertAccessRights(Map<String, Object> paramMap) throws DataAccessException;

    // !!! 이 메서드는 더 이상 필요 없을 가능성이 높으므로 주석 처리하거나 삭제 고려 !!!
    // int insertSpecificMenuAccessWithId(ManagementVO managementVO) throws DataAccessException;

    // 단일 메뉴ID 삽입 메서드: remarks 필드가 매퍼에서 NULL로 처리되므로 여기서는 제거
    // !!! 여기 수정됨: remarks 파라미터 제거 !!!
    int insertSingleAccessRight(@Param("managementId") int managementId,
                                @Param("menuId") String menuId,
                                @Param("updateId") String updateId) throws DataAccessException;
}