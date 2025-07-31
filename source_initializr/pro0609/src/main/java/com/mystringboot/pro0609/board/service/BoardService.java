package com.mystringboot.pro0609.board.service;

import com.mystringboot.pro0609.board.vo.ArticleVO;
import java.util.List;

public interface BoardService {

    public List<ArticleVO> listArticles() throws Exception;
}