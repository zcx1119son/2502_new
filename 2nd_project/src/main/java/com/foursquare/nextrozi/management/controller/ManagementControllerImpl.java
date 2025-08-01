package com.foursquare.nextrozi.management.controller;

import com.fasterxml.jackson.databind.ObjectMapper; // Jackson ObjectMapper 추가
import com.foursquare.nextrozi.management.dto.AccessRightsRequestSingleUser;
import com.foursquare.nextrozi.management.service.ManagementService;
import com.foursquare.nextrozi.management.vo.ManagementVO;
import com.foursquare.nextrozi.management.vo.MenuVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder; // RequestContextHolder 추가
import org.springframework.web.context.request.ServletRequestAttributes; // RequestContextHolder 사용을 위한 클래스 추가

import java.util.*;
import java.util.stream.Collectors;

@Controller("managementController")
@RequestMapping("/management")
public class ManagementControllerImpl implements ManagementController{

    @Autowired
    ManagementService managementService;

    // ObjectMapper 인스턴스 생성 (JSON 변환용)
    private final ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/management_list.do")
    public String listEmployees(
            @RequestParam(value ="page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "keyword", required = false)String keyword,
            Model model) throws Exception {

        int limit = 20;
        int offset = (Math.max(page, 1) - 1) * limit;

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        paramMap.put("searchField", searchField);
        paramMap.put("keyword", keyword);

        List<ManagementVO> managementList = managementService.listEmployees(paramMap);
        int totalCount = managementService.getTotalCount(paramMap);
        int totalPage = (int) Math.ceil((double) totalCount / limit);

        model.addAttribute("managementList", managementList);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchField", searchField);
        model.addAttribute("keyword", keyword);

        return "/management/comporation";
    }

    @PostMapping("/update_selected.do")
    public String updateSelectedStaff(@RequestParam(name = "selected", required = false) List<Integer> selectedmanagementIds,
                                      HttpServletRequest request) throws Exception{
        if(selectedmanagementIds != null && !selectedmanagementIds.isEmpty()){
            List<ManagementVO> updateList = new ArrayList<>();
            String currentUserId = (String) request.getSession().getAttribute("memberId");

            if (currentUserId == null || currentUserId.isEmpty()) {
                currentUserId = "SYSTEM";
                System.err.println("Warning: updateSelectedStaff - currentUserId was null or empty. Assigning default 'SYSTEM'.");
            }

            for(Integer managementId : selectedmanagementIds){
                String employeeName = request.getParameter("employee_Name_"+managementId);
                String employeePhonNumber = request.getParameter("employee_Phon_Number_"+managementId);
                String employeeEmail = request.getParameter("employee_Email_"+managementId);
                String departmentName = request.getParameter("department_Name_"+managementId);
                String position = request.getParameter("position_"+managementId);

                ManagementVO vo = new ManagementVO();
                vo.setManagement_Id(managementId);
                vo.setEmployee_Name(employeeName);
                vo.setEmployee_Phon_Number(employeePhonNumber);
                vo.setEmployee_Email(employeeEmail);
                vo.setDepartment_Name(departmentName);
                vo.setPosition(position);
                vo.setUpdate_id(currentUserId);

                updateList.add(vo);
            }
            managementService.updateSelectedStaff(updateList);
        }
        return "redirect:/management/management_list.do";
    }

    @PostMapping("/delete_selected.do")
    public String deleteSelectedStaff(@RequestParam(name = "selected", required = false) List<Integer> selectedmanagementIds) throws Exception{
        if(selectedmanagementIds != null && !selectedmanagementIds.isEmpty()){
            managementService.deleteSelectedStaff(selectedmanagementIds);
        }
        return "redirect:/management/management_list.do";
    }

    @GetMapping("/add_employee.do")
    public String openAddEmployee(){
        return "/management/add_employee";
    }

    @PostMapping("/insert.do")
    @ResponseBody
    public Map<String, Object> insertEmployee(@ModelAttribute ManagementVO managementVO, HttpServletRequest request) throws Exception {
        Map<String, Object> response = new HashMap<>();

        String currentUserId = (String) request.getSession().getAttribute("memberId");

        if (currentUserId == null || currentUserId.isEmpty()) {
            currentUserId = "SYSTEM";
            System.err.println("Warning: insertEmployee - currentUserId was null or empty. Assigning default 'SYSTEM'.");
        }

        managementVO.setCreate_id(currentUserId);
        managementVO.setUpdate_id(currentUserId);
        managementVO.setRemarks("홈"); // T_MANAGEMENT에 REMARKS 컬럼이 추가되었다면 이 값도 저장될 것임

        try {
            managementService.insertEmployee(managementVO);
            response.put("status", "success");
            response.put("message", "직원이 성공적으로 추가되었습니다.");
        } catch (DuplicateKeyException e) {
            response.put("status", "error");
            response.put("message", "이미 존재하는 사원 코드입니다. 다른 코드를 사용해주세요.");
            System.err.println("Duplicate employee ID: " + managementVO.getEmployee_Id() + " - " + e.getMessage());
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "직원 추가 중 오류가 발생했습니다: " + e.getMessage());
            System.err.println("Error inserting employee: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }

    @GetMapping("/accessRightsPopup.do")
    public String accessRightsPopup(@RequestParam("managementIds") String managementIdsStr, Model model) throws Exception {
        List<Integer> managementIds = java.util.Arrays.stream(managementIdsStr.split(","))
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        List<String> employeeNames = managementService.getEmployeeNamesByIds(managementIds);
        List<Map<String, Object>> selectedEmployeesInfo = new ArrayList<>();
        for (int i = 0; i < managementIds.size(); i++) {
            Map<String, Object> employeeInfo = new HashMap<>();
            employeeInfo.put("id", managementIds.get(i));
            employeeInfo.put("name", employeeNames.get(i));
            selectedEmployeesInfo.add(employeeInfo);
        }
        model.addAttribute("selectedEmployeesInfo", selectedEmployeesInfo); // 이 부분 확인

        List<MenuVO> menuList = managementService.getAllMenus();
        model.addAttribute("menuList", menuList); // 이 부분 확인
        // model.addAttribute("menuListJson", objectMapper.writeValueAsString(menuList)); // 이제 이 라인은 필요 없습니다.
        // JSP에서 <c:forEach>로 직접 menuList를 사용합니다.

        return "management/access_rights_popup";
    }

    @GetMapping("/getAccessRightsStatus.do")
    @ResponseBody
    public List<String> getAccessRightsStatus(@RequestParam("managementId") int managementId) throws Exception {
        return managementService.getUserMenuIds(managementId);
    }

    // --- 기존 saveAccessRights.do는 단일 사용자 저장이므로, 여러 사용자 저장을 위해 새로운 메서드 추가 ---
    // 만약 단일 사용자 저장 기능이 더 이상 필요 없다면 이 메서드를 삭제하고 saveAllAccessRights로 대체 가능
    @PostMapping("/saveAccessRights.do")
    @ResponseBody
    public Map<String, Object> saveAccessRights(@RequestBody AccessRightsRequestSingleUser request) throws Exception {
        try {
            String currentUserId = (String) ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession().getAttribute("memberId");

            if (currentUserId == null || currentUserId.isEmpty()) {
                currentUserId = "SYSTEM";
                System.err.println("Warning: saveAccessRights - currentUserId was null or empty. Assigning default 'SYSTEM'.");
            }

            request.setUpdateId(currentUserId); // DTO에 updateId 설정

            // 이 서비스 메서드는 단일 사용자에 대한 권한을 업데이트하도록 설계되어 있음
            // 리스트의 첫 번째 managementId와 해당 menuIds를 사용하여 호출
            managementService.updateUserAccessRights(
                    Collections.singletonList(request.getManagementId()), // 단일 ID를 리스트로 감싸서 전달
                    request.getMenuIds(),
                    request.getUpdateId()
            );
            return Collections.singletonMap("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    // --- 새로운 엔드포인트: 여러 직원의 접근 권한을 한 번에 저장 ---
    @PostMapping("/saveAllAccessRights.do")
    @ResponseBody
    public Map<String, Object> saveAllAccessRights(@RequestBody Map<String, List<String>> allAccessRightsData) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 현재 로그인한 사용자 ID 가져오기 (update_id에 사용)
            String currentUserId = (String) ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession().getAttribute("memberId");

            if (currentUserId == null || currentUserId.isEmpty()) {
                currentUserId = "SYSTEM";
                System.err.println("Warning: saveAllAccessRights - currentUserId was null or empty. Assigning default 'SYSTEM'.");
            }

            if (allAccessRightsData == null || allAccessRightsData.isEmpty()) {
                response.put("success", false);
                response.put("message", "저장할 접근 권한 데이터가 없습니다.");
                return response;
            }

            // 서비스 계층으로 모든 권한 데이터와 updateId를 전달
            // ManagementService 인터페이스와 구현체에 이 메서드 시그니처가 추가되어야 합니다.
            managementService.saveAllAccessRights(allAccessRightsData, currentUserId);

            response.put("success", true);
            response.put("message", "모든 직원의 접근 권한이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "접근 권한 저장 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }
}