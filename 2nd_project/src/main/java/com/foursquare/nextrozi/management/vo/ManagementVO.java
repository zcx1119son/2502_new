package com.foursquare.nextrozi.management.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class ManagementVO {
    //직원등록 Id (T_MANAGEMENT의 PK, 트리거로 자동 생성)
    private int management_Id;

    //사원 Id (T_MANAGEMENT의 UNIQUE NOT NULL)
    private String employee_Id;

    //사원명 (T_MANAGEMENT의 NOT NULL)
    private String employee_Name;

    //사원 전화번호 (T_MANAGEMENT의 NOT NULL)
    private String employee_Phon_Number;

    //사원 이메일 (T_MANAGEMENT의 NOT NULL)
    private String employee_Email;

    //부서명 (T_MANAGEMENT의 NOT NULL)
    private String department_Name;

    //직급 (T_MANAGEMENT의 NOT NULL)
    private String position;

    // 등록날짜 (T_MANAGEMENT의 CREATE_DATE, 트리거로 자동 생성)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date create_date;

    // 생성자 ID (T_MANAGEMENT의 CREATE_ID, NOT NULL)
    private String create_id;

    // 수정날짜 (T_MANAGEMENT의 UPDATE_DATE, 트리거로 자동 생성)
    private Date update_date;

    // 수정자 ID (T_MANAGEMENT의 UPDATE_ID, NOT NULL)
    private String update_id;

    // !!! 이 필드는 권한 관리 로직에서 List<String>을 사용하므로 제거하는 것을 권장합니다.
    // 만약 ManagementVO를 통해 단일 메뉴ID를 삽입하는 특정 케이스가 있다면 String으로 변경 고려
    // private Integer menu_id; // <-- 이 줄을 삭제 또는 아래와 같이 변경

    // private String menu_id; // 만약 ManagementVO에 단일 menu_id가 필요하다면 String으로 변경

    // DDL에 REMARKS 컬럼이 있으므로 다시 추가합니다.
    private String remarks;

    // Mybatis에서 LISTAGG로 조합된 접근 권한 이름을 담을 필드
    private String accessRightsNames;

    @Override
    public String toString() {
        return "ManagementVO{" +
                "management_Id=" + management_Id +
                ", employee_Id='" + employee_Id + '\'' +
                ", employee_Name='" + employee_Name + '\'' +
                ", employee_Phon_Number='" + employee_Phon_Number + '\'' +
                ", employee_Email='" + employee_Email + '\'' +
                ", department_Name='" + department_Name + '\'' +
                ", position='" + position + '\'' +
                ", create_date=" + create_date +
                ", create_id='" + create_id + '\'' +
                ", update_date=" + update_date +
                ", update_id='" + update_id + '\'' +
                // ", menu_id=" + menu_id + // 필드 제거 시 toString에서도 제거
                ", remarks='" + remarks + '\'' +
                ", accessRightsNames='" + accessRightsNames + '\'' +
                '}';
    }
}