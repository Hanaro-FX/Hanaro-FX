package com.hana.app.data.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PortfolioQueryDTO {
    private LocalDate startDate;
    private LocalDate endDate;
    private String tableName;
    private Double percentage;
    private Double initialAmount;
    private Integer rebalance;
}
