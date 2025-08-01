package com.foursquare.nextrozi.master.service;

import com.foursquare.nextrozi.master.vo.MasterVO;
import java.util.List;
import java.util.Map;

public interface MasterService {
    // DAO 메서드명 변경에 맞춰 업데이트
    List<MasterVO> listRequestedCompanies(Map<String, Object> paramMap) throws Exception;
    List<MasterVO> listApprovedCompanies(Map<String, Object> paramMap) throws Exception;
    int getTotalCompanyCount(Map<String, Object> paramMap) throws Exception; // 메서드명 변경 예정: getTotalCompanyCountByStatus

    // 기존 메서드명 유지 (서비스 계층에서는 더 추상적으로 유지)
    void approveCompanyRequests(List<String> companyCodes, String approveId) throws Exception;
    void deleteCompanyRequests(List<String> companyCodes) throws Exception;

    // 단일 기업 정보 조회 및 업데이트 메서드는 그대로 유지
    MasterVO getMasterCompanyByCode(String companyCode) throws Exception;

    int updateCompany(MasterVO company) throws Exception;

    void updateCompanies(List<MasterVO> companyList) throws Exception;
}