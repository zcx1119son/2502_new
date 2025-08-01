package com.foursquare.nextrozi.master.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@ToString // toString 메서드 자동 생성
public class MasterVO {
    private String companyCode; // COMPANY_CODE (PK)
    private String companyName; // COMPANY_NAME
    private String companyEmail; // COMPANY_EMAIL
    private String companyPwd; // COMPANY_PWD
    private String companyOwnername; // COMPANY_OWNERNAME (화면의 '등록 담당자'에 해당)
    private String companyPhone; // COMPANY_PHONE

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 날짜 포맷팅을 위한 어노테이션
    private Date createdDate; // CREATED_DATE
    private String createdId; // CREATED_ID

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 날짜 포맷팅을 위한 어노테이션
    private Date updatedData; // UPDATED_DATA (DB 컬럼명과 일치)
    private String updatedId; // UPDATED_ID

    private String status; // STATUS (요청, 승인, 반려 등)
}