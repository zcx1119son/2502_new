package com.myspringboot.pro30.board.service;

import com.myspringboot.pro30.board.vo.ArticleVO;

import java.util.List;

public interface BoardService {

    public List<ArticleVO> listArticles() throws Exception;
}