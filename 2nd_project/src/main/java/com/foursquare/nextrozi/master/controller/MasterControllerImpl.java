package com.foursquare.nextrozi.master.controller;

import com.foursquare.nextrozi.master.service.MasterService;
import com.foursquare.nextrozi.master.vo.MasterVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("masterController")
@RequestMapping("/master")
public class MasterControllerImpl implements MasterController {

    @Autowired
    private MasterService masterService;

    // @/master/request_list.do
    @GetMapping("/request_list.do")
    public String listRequestedCompanies(
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) throws Exception {

        int limit = 20;
        int offset = (Math.max(page, 1) - 1) * limit;

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        paramMap.put("searchField", searchField);
        paramMap.put("keyword", keyword);
        paramMap.put("status", "요청"); // DDL의 STATUS 컬럼값에 맞춤

        List<MasterVO> requestList = masterService.listRequestedCompanies(paramMap);
        int totalCount = masterService.getTotalCompanyCount(paramMap);
        int totalPage = (int) Math.ceil((double) totalCount / limit);

        model.addAttribute("requestList", requestList);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchField", searchField);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPageStatus", "요청");

        return "/master/request_list";
    }


    @GetMapping("/approved_list.do")
    public String listApprovedCompanies(
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchField", required = false) String searchField,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) throws Exception {

        int limit = 20;
        int offset = (Math.max(page, 1) - 1) * limit;

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("offset", offset);
        paramMap.put("limit", limit);
        paramMap.put("searchField", searchField);
        paramMap.put("keyword", keyword);
        paramMap.put("status", "승인"); // DDL의 STATUS 컬럼값에 맞춤

        List<MasterVO> approvedList = masterService.listApprovedCompanies(paramMap);
        int totalCount = masterService.getTotalCompanyCount(paramMap);
        int totalPage = (int) Math.ceil((double) totalCount / limit);

        // 모델 속성 이름과 뷰 이름을 approved_list.jsp에 맞게 수정했습니다.
        model.addAttribute("approvedList", approvedList);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("searchField", searchField);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPageStatus", "승인");

        return "/master/approved_list";
    }


    @PostMapping("/approve_requests.do")
    @ResponseBody
    public Map<String, Object> approveCompanyRequests(@RequestBody List<String> companyCodes, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            HttpSession session = request.getSession();
            String currentUserId = (String) session.getAttribute("memberId");
            if (currentUserId == null || currentUserId.isEmpty()) {
                currentUserId = "admin"; // 세션 정보가 없으면 기본값 설정 (실제 환경에서는 로그인 처리 필요)
            }

            // DDL에 approveId가 없으므로 currentUserId를 approveId로 사용하지 않고, updatedId로 사용.
            // 서비스/DAO에서 status를 '승인'으로 바꾸고 updated_id, updated_data 업데이트
            masterService.approveCompanyRequests(companyCodes, currentUserId); // currentUserId를 업데이트 ID로 전달
            response.put("status", "success");
            response.put("message", "선택된 기업 요청이 성공적으로 승인되었습니다.");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "기업 요청 승인 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }


    @PostMapping("/delete_requests.do")
    @ResponseBody
    public Map<String, Object> deleteCompanyRequests(@RequestBody List<String> companyCodes) {
        Map<String, Object> response = new HashMap<>();
        try {
            masterService.deleteCompanyRequests(companyCodes);
            response.put("status", "success");
            response.put("message", "선택된 기업 요청이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "기업 요청 삭제 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }

    @PostMapping("/update_companies.do") // 다중 회사 정보 수정을 위한 새로운 엔드포인트
    @ResponseBody
    public Map<String, String> updateCompanies(@RequestBody List<MasterVO> companyList) {
        Map<String, String> response = new HashMap<>();
        try {
            if (companyList == null || companyList.isEmpty()) {
                response.put("status", "error");
                response.put("message", "수정할 기업 데이터가 없습니다.");
                return response;
            }

            int updatedCount = 0;
            for (MasterVO company : companyList) {
                // 각 회사별로 업데이트 로직 수행
                // company.getCompanyCode(), company.getCompanyName(), etc.
                // 실제 서비스 계층 호출
                int result = masterService.updateCompany(company); // 단일 회사 업데이트 메서드 재사용 가능
                if (result > 0) {
                    updatedCount++;
                }
            }

            if (updatedCount > 0) {
                response.put("status", "success");
                response.put("message", updatedCount + "개의 기업 정보가 성공적으로 수정되었습니다.");
            } else {
                response.put("status", "fail");
                response.put("message", "수정된 기업 정보가 없습니다. 변경 사항이 없거나 오류가 발생했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "기업 정보 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }
}
