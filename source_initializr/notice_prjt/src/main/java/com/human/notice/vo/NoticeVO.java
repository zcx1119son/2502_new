package com.human.notice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class NoticeVO {
    private int idx;
    private String category;
    private String title;
    private String content;
    private Date regdate;
    private Date update;
    private String status;
}
