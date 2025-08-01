package com.foursquare.nextrozi.product.service.impl;

import com.foursquare.nextrozi.product.dao.ProductDAO;
import com.foursquare.nextrozi.product.service.ProductService;
import com.foursquare.nextrozi.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * ProductServiceImpl is the implementation of the ProductService interface.
 * It contains the business logic and interacts with the ProductDAO.
 */
@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductDAO productDAO;

    /**
     * Retrieves a paginated list of products based on search criteria.
     * Implements the business logic for fetching paged product data.
     *
     * @param pageable    Pagination information.
     * @param searchType  Type of search (e.g., "client_id", "product_id", "product_name", "client_name").
     * @param searchKeyword Keyword to search for.
     * @return A Page object containing a list of ProductVOs and pagination metadata.
     */
    @Override
    public Page<ProductVO> getPagedProducts(Pageable pageable, String searchType, String searchKeyword) {
        // Get the total count of products matching the search criteria
        long totalProducts = productDAO.countProducts(searchType, searchKeyword);

        // Get the paginated list of products
        List<ProductVO> products = productDAO.getPagedProducts(pageable, searchType, searchKeyword);

        // Create and return a Page object
        return new PageImpl<>(products, pageable, totalProducts);
    }

    /**
     * Adds a new product to the system.
     * This operation is transactional to ensure data consistency.
     *
     * @param productVO The ProductVO object containing the product data.
     * @return true if the product was added successfully, false otherwise.
     */
    @Override
    @Transactional
    public boolean addProduct(ProductVO productVO) {
        // Here you could add additional business logic, e.g., validation
        return productDAO.addProduct(productVO) > 0;
    }

    /**
     * Retrieves a product by its ID.
     *
     * @param productId The ID of the product.
     * @return The ProductVO object if found, otherwise null.
     */
    @Override
    public ProductVO getProductById(long productId) {
        return productDAO.getProductById(productId);
    }

    /**
     * Updates an existing product.
     *
     * @param productVO The ProductVO object with updated details.
     * @return true if the product was updated successfully, false otherwise.
     */
    @Override
    @Transactional
    public boolean updateProduct(ProductVO productVO) {
        // Add any business validation or logic before updating
        return productDAO.updateProduct(productVO) > 0;
    }

    /**
     * Deletes a single product by ID.
     *
     * @param productId The ID of the product to delete.
     * @return true if the product was deleted successfully, false otherwise.
     */
    @Override
    @Transactional
    public boolean deleteProduct(long productId) {
        return productDAO.deleteProduct(productId) > 0;
    }

    /**
     * Deletes multiple products by their IDs.
     * This operation is transactional to ensure atomicity.
     *
     * @param productIds A list of product IDs to delete.
     * @return true if all selected products were deleted successfully, false otherwise.
     */
    @Override
    @Transactional
    public boolean deleteProducts(List<Long> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return false;
        }
        // The DAO method returns the number of affected rows.
        // We check if the number of deleted rows matches the number of IDs provided.
        return productDAO.deleteProductsByIds(productIds) == productIds.size();
    }
}
