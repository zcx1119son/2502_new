package com.mystringboot.pro0609.board.service;

import com.mystringboot.pro0609.board.dao.BoardDAO;
import com.mystringboot.pro0609.board.vo.ArticleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService{

    @Autowired
    BoardDAO boardDAO;

    @Override
    public List<ArticleVO> listArticles() throws Exception{
        List<ArticleVO> articlesList = boardDAO.selectAllArticlesList();
        return articlesList;
    }
}