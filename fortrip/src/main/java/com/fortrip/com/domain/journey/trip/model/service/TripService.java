package com.fortrip.com.domain.journey.trip.model.service;

import java.util.List;

import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.app.journey.trip.dto.TripView;

public interface TripService {
    List<TripView> findTrips(TripRequest req);
    int countTrips(TripRequest req);
    TripView findTrip(int id);
}
