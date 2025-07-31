package com.myspringboot.pro30.board.controller;


import com.myspringboot.pro30.board.service.BoardService;
import com.myspringboot.pro30.board.vo.ArticleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @GetMapping("/listArticles")
    public String listArticles(Model model) throws Exception{

        //게시판 리스트를 조회해 온다.
        List<ArticleVO> articlesList = boardService.listArticles();
        model.addAttribute("articlesList", articlesList);

        return "/board/listArticles";
    }
}
