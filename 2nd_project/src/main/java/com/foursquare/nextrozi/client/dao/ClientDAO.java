package com.foursquare.nextrozi.client.dao;

import com.foursquare.nextrozi.client.vo.ClientVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ClientDAO {
    void insertClient(ClientVO clientVO);
    List<ClientVO> selectAllClients(@Param("offset") int offset, @Param("limit") int limit,
                                    @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
    long countAllClients(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
    void updateClient(ClientVO clientVO);
    void deleteClient(long clientId);
    ClientVO selectClientById(long clientId);
}