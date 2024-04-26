package com.hana.app.repository;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.frame.BaseRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface PortfolioRepository extends BaseRepository<Integer, PortfolioDTO> {
    
}
