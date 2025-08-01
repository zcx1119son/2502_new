package com.foursquare.nextrozi.product.dao;

import com.foursquare.nextrozi.product.vo.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
 * ProductDAO is the Data Access Object interface for ProductVO.
 * It defines the methods for database operations related to products.
 * This interface is mapped to product.xml for MyBatis queries.
 */
@Mapper
public interface ProductDAO {

    /**
     * Retrieves a paginated list of products based on search criteria.
     * Includes client_name through JOIN.
     *
     * @param pageable    Pagination information (offset, page size, sort).
     * @param searchType  Type of search (e.g., "client_id", "product_id", "product_name", "client_name").
     * @param searchKeyword Keyword to search for.
     * @return A list of ProductVO objects.
     */
    List<ProductVO> getPagedProducts(
            @Param("pageable") Pageable pageable,
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword
    );

    /**
     * Counts the total number of products based on search criteria.
     * Used for pagination to determine the total number of pages.
     *
     * @param searchType  Type of search.
     * @param searchKeyword Keyword to search for.
     * @return The total count of products.
     */
    long countProducts(
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword
    );

    /**
     * Adds a new product to the database.
     *
     * @param productVO The ProductVO object containing product details to be added.
     * @return The number of rows affected (should be 1 on success).
     */
    int addProduct(ProductVO productVO);

    /**
     * Retrieves a single product by its ID.
     * Includes client_name through JOIN.
     *
     * @param productId The ID of the product to retrieve.
     * @return The ProductVO object corresponding to the given ID, or null if not found.
     */
    ProductVO getProductById(long productId);

    /**
     * Updates an existing product's details.
     *
     * @param productVO The ProductVO object containing the updated product details.
     * The product_id field must be set to identify the product to update.
     * @return The number of rows affected (should be 1 on success).
     */
    int updateProduct(ProductVO productVO);

    /**
     * Deletes a product by its ID.
     *
     * @param productId The ID of the product to delete.
     * @return The number of rows affected (should be 1 on success).
     */
    int deleteProduct(long productId);

    /**
     * Deletes multiple products by their IDs.
     *
     * @param productIds A list of product IDs to delete.
     * @return The number of rows affected.
     */
    int deleteProductsByIds(@Param("productIds") List<Long> productIds);
}
