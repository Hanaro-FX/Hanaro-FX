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
import java.time.temporal.ChronoUnit;
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
    public Map<LocalDate, HashMap<String, Double>> calcResult(@RequestBody PortfolioQueryDTO[] requestData) throws Exception {
        PortfolioQueryDTO dummy = requestData[0];
        int rebalance = dummy.getRebalance();
        LocalDate startDate = dummy.getStartDate();
        LocalDate endDate = dummy.getEndDate().plusDays(2);
        HashMap<String, Double> countryCnt = new HashMap<>();
        HashMap<String, Double> countryPercentage = new HashMap<>();

//        국가 일자 가격
        HashMap<String, HashMap<LocalDate, Double>> country_date_currency = new HashMap<>();
//         TODO: Cold Start 상황이라면, 이 국가에의 투자는 0이라 치고, 그 국가의 투자금액을 다른 국가들이 사전 설정된 비율에 비례하게 받아간다.
        for (PortfolioQueryDTO requestDatum : requestData) {
            String tableName = requestDatum.getTableName();
            double percentage = requestDatum.getPercentage() / 100;
            double partialAmount = requestDatum.getInitialAmount() * percentage;
            PortfolioQueryDTO portfolioQueryDTO = PortfolioQueryDTO.builder().tableName(tableName).startDate(startDate).endDate(endDate).build();
            // 한 국가에게 주어진 기간동안의 모든 일자, 환율 정보
            List<PortfolioResultDTO> dateCurrency = portfolioService.getCurrencyByCountryDate(portfolioQueryDTO);
            double initialCnt = partialAmount / dateCurrency.get(0).getStandardRate();

            countryCnt.put(tableName, initialCnt);
            countryPercentage.put(tableName, percentage);

            HashMap<LocalDate, Double> minimap = new HashMap<>();

            for (int i = 0; i < dateCurrency.size(); i++) {
                PortfolioResultDTO result = dateCurrency.get(i);
                minimap.put(result.getCurrencyDate(), result.getStandardRate());
            }
            country_date_currency.put(tableName, minimap);
        }

        // 1. Map DCC = {Date: {Country: 그 시점 환율}}을 구성한다.
        Map<LocalDate, HashMap<String, Double>> dcc = new HashMap<>();

        // 2. 범위의 모든 일자들을 순회하면서 리밸런싱 관련 작업을 수행한다
        List<LocalDate> allDates = dummy.getStartDate().datesUntil(dummy.getEndDate().plusDays(1)).toList();

        for (LocalDate currentDate : allDates) {
            HashMap<String, Double> countryValue = new HashMap<>();

            country_date_currency.forEach((country, dateCurrency) -> {
                if (!dateCurrency.containsKey(currentDate)) {
                    LocalDate yesterday = currentDate.minusDays(1);
                    // 전 날의 데이터도 없다면, 그냥 0 처리
                    dateCurrency.put(currentDate, dateCurrency.get(yesterday) == null ? 0 : dateCurrency.get(yesterday));
                }
                countryValue.put(country, dateCurrency.get(currentDate) * countryCnt.get(country));
            });
            long dateDiff = ChronoUnit.DAYS.between(currentDate, startDate);
            boolean rebalanceTime = dateDiff % rebalance == 0;
            if (rebalanceTime) {
                log.info("{} {}", currentDate, startDate);
                // currentDate 일자에 모든 국가의 가치의 합.
                double sum = 0;
                for (String s : countryValue.keySet()) {
                    sum += countryValue.get(s);
                }

                final double finalSum = sum;
                log.info(String.valueOf(finalSum));
                countryValue.forEach((country, value) -> {
                    double currentCurrency = country_date_currency.get(country).get(currentDate);
                    double newCnt = finalSum * countryPercentage.get(country) / currentCurrency;
                    countryCnt.put(country, newCnt);
                    countryValue.put(country, currentCurrency * countryCnt.get(country));
                });
            }

            dcc.put(currentDate, countryValue);
        }

        return dcc;
    }
}
