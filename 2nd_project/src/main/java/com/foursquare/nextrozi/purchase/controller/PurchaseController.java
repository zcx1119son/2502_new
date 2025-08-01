package com.foursquare.nextrozi.purchase.controller;

import com.foursquare.nextrozi.purchase.service.PurchaseService;
import com.foursquare.nextrozi.purchase.vo.PurchaseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;

    @GetMapping("")
    public String purchasePage(Model model) {
        return "purchase/purchase";
    }

    @GetMapping("/list.do")
    @ResponseBody
    public Map<String, Object> getPurchaseList(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "purchaseStatus", required = false) Integer purchaseStatus, // New parameter
            @RequestParam(value = "searchType", required = false) String searchType, // Existing
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword // Existing
    ) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", (page - 1) * pageSize);
        params.put("limit", pageSize);

        if (purchaseStatus != null) {
            params.put("purchase_status", purchaseStatus);
        }
        if (searchType != null && !searchType.isEmpty() && searchKeyword != null && !searchKeyword.isEmpty()) {
            params.put("searchType", searchType);
            params.put("searchKeyword", searchKeyword);
        }

        List<PurchaseVO> list = purchaseService.getPurchaseList(params);
        int totalCount = purchaseService.getPurchaseCount(params);

        Map<String, Object> response = new HashMap<>();
        response.put("list", list);
        response.put("totalCount", totalCount);
        response.put("currentPage", page);
        response.put("pageSize", pageSize);
        return response;
    }

    @PostMapping("/insert.do")
    @ResponseBody
    public String insertPurchase(@RequestBody PurchaseVO purchaseVO) {
        try {
            // product_id, client_id, member_id will be looked up by name in the XML mapper
            purchaseService.insertPurchase(purchaseVO);
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL";
        }
    }

    @PostMapping("/update.do") // New endpoint for updating a full purchase record
    @ResponseBody
    public String updatePurchase(@RequestBody PurchaseVO purchaseVO) {
        try {
            // Ensure purchase_id is present for update
            if (purchaseVO.getPurchase_id() == 0) { // Assuming 0 is not a valid ID for existing records
                return "FAIL: Missing purchase ID for update.";
            }
            purchaseService.updatePurchase(purchaseVO);
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL: " + e.getMessage();
        }
    }

    @PostMapping("/updateStatus.do")
    @ResponseBody
    public String updatepurchaseStatus(@RequestBody PurchaseVO purchaseVO) {
        try {
            // Ensure purchase_id is present for update
            if (purchaseVO.getPurchase_id() == 0) { // Assuming 0 is not a valid ID for existing records
                return "FAIL: Missing purchase ID for status update.";
            }
            purchaseService.updatepurchaseStatus(purchaseVO);
            return "SUCCESS";
        } catch (Exception e) {
            e.printStackTrace();
            return "FAIL: " + e.getMessage();
        }
    }
}