package com.foursquare.nextrozi.home.dao;

import com.foursquare.nextrozi.home.vo.HomeVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper // This annotation tells Spring to make an implementation of this interface
public interface HomeDAO {
    /**
     * Inserts a new calendar event into the database.
     * @param HomeVO The HomeVO object containing event details.
     * @return The number of rows affected.
     */
    int insertEvent(HomeVO homeVO);

    /**
     * Updates an existing calendar event in the database.
     * @param HomeVO The HomeVO object with updated event details.
     * @return The number of rows affected.
     */
    int updateEvent(HomeVO homeVO);

    /**
     * Deletes a calendar event from the database by its ID.
     * @param eventId The ID of the event to delete.
     * @return The number of rows affected.
     */
    int deleteEvent(Long eventId);

    /**
     * Retrieves a single calendar event by its ID.
     * @param eventId The ID of the event to retrieve.
     * @return The HomeVO object if found, otherwise null.
     */
    HomeVO getEventById(Long eventId);

    /**
     * Retrieves all calendar events from the database.
     * @return A list of HomeVO objects.
     */
    List<HomeVO> getAllEvents();
}
