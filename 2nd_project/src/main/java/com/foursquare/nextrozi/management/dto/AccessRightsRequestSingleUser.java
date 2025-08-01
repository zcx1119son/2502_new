package com.foursquare.nextrozi.management.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
public class AccessRightsRequestSingleUser {
    private int managementId;
    private List<String> menuIds;
    private String updateId; // 사용자 ID를 저장하기 위한 필드
}