package com.mystringboot.pro0609.board.controller;

import com.mystringboot.pro0609.board.service.BoardService;
import com.mystringboot.pro0609.board.vo.ArticleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/board/api")
public class BoardRestController {

    @Autowired
    BoardService boardService;

    @GetMapping("/list")
    public List<ArticleVO> getArticleList() {
        List<ArticleVO> articlesList = null;
        try{
            articlesList = boardService.listArticles();
        } catch (Exception e) {
            System.out.println("오류 발생:"+e.getMessage());
        }
        return articlesList;
    }
}