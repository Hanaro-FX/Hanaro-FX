package com.hana.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.PortfolioService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DuplicateKeyException;

import java.sql.SQLException;
import java.time.LocalDate;
@SpringBootTest
@Slf4j
public class CreateTests {
    @Autowired
    PortfolioService portfolioService;

    @Test
    void contextLoads(){
        PortfolioDTO portfolioDTO = PortfolioDTO.builder()
                .userId(3)
                .portfolioName("createTests")
                .portfolioDesc("create test case")
                .portfolioDate(LocalDate.parse("2024-05-03"))
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
            log.info("----------OK----------------");
        } catch (Exception e) {
            if(e instanceof SQLException){
                log.info("----------System Trouble EX0001----------------");
            }else if(e instanceof DuplicateKeyException){
                log.info("----------ID Duplicated EX0002----------------");
            }else{
                log.info("----------Sorry EX0003----------------");
            }

        }
    }
}
