package com.foursquare.nextrozi.purchase.service;

import com.foursquare.nextrozi.purchase.vo.PurchaseVO;

import java.util.List;
import java.util.Map; // Import Map for pagination/search parameters

public interface PurchaseService {
    List<PurchaseVO> getPurchaseList(Map<String, Object> params); // Modified to accept parameters
    int getPurchaseCount(Map<String, Object> params); // New method for total count
    void insertPurchase(PurchaseVO purchaseVO);
    void updatepurchaseStatus(PurchaseVO purchaseVO);
    void updatePurchase(PurchaseVO purchaseVO);
}