package com.foursquare.nextrozi.home.controller;

import com.foursquare.nextrozi.home.service.HomeService;
import com.foursquare.nextrozi.home.vo.HomeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private HomeService homeService;

    @GetMapping
    public String home(Model model) {
        return "home/home";
    }

    @GetMapping("/events")
    @ResponseBody
    public List<Map<String, Object>> getEvents() {
        List<HomeVO> events = homeService.listAllEvents();

        return events.stream().map(event -> {
            Map<String, Object> eventMap = new java.util.HashMap<>();
            eventMap.put("id", event.getEventId());
            eventMap.put("title", event.getEventTitle());

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
            if (event.getEventStartDate() != null) {
                eventMap.put("start", LocalDateTime.ofInstant(event.getEventStartDate().toInstant(), ZoneId.systemDefault()).format(formatter));
            }
            if (event.getEventEndDate() != null) {
                eventMap.put("end", LocalDateTime.ofInstant(event.getEventEndDate().toInstant(), ZoneId.systemDefault()).format(formatter));
            }

            Map<String, Object> extendedProps = new java.util.HashMap<>();
            extendedProps.put("eventContent", event.getEventContent());
            extendedProps.put("memberName", event.getMemberName());
            extendedProps.put("companyName", event.getCompanyName());
            extendedProps.put("priority", event.getPriority());
            extendedProps.put("clientNote", event.getClientNote());  // ✅ 오타 수정
            extendedProps.put("productId", event.getProductId());
            extendedProps.put("productName", event.getProductName());
            eventMap.put("extendedProps", extendedProps);

            // 색상 지정
            switch (event.getPriority() != null ? event.getPriority() : "") {
                case "HIGH":
                    eventMap.put("color", "#f44336"); break;
                case "MEDIUM":
                    eventMap.put("color", "#ffc107"); break;
                case "LOW":
                    eventMap.put("color", "#4caf50"); break;
                default:
                    eventMap.put("color", "#3788d8"); // 기본 파랑
            }

            return eventMap;
        }).collect(Collectors.toList());
    }

    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<String> insertEvent(@RequestBody HomeVO homeVO) {
        try {
            // 필수값 검증
            if (homeVO.getCompanyName() == null || homeVO.getCompanyName().trim().isEmpty()) {
                return new ResponseEntity<>("Company Name is required", HttpStatus.BAD_REQUEST);
            }

            homeVO.setCreatedId("system");
            homeVO.setUpdatedId("system");

            int result = homeService.insertEvent(homeVO);
            return result > 0
                    ? new ResponseEntity<>("success", HttpStatus.OK)
                    : new ResponseEntity<>("failure", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateEvent(@RequestBody HomeVO homeVO) {
        try {
            // 필수값 검증
            if (homeVO.getCompanyName() == null || homeVO.getCompanyName().trim().isEmpty()) {
                return new ResponseEntity<>("Company Name is required", HttpStatus.BAD_REQUEST);
            }

            homeVO.setUpdatedId("system");

            int result = homeService.updateEvent(homeVO);
            return result > 0
                    ? new ResponseEntity<>("success", HttpStatus.OK)
                    : new ResponseEntity<>("failure", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteEvent(@RequestBody Map<String, Long> requestBody) {
        Long eventId = requestBody.get("eventId");
        if (eventId == null) {
            return new ResponseEntity<>("Event ID is missing.", HttpStatus.BAD_REQUEST);
        }
        try {
            boolean success = homeService.removeEvent(eventId);
            return success
                    ? new ResponseEntity<>("success", HttpStatus.OK)
                    : new ResponseEntity<>("failure", HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
