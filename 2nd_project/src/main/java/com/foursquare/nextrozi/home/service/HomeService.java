package com.foursquare.nextrozi.home.service;

import com.foursquare.nextrozi.home.vo.HomeVO;
import java.util.List;

public interface HomeService {

    /**
     * 등록
     */
    int insertEvent(HomeVO homeVO);

    /**
     * 수정
     */
    int updateEvent(HomeVO homeVO);

    /**
     * 삭제
     */
    boolean removeEvent(Long eventId);

    /**
     * 단건 조회
     */
    HomeVO getEvent(Long eventId);

    /**
     * 전체 조회
     */
    List<HomeVO> listAllEvents();
}
