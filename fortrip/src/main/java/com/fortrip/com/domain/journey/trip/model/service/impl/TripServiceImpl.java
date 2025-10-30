package com.fortrip.com.domain.journey.trip.model.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fortrip.com.app.journey.trip.dto.TripCreateForm;
import com.fortrip.com.app.journey.trip.dto.TripRequest;
import com.fortrip.com.app.journey.trip.dto.TripUpdateForm;
import com.fortrip.com.app.journey.trip.dto.TripView;
import com.fortrip.com.domain.journey.trip.model.mapper.TripMapper;
import com.fortrip.com.domain.journey.trip.model.service.TripService;
import com.fortrip.com.domain.journey.trip.model.vo.Trip;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class TripServiceImpl implements TripService {

    private final TripMapper tripMapper;

    @Override
    public List<TripView> findTrips(TripRequest req) {
        String dest = normalize(req.getDestination());
        int offset = (req.getPage() - 1) * req.getSize();
        List<Trip> rows = tripMapper.selectTrips(dest, offset, req.getSize());
        return rows.stream().map(this::toView).toList();
    }

    @Override
    public int countTrips(TripRequest req) {
        String dest = normalize(req.getDestination());
        return tripMapper.countTrips(dest);
    }

    @Override
    public TripView findTrip(int id) {
        Trip row = tripMapper.selectTripById(id);
        return row == null ? null : toView(row);
    }

//    @Override
//    @Transactional
//    public int createTrip(TripCreateForm form, Integer memberNo) {
//        Trip t = new Trip();
//        t.setRoadName(form.getTitle());
//        t.setRoadLocation(form.getRegion());
//        t.setRoadStart(form.getStartDate());
//        t.setRoadEnd(form.getEndDate());
//        t.setRoadCost(joinCost(form.getBudget(), form.getBudgetUnit()));
//        t.setRoadStyle(joinThemes(form.getThemes()));
//        t.setRoadIntro(form.getDescription());
//        t.setDeleteYn("N");
//        t.setMemberNo(memberNo);
//        return tripMapper.insertTrip(t);
//    }

    @Override
    @Transactional
    public int updateTrip(TripUpdateForm form, Integer memberNo, boolean admin) {
        // 권한 체크는 Controller에서 (작성자/관리자) 확인 후 호출하거나,
        // 여기서 select 후 비교해도 됨. 간단히 여기선 UPDATE만.
        Trip t = new Trip();
        t.setRoadNo(form.getId());
        t.setRoadName(form.getTitle());
        t.setRoadLocation(form.getRegion());
        t.setRoadStart(form.getStartDate());
        t.setRoadEnd(form.getEndDate());
        t.setRoadCost(joinCost(form.getBudget(), form.getBudgetUnit()));
        t.setRoadStyle(joinThemes(form.getThemes()));
        t.setRoadIntro(form.getDescription());
        return tripMapper.updateTrip(t);
    }

    @Override
    @Transactional
    public int deleteTrip(int id, Integer memberNo, boolean admin) {
        return tripMapper.softDelete(id, memberNo, admin);
    }

    // ===== Helpers =====
    private String normalize(String s){
        return (s==null || s.isBlank()) ? null : s.trim();
    }
    private String joinThemes(String[] themes){
        if (themes == null || themes.length == 0) return null;
        return Arrays.stream(themes).filter(x->x!=null && !x.isBlank())
                .map(String::trim).collect(Collectors.joining(","));
    }
    private String joinCost(Integer budget, String unit){
        if (budget == null) return null;
        String u = (unit==null || unit.isBlank()) ? "원" : unit.trim();
        return budget + " " + u;
    }

    private TripView toView(Trip r) {
        // routeCsv는 roadIntro에 CSV가 아니라 소개문이라 칩 분해 안함 → 빈 리스트
        return TripView.builder()
            .id(r.getRoadNo())
            .title(r.getRoadName())
            .location(r.getRoadLocation())
            .thumbnailUrl(null)       // 썸네일 칼럼 생기면 매핑
            .createdAt(r.getWriteDate())
            .routeCsv(null)           // 소개문은 칩대상 아님
            .build();
    }

	@Override
	@Transactional
	public int createTrip(Trip trip) {
		return tripMapper.insertRoad(trip);
	}

	@Override
	public int createTrip(TripCreateForm form, Integer memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}
}