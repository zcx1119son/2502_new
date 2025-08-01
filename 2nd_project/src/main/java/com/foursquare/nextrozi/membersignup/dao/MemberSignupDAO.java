package com.foursquare.nextrozi.membersignup.dao;

import com.foursquare.nextrozi.membersignup.vo.MemberSignupVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberSignupDAO {
    int insertMember(MemberSignupVO vo);
    int checkEmailExists(String email);
}