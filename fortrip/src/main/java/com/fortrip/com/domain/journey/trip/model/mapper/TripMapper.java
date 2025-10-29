package com.fortrip.com.domain.journey.trip.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fortrip.com.domain.journey.trip.model.vo.Trip;

@Mapper
public interface TripMapper {

    List<Trip> selectTrips(
            @Param("destination") String destination,
            @Param("offset") int offset,
            @Param("size") int size
    );

    int countTrips(@Param("destination") String destination);

    Trip selectTripById(@Param("id") int id);
}
