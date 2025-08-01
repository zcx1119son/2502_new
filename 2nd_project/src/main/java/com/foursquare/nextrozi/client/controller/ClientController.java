package com.foursquare.nextrozi.client.controller;

import com.foursquare.nextrozi.client.service.ClientService;
import com.foursquare.nextrozi.client.vo.ClientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/client")
public class ClientController {

    @Autowired
    private ClientService clientService;

    // Endpoint to serve the JSP page
    @GetMapping("")
    public String clientListPage() {
        return "client/client";
    }

    // AJAX endpoint to fetch paginated and searchable client data
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getClientData(
            @PageableDefault(size = 10, sort = "created_date", direction = org.springframework.data.domain.Sort.Direction.DESC) Pageable pageable,
            @RequestParam(value = "searchType", required = false, defaultValue = "") String searchType,
            @RequestParam(value = "searchKeyword", required = false, defaultValue = "") String searchKeyword) {

        Page<ClientVO> clientsPage = clientService.getAllClients(pageable, searchType, searchKeyword);

        Map<String, Object> response = new HashMap<>();
        response.put("clients", clientsPage.getContent());
        response.put("totalPages", clientsPage.getTotalPages());
        response.put("currentPage", clientsPage.getNumber());
        return response;
    }

    // Handles the AJAX request for client registration
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<String> registerClient(@RequestBody ClientVO clientVO) {
        try {
            clientService.registerClient(clientVO);
            return new ResponseEntity<>("Client registered successfully!", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error registering client: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Handles the AJAX request for updating client information
    @PutMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateClient(@RequestBody ClientVO clientVO) {
        try {
            clientService.updateClient(clientVO);
            return new ResponseEntity<>("Client updated successfully!", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error updating client: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Handles the AJAX request for deleting multiple clients
    @DeleteMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteClients(@RequestBody List<Long> clientIds) {
        try {
            for (Long clientId : clientIds) {
                clientService.deleteClient(clientId);
            }
            return new ResponseEntity<>("Selected clients deleted successfully!", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error deleting clients: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Endpoint to fetch client data by ID (for populating update form)
    @GetMapping("/{client_id}") // Changed to /client/{client_id}
    @ResponseBody
    public ResponseEntity<ClientVO> getClientById(@PathVariable("client_id") long clientId) {
        try {
            ClientVO client = clientService.getClientById(clientId);
            if (client != null) {
                return new ResponseEntity<>(client, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}