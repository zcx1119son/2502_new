package com.foursquare.nextrozi.purchase.service;

import com.foursquare.nextrozi.purchase.dao.PurchaseDAO;
import com.foursquare.nextrozi.purchase.vo.PurchaseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map; // Import Map

@Service
public class PurchaseServiceImpl implements PurchaseService {

    @Autowired
    private PurchaseDAO purchaseDAO;

    @Override
    public List<PurchaseVO> getPurchaseList(Map<String, Object> params) {
        return purchaseDAO.getPurchaseList(params);
    }

    @Override
    public int getPurchaseCount(Map<String, Object> params) {
        return purchaseDAO.getPurchaseCount(params);
    }

    @Override
    public void insertPurchase(PurchaseVO purchaseVO) {
        purchaseDAO.insertPurchase(purchaseVO);
    }

    @Override
    public void updatepurchaseStatus(PurchaseVO purchaseVO) {
        purchaseDAO.updatepurchaseStatus(purchaseVO);
    }

    @Override
    public void updatePurchase(PurchaseVO purchaseVO) {
        purchaseDAO.updatePurchase(purchaseVO);
    }
}