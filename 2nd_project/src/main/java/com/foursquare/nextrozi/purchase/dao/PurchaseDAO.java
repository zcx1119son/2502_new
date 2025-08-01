package com.foursquare.nextrozi.purchase.dao;

import com.foursquare.nextrozi.purchase.vo.PurchaseVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map; // Import Map

@Mapper
public interface PurchaseDAO {
    List<PurchaseVO> getPurchaseList(Map<String, Object> params); // Modified
    int getPurchaseCount(Map<String, Object> params); // New
    void insertPurchase(PurchaseVO purchaseVO);
    void updatepurchaseStatus(PurchaseVO purchaseVO);
    void updatePurchase(PurchaseVO purchaseVO);
}