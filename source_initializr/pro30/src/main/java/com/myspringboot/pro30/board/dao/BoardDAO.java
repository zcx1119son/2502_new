package com.myspringboot.pro30.board.dao;

import com.myspringboot.pro30.board.vo.ArticleVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;

import java.util.List;

@Mapper
public interface BoardDAO {

    List<ArticleVO> selectAllArticlesList() throws DataAccessException;
}