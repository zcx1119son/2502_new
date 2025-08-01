package com.foursquare.nextrozi.management.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date; // java.util.Date를 사용하는 것이 일반적입니다.

@Getter
@Setter
@NoArgsConstructor
public class MenuVO {
    private String menu_id; // <<-- int에서 String으로 변경
    private String menu_name;
    private String menu_path;
    private int menu_order;
    private String is_active;
    private Date create_date; // java.util.Date로 변경하는 것을 고려 (Spring의 DateTimeFormat과 호환)
    private String create_id;
    private Date update_date; // java.util.Date로 변경하는 것을 고려
    private String update_id;
}