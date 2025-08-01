package com.foursquare.nextrozi.company.controller;

import com.foursquare.nextrozi.company.service.CompanyService;
import com.foursquare.nextrozi.company.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; // @Controller 사용
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody; // @ResponseBody 추가

import java.util.List;

@Controller // @RestController 대신 @Controller 사용
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private CompanyService companyService;

    // 초기 페이지 로드용 (HTML 반환)
    @GetMapping("") // JSP 페이지를 보여줄 요청 경로
    public String companyView() {
        return "company/company"; // views/company/company.jsp 로 이동
    }

    // AJAX 요청을 처리하여 JSON 데이터 반환
    @GetMapping("/data") // 데이터를 가져올 AJAX 요청 경로
    @ResponseBody // 이 메서드가 반환하는 데이터를 HTTP 응답 본문에 직접 작성하도록 지시
    public List<CompanyVO> getCompanyData() {
        List<CompanyVO> companyList = companyService.getCompanyInfo();
        return companyList; // Spring이 이 List<CompanyVO>를 JSON으로 자동 변환합니다.
    }
}