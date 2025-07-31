package com.myspringboot.pro30.board.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
public class ArticleVO {

    private int  level;
    private int articleNO;
    private int parentNO;
    private String title;
    private String content;
    private String id;
    private Date writeDate;
}