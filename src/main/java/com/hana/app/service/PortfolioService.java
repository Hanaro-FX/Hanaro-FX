package com.hana.app.service;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.frame.BaseService;
import com.hana.app.repository.PortfolioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PortfolioService implements BaseService<Integer, PortfolioDTO> {

    final PortfolioRepository portfolioRepository;

    @Override
    public int insert(PortfolioDTO portfolioDTO) throws Exception {
        return portfolioRepository.insert(portfolioDTO);
    }

    @Override
    public int delete(Integer integer) throws Exception {
        return portfolioRepository.delete(integer);
    }

    @Override
    public int update(PortfolioDTO portfolioDTO) throws Exception {
        return portfolioRepository.update(portfolioDTO);
    }

    @Override
    public PortfolioDTO selectOne(Integer integer) throws Exception {
        return portfolioRepository.selectOne(integer);
    }

    @Override
    public List<PortfolioDTO> selectAll() throws Exception {
        return portfolioRepository.selectAll();
    }
}
