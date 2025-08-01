package com.foursquare.nextrozi.master.service;

import com.foursquare.nextrozi.master.dao.MasterDAO;
import com.foursquare.nextrozi.master.vo.MasterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation; // 트랜잭션 관리를 위해 추가
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 관리를 위해 추가

import java.util.List;
import java.util.Map;

@Service("masterService")
@Transactional(propagation = Propagation.REQUIRED) // 서비스 계층에 트랜잭션 관리 추가 (필요시)
public class MasterServiceImpl implements MasterService {
    @Autowired
    private MasterDAO masterDAO;

    @Override
    public List<MasterVO> listRequestedCompanies(Map<String, Object> paramMap) throws Exception {
        return masterDAO.selectRequestedCompanyList(paramMap);
    }

    @Override
    public List<MasterVO> listApprovedCompanies(Map<String, Object> paramMap) throws Exception {
        return masterDAO.selectApprovedCompanyList(paramMap);
    }

    @Override
    public int getTotalCompanyCount(Map<String, Object> paramMap) throws Exception {
        return masterDAO.getTotalCompanyCountByStatus(paramMap);
    }

    @Override
    public void approveCompanyRequests(List<String> companyCodes, String updateId) throws Exception {
        int updatedRows = masterDAO.updateCompanyStatusToApproved(companyCodes, updateId);
        if (updatedRows == 0 && !companyCodes.isEmpty()) {
            throw new Exception("선택된 기업 요청 중 승인된 항목이 없습니다.");
        }
    }

    @Override
    public void deleteCompanyRequests(List<String> companyCodes) throws Exception {
        int deletedRows = masterDAO.deleteCompanies(companyCodes);
        if (deletedRows == 0 && !companyCodes.isEmpty()) {
            throw new Exception("선택된 기업 요청 중 삭제된 항목이 없습니다.");
        }
    }

    @Override
    public MasterVO getMasterCompanyByCode(String companyCode) throws Exception {
        return masterDAO.selectCompanyByCode(companyCode);
    }

    @Override
    public int updateCompany(MasterVO company) throws Exception { // Change return type to int
        int updatedRows = masterDAO.updateCompany(company);
        if (updatedRows == 0) {
            System.err.println("WARN: Failed to update company with code: " + company.getCompanyCode() + ". No rows affected or no changes.");
            // Optionally, you might still throw an exception if 0 rows updated is considered an error
            // throw new Exception("Failed to update company with code: " + company.getCompanyCode());
        }
        return updatedRows; // Return the count
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void updateCompanies(List<MasterVO> companyList) throws Exception {
        if (companyList == null || companyList.isEmpty()) {
            return;
        }

        for (MasterVO company : companyList) {
            // Call the modified updateCompany which now returns int
            int result = updateCompany(company);
            // You could potentially accumulate results or handle per-company failures here
            // if (result == 0) { /* log or handle specific company failure */ }
        }
    }
}