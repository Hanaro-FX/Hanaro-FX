package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/portfolio")
public class PortfolioRestController {
    String dir = "portfolio/";
    final PortfolioService portfolioService;

    @RequestMapping("/createImpl")
    public String portfolioCreate(Model model, PortfolioDTO portfolioDTO) throws Exception {
        log.info(portfolioDTO.toString());
        portfolioService.insert(portfolioDTO);
        model.addAttribute("center", "/");
        return "index";
    }

    @RequestMapping("/resultImpl")
    public PortfolioDTO resultPage(@RequestParam("id") Integer id, Model model) throws Exception {
        // 포트폴리오 데이터 불러오기
        return portfolioService.selectOne(id);
    }

    @RequestMapping("/testImpl")
    public Object calcResult(@RequestBody PortfolioQueryDTO[] requestData) {
        // requestData를 사용하여 필요한 작업 수행
        for (PortfolioQueryDTO requestDatum : requestData) {
            log.info(requestDatum.toString());
        }

        return null;
    }
}
