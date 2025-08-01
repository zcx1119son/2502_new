package com.foursquare.nextrozi.home.service;

import com.foursquare.nextrozi.home.dao.HomeDAO;
import com.foursquare.nextrozi.home.vo.HomeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HomeServiceImpl implements HomeService {

    @Autowired
    private HomeDAO homeDAO;

    /**
     * 등록
     */
    @Override
    public int insertEvent(HomeVO homeVO) {
        return homeDAO.insertEvent(homeVO);
    }

    /**
     * 수정
     */
    @Override
    public int updateEvent(HomeVO homeVO) {
        return homeDAO.updateEvent(homeVO);
    }

    /**
     * 삭제
     */
    @Override
    public boolean removeEvent(Long eventId) {
        return homeDAO.deleteEvent(eventId) > 0;
    }

    /**
     * 단건 조회
     */
    @Override
    public HomeVO getEvent(Long eventId) {
        return homeDAO.getEventById(eventId);
    }

    /**
     * 전체 조회
     */
    @Override
    public List<HomeVO> listAllEvents() {
        return homeDAO.getAllEvents();
    }
}
