package com.hana.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.service.PortfolioService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DuplicateKeyException;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@Slf4j
public class PortfolioTests {
    @Autowired
    PortfolioService portfolioService;

    @DisplayName("portfolio 생성 테스트")
    @Test
    public void createTest(){
        PortfolioDTO portfolioDTO = PortfolioDTO.builder()
                .userId(2)
                .portfolioName("create test")
                .portfolioDesc("for create test case")
                .portfolioDate(LocalDate.parse("2024-05-07"))
                .rebalancing(0)
                .percentageAED(10).percentageARS(10).percentageAUD(10).percentageBHD(10).percentageCAD(10)
                .percentageCHF(10).percentageCNY(10).percentageDKK(10).percentageEUR(10).percentageGBP(10)
                .percentageHKD(0).percentageHUF(0).percentageIDR(0).percentageILS(0).percentageINR(0).percentageJPY(0).percentageKWD(0)
                .percentageMXN(0).percentageMYR(0).percentageNOK(0).percentageNZD(0).percentagePHP(0).percentagePKR(0).percentagePLN(0)
                .percentageQAR(0).percentageRUB(0).percentageSAR(0).percentageSEK(0).percentageSGD(0).percentageTHB(0).percentageTRY(0)
                .percentageTWD(0).percentageUSD(0).percentageVND(0).percentageXAG(0).percentageXAU(0).percentageZAR(0)
                .build();
        try {
            portfolioService.insert(portfolioDTO);
            log.info("OK");
        } catch (Exception e) {
            if(e instanceof SQLException){
                log.info("System Trouble");
            }else if(e instanceof DuplicateKeyException){
                log.info("ID Duplicated");
            }else{
                log.info("Error");
            }
        }
    }

    @DisplayName("portfolio 결과 생성 테스트")
    @Test
    public void resultTest() throws Exception {
        // given
        HashMap<String, Double> expectedResult = new HashMap<>();
        expectedResult.put("UAE_AED", 50.0);
        expectedResult.put("China_CNY", 30.0);
        expectedResult.put("Malaysia_MYR", 20.0);

        LocalDate startDate = LocalDate.parse("2023-03-29");
        LocalDate endDate = LocalDate.parse("2024-03-21");
        double initialAmount = 10000.0;
        int rebalance = 90; // 30>90>180>365>9000

        PortfolioQueryDTO[] requestData = new PortfolioQueryDTO[expectedResult.size()];
        int i=0;
        for(String key:expectedResult.keySet()){
            requestData[i] = PortfolioQueryDTO.builder().tableName(key).percentage(expectedResult.get(key)).startDate(startDate).endDate(endDate).initialAmount(initialAmount).rebalance(rebalance).build();
            i++;
        }

        // when
        Map<LocalDate, HashMap<String, Double>> realResult = portfolioService.getDCC(requestData);

        // then
        for(int j=0; j<realResult.size(); j+=rebalance){
            LocalDate key = startDate.plusDays(j);
            HashMap<String, Double> value = realResult.get(key);

            double total = 0;
            for (String k : value.keySet()) {
                total += value.get(k);
            }

            for (String k : value.keySet()) {
                assertEquals(expectedResult.get(k), value.get(k)/total*100, 0.1);
            }
        }
    }
}
