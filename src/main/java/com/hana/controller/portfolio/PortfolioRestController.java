package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.data.dto.PortfolioResultDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Map<String, HashMap<LocalDate, Double>> calcResult(@RequestBody PortfolioQueryDTO[] requestData) throws Exception {
        HashMap<String, HashMap<LocalDate, Double>> map = new HashMap<>();

        for (PortfolioQueryDTO requestDatum : requestData) {
            String tableName = requestDatum.getTableName();
            log.info(tableName);

            PortfolioQueryDTO portfolioQueryDTO = PortfolioQueryDTO.builder().tableName(requestDatum.getTableName()).startDate(requestDatum.getStartDate()).endDate(requestDatum.getEndDate()).build();
            List<PortfolioResultDTO> x = portfolioService.getCurrencyByCountryDate(portfolioQueryDTO);
            log.info(x.toString());

            x.forEach((xx) -> {
                HashMap<LocalDate, Double> minimap = new HashMap<>();
                minimap.put(xx.getCurrencyDate(), xx.getStandardRate());
                map.put(tableName, minimap);
            });

            // TODO: Rebalancing 적용하기. => front 단에서 해야하려나.
            // TODO: 가져온 데이터 활용한 그래프로의 시각화

//            double initValue = requestDatum.getInitialAmount() * requestDatum.getPercentage() / 100;

//            double cnt_foreign = initValue / past_currency;
//
//            PortfolioQueryDTO portfolioQueryDTO1 = PortfolioQueryDTO.builder().tableName(requestDatum.getTableName()).startDate(requestDatum.getEndDate()).build();
//            double finalValue = portfolioService.getCurrencyByCountryDate(portfolioQueryDTO1) * cnt_foreign;
//            log.info(String.valueOf(finalValue - initValue));
        }

        return map;
    }
}
