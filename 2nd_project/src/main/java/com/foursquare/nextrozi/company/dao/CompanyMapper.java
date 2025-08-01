package com.foursquare.nextrozi.company.dao;

import com.foursquare.nextrozi.company.vo.CompanyVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface CompanyMapper {

    List<CompanyVO> getCompanyInfo();
}