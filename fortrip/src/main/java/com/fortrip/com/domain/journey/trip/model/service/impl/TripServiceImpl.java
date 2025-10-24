package com.fortrip.com.domain.journey.trip.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fortrip.com.app.journey.trip.dto.TripRequest;
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
        String dest = (req.getDestination()==null || req.getDestination().isBlank()) ? null : req.getDestination().trim();
        int offset = (req.getPage() - 1) * req.getSize();

        List<Trip> rows = tripMapper.selectTrips(dest, offset, req.getSize());
        return rows.stream().map(this::toView).toList();
    }

    @Override
    public int countTrips(TripRequest req) {
        String dest = (req.getDestination()==null || req.getDestination().isBlank()) ? null : req.getDestination().trim();
        return tripMapper.countTrips(dest);
    }

    @Override
    public TripView findTrip(int id) {
        Trip row = tripMapper.selectTripById(id);
        return row == null ? null : toView(row);
    }

    // === VO -> JSP용 DTO 매핑 ===
    private TripView toView(Trip r) {
        String routeCsv = r.getRoadIntro(); // CSV로 저장해두었으면 칩으로 분해됨
        return TripView.builder()
                .id(r.getRoadNo())
                .title(r.getRoadName())
                .location(r.getRoadLocation())
                .thumbnailUrl(null) // 썸네일 컬럼 생기면 매핑
                .createdAt(r.getWriteDate())
                .routeCsv(routeCsv)
                .build();
    }
}