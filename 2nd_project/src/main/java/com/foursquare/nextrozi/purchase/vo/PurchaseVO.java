package com.foursquare.nextrozi.purchase.vo;

import lombok.Data;
import java.sql.Date;

@Data
public class PurchaseVO {
    private long purchase_id; // Corresponds to purchase_id in tb_purchase table
    private long product_id;
    private String product_name; // For displaying and for lookup in insert/update
    private long client_id;
    private String client_name; // For displaying and for lookup in insert/update
    private long member_id;
    private String member_name; // For displaying and for lookup in insert/update
    private long purchase_count; // Mapped to purchase_count in DB
    private int purchase_status; // 0: 출고전, 1: 출고 완료
    private Date created_date;
    private String created_id; // Mapped to CREATED_ID in DB
    private Date updated_data; // Mapped to UPDATED_DATA in DB
    private String updated_id; // Mapped to UPDATED_ID in DB
}