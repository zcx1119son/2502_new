package com.human.notice.controller;

import com.human.notice.service.NoticeService;
import com.human.notice.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeControllerImpl {

    @Autowired
    NoticeService noticeService;

    @GetMapping("/notice_list.do")
    public String listNotices(Model model) throws Exception{

        List<NoticeVO> noticeList = noticeService.listNotices();
        model.addAttribute("noticeList", noticeList);
        return "/notice/notice_list";
    }
}
