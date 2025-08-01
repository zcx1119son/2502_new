package com.foursquare.nextrozi.client.service;

import com.foursquare.nextrozi.client.dao.ClientDAO;
import com.foursquare.nextrozi.client.service.ClientService;
import com.foursquare.nextrozi.client.vo.ClientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientServiceImpl implements ClientService {

    @Autowired
    private ClientDAO clientDAO;

    @Override
    public void registerClient(ClientVO clientVO) {
        clientDAO.insertClient(clientVO);
    }

    @Override
    public Page<ClientVO> getAllClients(Pageable pageable, String searchType, String searchKeyword) {
        int offset = (int) pageable.getOffset();
        int limit = pageable.getPageSize();

        List<ClientVO> clients = clientDAO.selectAllClients(offset, limit, searchType, searchKeyword);
        long total = clientDAO.countAllClients(searchType, searchKeyword);

        return new PageImpl<>(clients, pageable, total);
    }

    @Override
    public void updateClient(ClientVO clientVO) {
        clientDAO.updateClient(clientVO);
    }

    @Override
    public void deleteClient(long clientId) {
        clientDAO.deleteClient(clientId);
    }

    @Override
    public ClientVO getClientById(long clientId) {
        return clientDAO.selectClientById(clientId);
    }
}