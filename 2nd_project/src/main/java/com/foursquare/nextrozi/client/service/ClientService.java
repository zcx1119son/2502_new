package com.foursquare.nextrozi.client.service;

import com.foursquare.nextrozi.client.vo.ClientVO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Map;

public interface ClientService {
    void registerClient(ClientVO clientVO);
    Page<ClientVO> getAllClients(Pageable pageable, String searchType, String searchKeyword);
    void updateClient(ClientVO clientVO);
    void deleteClient(long clientId);
    ClientVO getClientById(long clientId);
}