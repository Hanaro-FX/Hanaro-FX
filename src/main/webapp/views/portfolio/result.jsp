<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/result.css"/>"/>

<script>
    let result = {
        init: function () {
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                currencyData = getData();

                let data = google.visualization.arrayToDataTable([
                    ['Currency', 'Ratio'],
                    ...currencyData
                ]);

                let options = {
                    'title':'선택한 외화',
                    'colors': [
                        '#C8E6C9', '#A5D6A7', '#81C784', '#66BB6A', '#4CAF50',
                        '#43A047', '#388E3C', '#2E7D32', '#1B5E20', '#8BC34A',
                        '#9CCC65', '#7CB342', '#689F38', '#558B2F', '#33691E',
                        '#CCFF90', '#B2FF59', '#76FF03', '#64DD17', '#00C853',
                        '#AED581', '#81C784', '#4CAF50', '#66BB6A', '#43A047',
                        '#2E7D32', '#1B5E20', '#8BC34A', '#9CCC65', '#7CB342',
                        '#689F38', '#558B2F', '#33691E'
                    ],
                    'width':400,
                    'height':280,
                    'chartArea':{left:10, right:10, top:20, bottom:10}
                };

                let chart = new google.visualization.PieChart(document.getElementById('piechart'));
                chart.draw(data, options);
            }

            function getData() {
                data = [];

                if (${portfolio.percentageAED} != 0) {
                    data.push(['🇦🇪AED', ${portfolio.percentageAED}]);
                }


                if (${portfolio.percentageARS} != 0) {
                    data.push(['🇦🇷ARS', ${portfolio.percentageARS}]);
                }


                if (${portfolio.percentageAUD} != 0) {
                    data.push(['🇦🇺AUD', ${portfolio.percentageAUD}]);
                }


                if (${portfolio.percentageBHD} != 0) {
                    data.push(['🇧🇭BHD', ${portfolio.percentageBHD}]);
                }


                if (${portfolio.percentageCAD} != 0) {
                    data.push(['🇨🇦CAD', ${portfolio.percentageCAD}]);
                }


                if (${portfolio.percentageCHF} != 0) {
                    data.push(['🇨🇭CHF', ${portfolio.percentageCHF}]);
                }


                if (${portfolio.percentageCNY} != 0) {
                    data.push(['🇨🇳CNY', ${portfolio.percentageCNY}]);
                }


                if (${portfolio.percentageDKK} != 0) {
                    data.push(['🇩🇰DKK', ${portfolio.percentageDKK}]);
                }

                if (${portfolio.percentageEUR} != 0) {
                    data.push(['🇪🇺EUR', ${portfolio.percentageEUR}]);
                }

                if (${portfolio.percentageGBP} != 0) {
                    data.push(['🇬🇧GBP', ${portfolio.percentageGBP}]);
                }

                if (${portfolio.percentageHKD} != 0) {
                    data.push(['🇭🇰HKD', ${portfolio.percentageHKD}]);
                }

                if (${portfolio.percentageHUF} != 0) {
                    data.push(['🇭🇺HUF', ${portfolio.percentageHUF}]);
                }

                if (${portfolio.percentageIDR} != 0) {
                    data.push(['🇮🇩IDR', ${portfolio.percentageIDR}]);
                }

                if (${portfolio.percentageILS} != 0) {
                    data.push(['🇮🇱ILS', ${portfolio.percentageILS}]);
                }

                if (${portfolio.percentageINR} != 0) {
                    data.push(['🇮🇳INR', ${portfolio.percentageINR}]);
                }

                if (${portfolio.percentageJPY} != 0) {
                    data.push(['🇯🇵JPY', ${portfolio.percentageJPY}]);
                }

                if (${portfolio.percentageKWD} != 0) {
                    data.push(['🇰🇼KWD', ${portfolio.percentageKWD}]);
                }

                if (${portfolio.percentageMXN} != 0) {
                    data.push(['🇲🇽MXN', ${portfolio.percentageMXN}]);
                }

                if (${portfolio.percentageMYR} != 0) {
                    data.push(['🇲🇾MYR', ${portfolio.percentageMYR}]);
                }

                if (${portfolio.percentageNOK} != 0) {
                    data.push(['🇳🇴NOK', ${portfolio.percentageNOK}]);
                }

                if (${portfolio.percentageNZD} != 0) {
                    data.push(['🇳🇿NZD', ${portfolio.percentageNZD}]);
                }

                if (${portfolio.percentagePHP} != 0) {
                    data.push(['🇵🇭PHP', ${portfolio.percentagePHP}]);
                }

                if (${portfolio.percentagePKR} != 0) {
                    data.push(['🇵🇰PKR', ${portfolio.percentagePKR}]);
                }

                if (${portfolio.percentagePLN} != 0) {
                    data.push(['🇵🇱PLN', ${portfolio.percentagePLN}]);
                }

                if (${portfolio.percentageQAR} != 0) {
                    data.push(['🇶🇦QAR', ${portfolio.percentageQAR}]);
                }

                if (${portfolio.percentageRUB} != 0) {
                    data.push(['🇷🇺RUB', ${portfolio.percentageRUB}]);
                }

                if (${portfolio.percentageSAR} != 0) {
                    data.push(['🇸🇦SAR', ${portfolio.percentageSAR}]);
                }

                if (${portfolio.percentageSEK} != 0) {
                    data.push(['🇸🇪SEK', ${portfolio.percentageSEK}]);
                }

                if (${portfolio.percentageSGD} != 0) {
                    data.push(['🇸🇬SGD', ${portfolio.percentageSGD}]);
                }

                if (${portfolio.percentageTHB} != 0) {
                    data.push(['🇹🇭THB', ${portfolio.percentageTHB}]);
                }

                if (${portfolio.percentageTRY} != 0) {
                    data.push(['🇹🇷TRY', ${portfolio.percentageTRY}]);
                }

                if (${portfolio.percentageTWD} != 0) {
                    data.push(['🇹🇼TWD', ${portfolio.percentageTWD}]);
                }

                if (${portfolio.percentageUSD} != 0) {
                    data.push(['🇺🇸USD', ${portfolio.percentageUSD}]);
                }

                if (${portfolio.percentageVND} != 0) {
                    data.push(['🇻🇳VND', ${portfolio.percentageVND}]);
                }

                if (${portfolio.percentageZAR} != 0) {
                    data.push(['🇿🇦ZAR', ${portfolio.percentageZAR}]);
                }

                return data;
            }
        }
    };
    $(function () {
        $('#startDate').monthpicker({
            startYear: 2000,
            finalYear: new Date().getFullYear(),
            monthNames: ['1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)', '5월(MAY)', '6월(JUN)', '7월(JUL)', '8월(AUG)', '9월(SEP)', '10월(OCT)', '11월(NOV)', '12월(DEC) '],
            monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            showOn: "button",
            buttonImage: "https://cdn-icons-png.flaticon.com/512/2838/2838779.png",
            buttonImageOnly: true,
            changeYear: true,
            minDate: new Date(2000, 0),
            maxDate: new Date(),
            yearRange: '2000:c',
            dateFormat: 'yy-mm',
            onSelect: function(selected) {
                let selectedMonth = $('#startDate').monthpicker('getDate');
                selectedMonth.setMonth(selectedMonth.getMonth() + 1);
                $('#endDate').monthpicker('option', 'minDate', selectedMonth);
                $("#ui-monthpicker-div").find(".ui-state-active").removeClass("ui-state-active");
            }
        });
        $('#endDate').monthpicker({
            startYear: 2000,
            finalYear: new Date().getFullYear(),
            monthNames: ['1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)', '5월(MAY)', '6월(JUN)', '7월(JUL)', '8월(AUG)', '9월(SEP)', '10월(OCT)', '11월(NOV)', '12월(DEC) '],
            monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            showOn: "button",
            buttonImage: "https://cdn-icons-png.flaticon.com/512/2838/2838779.png",
            buttonImageOnly: true,
            changeYear: true,
            minDate: new Date(2000, 0),
            maxDate: new Date(),
            yearRange: '2000:c',
            dateFormat: 'yy-mm',
            onSelect: function(selected) {
                let selectedMonth = $('#endDate').monthpicker('getDate');
                selectedMonth.setMonth(selectedMonth.getMonth() - 1);
                $('#startDate').monthpicker('option', 'maxDate', selectedMonth);
                $("#ui-monthpicker-div").find(".ui-state-active").removeClass("ui-state-active");
            }
        });

        result.init();
    });
