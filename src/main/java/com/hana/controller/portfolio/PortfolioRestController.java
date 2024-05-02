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

    @RequestMapping("/resultImpl")
    public PortfolioDTO resultPage(@RequestParam("id") Integer id, Model model) throws Exception {
        // 포트폴리오 데이터 불러오기
        return portfolioService.selectOne(id);
    }

    @RequestMapping("/testImpl")
    public Map<String, HashMap<LocalDate, Double>> calcResult(@RequestBody PortfolioQueryDTO[] requestData) throws Exception {
        HashMap<String, HashMap<LocalDate, Double>> map = new HashMap<>();
        int rebalance = requestData[0].getRebalance();
        log.info(requestData.toString());
        // {Date: {Country: Currency}}
        // 만약 특정 일자에 어느 국가는 환율이 없다면, 이 국가에의 투자는 0이라 치고, 그 국가의 투자금액을 다른 국가들이 사전 설정된 비율에 비례하게 받아간다.
        for (PortfolioQueryDTO requestDatum : requestData) {
            String tableName = requestDatum.getTableName();
            LocalDate startDate = requestDatum.getStartDate();
            LocalDate endDate = requestDatum.getEndDate();

            PortfolioQueryDTO portfolioQueryDTO = PortfolioQueryDTO.builder().tableName(tableName).startDate(startDate).endDate(endDate).build();
            List<PortfolioResultDTO> x = portfolioService.getCurrencyByCountryDate(portfolioQueryDTO);

            // 이 국가에 대한 초기 자본: 원
            double initValue = requestDatum.getInitialAmount() * requestDatum.getPercentage() / 100;

            // 초기 자본으로 구매한 외화 수
            double cnt_foreign = initValue / x.get(0).getStandardRate();

            HashMap<LocalDate, Double> minimap = new HashMap<>();
            // Rebalance 연산을 위한 인덱

            for (int i = 0; i < x.size(); i++) {
                PortfolioResultDTO result = x.get(i);
                Double currentValue = result.getStandardRate() * cnt_foreign;
                minimap.put(result.getCurrencyDate(), currentValue);
            }
            map.put(tableName, minimap);
        }

        return map;
    }
}
