package com.foursquare.nextrozi.company.service;


import com.foursquare.nextrozi.company.dao.CompanyMapper;
import com.foursquare.nextrozi.company.service.CompanyService;
import com.foursquare.nextrozi.company.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private CompanyMapper companyMapper;

    @Override
    public List<CompanyVO> getCompanyInfo() {
        return companyMapper.getCompanyInfo();
    }
}