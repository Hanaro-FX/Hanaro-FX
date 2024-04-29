package com.hana.app.data.dto;

import lombok.*;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PortfolioDTO {
    private int id;
    private int userId;
    private String portfolioName;
    private String portfolioDesc;
    private LocalDate portfolioDate;

    //    0, 1, 3, 6, 12
    private int rebalancing;

    private double percentageAED;
    private double percentageARS;
    private double percentageAUD;
    private double percentageBHD;
    private double percentageCAD;
    private double percentageCHF;
    private double percentageCNY;
    private double percentageDKK;
    private double percentageEUR;
    private double percentageGBP;
    private double percentageHKD;
    private double percentageHUF;
    private double percentageIDR;
    private double percentageILS;
    private double percentageINR;
    private double percentageJPY;
    private double percentageKWD;
    private double percentageMXN;
    private double percentageMYR;
    private double percentageNOK;
    private double percentageNZD;
    private double percentagePHP;
    private double percentagePKR;
    private double percentagePLN;
    private double percentageQAR;
    private double percentageRUB;
    private double percentageSAR;
    private double percentageSEK;
    private double percentageSGD;
    private double percentageTHB;
    private double percentageTRY;
    private double percentageTWD;
    private double percentageUSD;
    private double percentageVND;
    private double percentageXAG;
    private double percentageXAU;
    private double percentageZAR;
}
