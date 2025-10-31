package com.fortrip.com.domain.journey.trip.model.service;

import java.util.List;
import com.fortrip.com.app.journey.trip.dto.TripCreateForm;
import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.app.journey.trip.dto.TripUpdateForm;
import com.fortrip.com.app.journey.trip.dto.TripView;
import com.fortrip.com.domain.journey.trip.model.vo.Trip;

public interface TripService {
    List<TripView> findTrips(TripRequest req);
    int countTrips(TripRequest req);
    TripView findTrip(int id);

    int createTrip(TripCreateForm form, Integer memberNo);
    int updateTrip(TripUpdateForm form, Integer memberNo, boolean admin);
    int deleteTrip(int id, Integer memberNo, boolean admin);
    
    int createTrip(Trip trip);
    
	List<Trip> selectTripsByMember(int memberNo);
	List<Trip> selectTripsByMemberPaged(int memberNo, int offset, int size);
	int countTripsByMember(int memberNo);
	
	List<TripView> findAdminTrips(TripRequest req);
	int countAdminTrips(TripRequest req);
	
	List<TripView> findUserTrips(TripRequest req);
	int countUserTrips(TripRequest req);
}