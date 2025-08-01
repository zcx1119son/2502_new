package com.foursquare.nextrozi.master.dao;

import com.foursquare.nextrozi.master.vo.MasterVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface MasterDAO {

    List<MasterVO> selectRequestedCompanyList(Map<String, Object> paramMap) throws DataAccessException;
    List<MasterVO> selectApprovedCompanyList(Map<String, Object> paramMap) throws DataAccessException;
    int getTotalCompanyCountByStatus(Map<String, Object> paramMap) throws DataAccessException;

    // approveId 대신 updateId로 파라미터 명 변경 (매퍼에서 참조할 이름)
    int updateCompanyStatusToApproved(@Param("companyCodes") List<String> companyCodes,
                                      @Param("updateId") String updateId) throws DataAccessException;

    int deleteCompanies(@Param("companyCodes") List<String> companyCodes) throws DataAccessException;

    MasterVO selectCompanyByCode(@Param("companyCode") String companyCode) throws DataAccessException;
    int updateCompany(MasterVO company) throws DataAccessException;
}