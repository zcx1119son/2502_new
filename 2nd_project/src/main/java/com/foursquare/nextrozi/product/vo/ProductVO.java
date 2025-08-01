package com.foursquare.nextrozi.product.vo;

import lombok.Data;
import java.sql.Date;

@Data
public class ProductVO {
    private long product_id;
    private String product_name;
    private long client_id; // tb_client와 연결될 클라이언트 ID
    private String client_name; // tb_client에서 조인하여 가져올 클라이언트 이름
    private long product_count; // 제품 수량
    private Date created_date;
    private String created_id;
    private Date updated_data;
    private String updated_id;
}