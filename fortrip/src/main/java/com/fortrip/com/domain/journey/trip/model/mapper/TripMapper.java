package com.fortrip.com.domain.journey.trip.model.mapper;

import java.util.List;
import java.util.Map;

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

	    int insertTrip(Trip trip);
	    
	    int insertRoad(Trip trip);

	    int updateTrip(Trip trip);

	    int softDelete(@Param("id") int id, @Param("memberNo") Integer memberNo, @Param("admin") boolean admin);

	    List<Trip> selectTripsByMemberPaged(Map<String, Object> param);
	    int countTripsByMember(Integer memberNo);
	    
	    // 나의 로드맵
	    List<Trip> selectTripsByMember(int memberNo);
	    
	    // (옵션) 관리자 전용 목록 필터
	    List<Trip> selectAdminTrips(
	        @Param("destination") String destination,
	        @Param("offset") int offset,
	        @Param("size") int size
	    );

	    int countAdminTrips(@Param("destination") String destination);
	}
