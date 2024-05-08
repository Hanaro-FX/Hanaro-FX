package com.hana.app.service;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.data.dto.PortfolioResultDTO;
import com.hana.app.frame.BaseService;
import com.hana.app.repository.PortfolioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class PortfolioService implements BaseService<Integer, PortfolioDTO> {

    final PortfolioRepository portfolioRepository;

    HashMap<String, Double> countryCnt = new HashMap<>();
    HashMap<String, Double> countryPercentage = new HashMap<>();

    LocalDate startDate;
    LocalDate endDate;
    List<LocalDate> allDates = new ArrayList<>();

    int rebalance;

    @Override
    public int insert(PortfolioDTO portfolioDTO) throws Exception {
        return portfolioRepository.insert(portfolioDTO);
    }

    @Override
    public int delete(Integer id) throws Exception {
        return portfolioRepository.delete(id);
    }

    @Override
    public int update(PortfolioDTO portfolioDTO) throws Exception {
        return portfolioRepository.update(portfolioDTO);
    }

    @Override
    public PortfolioDTO selectOne(Integer id) throws Exception {
        return portfolioRepository.selectOne(id);
    }

    @Override
    public List<PortfolioDTO> selectAll() throws Exception {
        return portfolioRepository.selectAll();
    }

    // 마이페이지 - 사용자의 포트폴리오 목록 가져오기
    public List<PortfolioDTO> getPortfolioList(Integer userId) throws Exception {
        return portfolioRepository.selectByUserId(userId);
    }

    public List<PortfolioResultDTO> getCurrencyByCountryDate(PortfolioQueryDTO portfolioQueryDTO) throws Exception {
        return portfolioRepository.getCurrencyByCountryDate(portfolioQueryDTO);
    }

    // get country date currency
    public HashMap<String, HashMap<LocalDate, Double>> calcCDC(PortfolioQueryDTO[] requestData) throws Exception {

        HashMap<String, HashMap<LocalDate, Double>> country_date_currency = new HashMap<>();

        for (PortfolioQueryDTO requestDatum : requestData) {
            String tableName = requestDatum.getTableName();
            double percentage = requestDatum.getPercentage() / 100;
            double partialAmount = requestDatum.getInitialAmount() * percentage;

            // 설정한 일자보다 더 많은 데이터를 받아와서 cold start problem을 해결
            PortfolioQueryDTO portfolioQueryDTO = PortfolioQueryDTO.builder().tableName(tableName).startDate(startDate.minusDays(7)).endDate(endDate).build();
            // 한 국가에게 주어진 기간동안의 모든 일자, 환율 정보
            List<PortfolioResultDTO> dateCurrency = portfolioRepository.getCurrencyByCountryDate(portfolioQueryDTO);

            // 환율 데이터가 없는 국가 처리
            if (dateCurrency.isEmpty()) {
                throw new Exception("해당 날짜에 " + tableName + "의 환율 데이터가 존재하지 않습니다.");
            }

            double initialCnt = partialAmount / dateCurrency.get(0).getStandardRate();

            // 초기 자본으로 구매한 외화 수
            countryCnt.put(tableName, initialCnt);
            countryPercentage.put(tableName, percentage);

            HashMap<LocalDate, Double> minimap = new HashMap<>();

            for (PortfolioResultDTO result : dateCurrency) {
                minimap.put(result.getCurrencyDate(), result.getStandardRate());
            }
            country_date_currency.put(tableName, minimap);
        }
        return country_date_currency;
    }

    public HashMap<String, Double> calcCountryValue(HashMap<String, HashMap<LocalDate, Double>> country_date_currency, LocalDate currentDate) {
        HashMap<String, Double> countryValue = new HashMap<>();

        country_date_currency.forEach((country, dateCurrency) -> {
            if (!dateCurrency.containsKey(currentDate)) {
                LocalDate yesterday = currentDate.minusDays(1);
                // 전 날의 데이터도 없다면, 그냥 0 처리
                dateCurrency.put(currentDate, dateCurrency.get(yesterday) == null ? 0 : dateCurrency.get(yesterday));
            }
            countryValue.put(country, dateCurrency.get(currentDate) * countryCnt.get(country));
        });

        return countryValue;
    }

    public HashMap<String, Double> rebalanceCountryValue(HashMap<String, Double> countryValue, HashMap<String, HashMap<LocalDate, Double>> country_date_currency, LocalDate currentDate) {
        long dateDiff = ChronoUnit.DAYS.between(currentDate, startDate);
        if (dateDiff % rebalance == 0) {
            // currentDate 일자에 모든 국가의 가치의 합.
            double sum = 0;
            for (String s : countryValue.keySet()) {
                sum += countryValue.get(s);
            }

            final double finalSum = sum;

            countryValue.forEach((country, value) -> {
                double currentCurrency = country_date_currency.get(country).get(currentDate);
                double newCnt = finalSum * countryPercentage.get(country) / currentCurrency;
                countryCnt.put(country, newCnt);
                countryValue.put(country, currentCurrency * countryCnt.get(country));
            });
        }
        return countryValue;
    }

    public Map<LocalDate, HashMap<String, Double>> getDCC(PortfolioQueryDTO[] requestData) throws Exception {
        PortfolioQueryDTO dummy = requestData[0];
        rebalance = dummy.getRebalance();
        startDate = dummy.getStartDate();
        endDate = dummy.getEndDate().plusDays(2);
        allDates = startDate.datesUntil(endDate).toList();

        countryCnt = new HashMap<>();
        countryPercentage = new HashMap<>();

        // 국가 일자 가격
        HashMap<String, HashMap<LocalDate, Double>> country_date_currency = calcCDC(requestData);

        Map<LocalDate, HashMap<String, Double>> dcc = new HashMap<>();

        for (LocalDate currentDate : allDates) {
            //
            HashMap<String, Double> countryValue = calcCountryValue(country_date_currency, currentDate);

            countryValue = rebalanceCountryValue(countryValue, country_date_currency, currentDate);

            dcc.put(currentDate, countryValue);
        }

        return dcc;

    }

}
