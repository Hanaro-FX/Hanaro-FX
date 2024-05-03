package com.hana.mypage;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.PortfolioService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DuplicateKeyException;

import java.sql.SQLException;
import java.util.List;

@SpringBootTest
@Slf4j
public class MyPageTests {
    @Autowired
    PortfolioService portfolioService;

    @Test
    void contextLoads(){
        try {
            List<PortfolioDTO> result = portfolioService.getPortfolioList(3);
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
