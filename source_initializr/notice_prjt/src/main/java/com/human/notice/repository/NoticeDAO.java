package com.human.notice.repository;

import com.human.notice.vo.NoticeVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;

import java.util.List;

@Mapper
public interface NoticeDAO {

    public List<NoticeVO> selectAllNoticeList() throws DataAccessException;
}
