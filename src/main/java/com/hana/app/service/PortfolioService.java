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

    private final PortfolioRepository portfolioRepository;

    @Override
    public int insert(PortfolioDTO portfolioDTO) throws Exception {
        return 0;
    }

    @Override
    public int delete(Integer id) throws Exception {
        return portfolioRepository.delete(id);
    }

    @Override
    public int update(PortfolioDTO portfolioDTO) throws Exception {
        return 0;
    }

    @Override
    public PortfolioDTO selectOne(Integer id) throws Exception {
        return portfolioRepository.selectOne(id);
    }

    @Override
    public List<PortfolioDTO> selectAll() throws Exception {
        return null;
    }

    // 마이페이지 - 사용자의 포트폴리오 목록 가져오기
    public List<PortfolioDTO> getPortfolioList(Integer userId) throws Exception {
        return portfolioRepository.selectByUserId(userId);
    }
}