</script>

<div class="container">
    <h3>
        <c:choose>
            <c:when test="${empty portfolio.portfolioName}">
                제목 없는 포트폴리오
            </c:when>
            <c:otherwise>
                ${portfolio.portfolioName}
            </c:otherwise>
        </c:choose>
    </h3>

    <br/>

    <div class="row">
        <div class="col">
            <div class="info">
                포트폴리오 생성일: ${portfolio.portfolioDate}
                <c:if test="${not empty portfolio.portfolioDesc}">
                    <br/>
                    전략 설명: ${portfolio.portfolioDesc}
                </c:if>
            </div>
            <!-- Start Date -->
            <div class="form-group row">
                <label for="startDate" class="col-form-label col-md-3">
                    Start Date
                </label>
                <div class="col-md">
                    <input type="text" id="startDate">
                </div>
            </div>

            <!-- End Date -->
            <div class="form-group row">
                <label for="endDate" class="col-form-label col-md-3">
                    End Date
                </label>
                <div class="col-md">
                    <input type="text" id="endDate">
                </div>
            </div>

            <!-- Initial Amount -->
            <div class="form-group row">
                <label for="initialAmount" class="col-form-label col-md-3">Initial Amount</label>
                <div class="col-md-3">
                    <div class="input-group flex-nowrap" style="width: 200px;">
                        <input
                                type="number"
                                id="initialAmount"
                                name="initialAmount"
                                class="form-control fmt-posint"
                                value="10000"
                                placeholder="Amount..."
                                autocomplete="off"
                        />
                        <span class="input-group-text">₩</span>
                    </div>
                </div>
            </div>

            <!-- Rebalancing -->
            <div class="form-group row">
                <label for="rebalanceType" class="col-form-label col-md-3">Rebalancing</label>
                <div class="col-md-3">
                    <div class="select-parent">
                        <select
                                id="rebalanceType"
                                name="rebalanceType"
                                class="form-control form-select"
                        >
                            <option value="13" selected="">No rebalancing</option>
                            <option value="12">년마다</option>
                            <option value="6">반년마다</option>
                            <option value="3">분기마다</option>
                            <option value="1">매달</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="col" id="piechart"></div>
    </div>

    <div class="test-btn-box">
        <div class="test-btn">TEST</div>
    </div>
</div>