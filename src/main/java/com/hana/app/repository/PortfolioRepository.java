package com.hana.app.repository;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.frame.BaseRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
@Mapper
public interface PortfolioRepository extends BaseRepository<Integer, PortfolioDTO> {
    // 마이페이지 - 사용자의 포트폴리오
    List<PortfolioDTO> selectByUserId(Integer userId);

    Double getCurrencyByCountryDate(PortfolioQueryDTO portfolioQueryDTO);
}
