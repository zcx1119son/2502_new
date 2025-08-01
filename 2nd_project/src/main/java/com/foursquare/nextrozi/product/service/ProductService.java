package com.foursquare.nextrozi.product.service;

import com.foursquare.nextrozi.product.vo.ProductVO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * ProductService defines the business logic interface for product operations.
 * It acts as an intermediary between the Controller and the DAO.
 */
public interface ProductService {

    /**
     * Retrieves a paginated list of products based on search criteria.
     *
     * @param pageable    Pagination information.
     * @param searchType  Type of search (e.g., "customer_id", "product_id", "product_name").
     * @param searchKeyword Keyword to search for.
     * @return A Page object containing a list of ProductVOs and pagination metadata.
     */
    Page<ProductVO> getPagedProducts(Pageable pageable, String searchType, String searchKeyword);

    /**
     * Adds a new product.
     *
     * @param productVO The ProductVO object containing the product data.
     * @return true if the product was added successfully, false otherwise.
     */
    boolean addProduct(ProductVO productVO);

    /**
     * Retrieves a product by its ID.
     *
     * @param productId The ID of the product.
     * @return The ProductVO object if found, otherwise null.
     */
    ProductVO getProductById(long productId);

    /**
     * Updates an existing product.
     *
     * @param productVO The ProductVO object with updated details.
     * @return true if the product was updated successfully, false otherwise.
     */
    boolean updateProduct(ProductVO productVO);

    /**
     * Deletes a single product by ID.
     *
     * @param productId The ID of the product to delete.
     * @return true if the product was deleted successfully, false otherwise.
     */
    boolean deleteProduct(long productId);

    /**
     * Deletes multiple products by their IDs.
     *
     * @param productIds A list of product IDs to delete.
     * @return true if all selected products were deleted successfully, false otherwise.
     */
    boolean deleteProducts(List<Long> productIds);
}
