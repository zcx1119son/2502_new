package com.mystringboot.pro0609.board.controller;

import com.mystringboot.pro0609.board.service.BoardService;
import com.mystringboot.pro0609.board.vo.ArticleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardControllerImpl implements BoardController{

    @Autowired
    BoardService boardService;

    @GetMapping("/listArticles")
    public String listArticle(Model model) throws Exception {

        List<ArticleVO> articlesList = boardService.listArticles();
        model.addAttribute("articlesList", articlesList);
        return "board/listArticles";
    }
}