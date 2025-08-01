package com.foursquare.nextrozi.product.controller;

import com.foursquare.nextrozi.product.service.ProductService;
import com.foursquare.nextrozi.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ProductController handles web requests related to product management.
 * It interacts with the ProductService to perform business operations.
 */
@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    /**
     * Serves the main product inventory page.
     *
     * @return The name of the JSP view to render.
     */
    @GetMapping("")
    public String inventory() {
        return "product/product"; // This should match the JSP file name (e.g., inventory.jsp)
    }

    /**
     * Retrieves a paginated list of products.
     * This API endpoint is called via AJAX from the frontend.
     *
     * @param page          The current page number (0-indexed).
     * @param size          The number of items per page.
     * @param sortBy        The field to sort by (e.g., "product_id").
     * @param sortDirection The sort direction ("asc" or "desc").
     * @param searchType    The type of search criterion (e.g., "client_id", "product_id", "product_name", "client_name").
     * @param searchKeyword The keyword to search for.
     * @return A ResponseEntity containing a map with product list, total pages, and current page.
     */
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getProducts(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "product_id") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDirection,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword
    ) {
        // Create Sort object based on sortDirection
        Sort sort = Sort.by(Sort.Direction.fromString(sortDirection), sortBy);
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<ProductVO> productPage = productService.getPagedProducts(pageable, searchType, searchKeyword);

        Map<String, Object> response = new HashMap<>();
        response.put("products", productPage.getContent());
        response.put("totalPages", productPage.getTotalPages());
        response.put("currentPage", productPage.getNumber());
        response.put("totalElements", productPage.getTotalElements());

        return ResponseEntity.ok(response);
    }

    /**
     * Adds a new product to the inventory.
     *
     * @param productVO The ProductVO object containing data from the registration form.
     * @return A ResponseEntity with a success or error message.
     */
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<String> addProduct(@ModelAttribute ProductVO productVO) {
        // In a real application, you'd get created_id from the authenticated user's session
        // For demonstration, productVO.setCreated_id() is populated by the form directly (via hidden field)
        // You might want to remove the hidden field and set it from security context here.
        productVO.setCreated_date(new java.sql.Date(System.currentTimeMillis())); // Set current date

        boolean success = productService.addProduct(productVO);
        if (success) {
            return ResponseEntity.ok("제품이 성공적으로 등록되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("제품 등록에 실패했습니다.");
        }
    }

    /**
     * Retrieves a single product by its ID. Used for populating the edit modal.
     *
     * @param productId The ID of the product to retrieve.
     * @return A ResponseEntity containing the ProductVO object or an error status.
     */
    @GetMapping("/{productId}")
    @ResponseBody
    public ResponseEntity<ProductVO> getProductById(@PathVariable("productId") long productId) {
        ProductVO product = productService.getProductById(productId);
        if (product != null) {
            return ResponseEntity.ok(product);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Updates an existing product's information.
     *
     * @param productVO The ProductVO object with updated details (sent as JSON).
     * @return A ResponseEntity with a success or error message.
     */
    @PostMapping("/update") // Changed to POST as per JSP AJAX call
    @ResponseBody
    public ResponseEntity<String> updateProduct(@RequestBody ProductVO productVO) {
        // In a real application, you'd get updated_id from the authenticated user's session
        // For demonstration, productVO.setUpdated_id() is populated by the form directly (via hidden field or input)
        productVO.setUpdated_data(new java.sql.Date(System.currentTimeMillis())); // Set current date

        boolean success = productService.updateProduct(productVO);
        if (success) {
            return ResponseEntity.ok("제품 정보가 성공적으로 업데이트되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("제품 정보 업데이트에 실패했습니다.");
        }
    }

    /**
     * Deletes selected products by their IDs.
     *
     * @param productIds A list of product IDs to delete (sent as JSON array).
     * @return A ResponseEntity with a success or error message.
     */
    @PostMapping("/delete") // Changed to POST as per JSP AJAX call
    @ResponseBody
    public ResponseEntity<String> deleteProducts(@RequestBody List<Long> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return ResponseEntity.badRequest().body("삭제할 제품을 선택해주세요.");
        }
        boolean success = productService.deleteProducts(productIds);
        if (success) {
            return ResponseEntity.ok(productIds.size() + "개의 제품이 성공적으로 삭제되었습니다.");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("제품 삭제에 실패했습니다.");
        }
    }
}
