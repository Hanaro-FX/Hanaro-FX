// Pie Chart
let drawChart = function (dd) {
    let currencyData = getData(dd);
    let data = google.visualization.arrayToDataTable([['Currency', 'Ratio'], ...currencyData]);

    let options = {
        'title': '선택한 외화',
        'colors': ['#C8E6C9', '#A5D6A7', '#81C784', '#66BB6A', '#4CAF50', '#43A047', '#388E3C', '#2E7D32', '#1B5E20', '#8BC34A', '#9CCC65', '#7CB342', '#689F38', '#558B2F', '#33691E', '#CCFF90', '#B2FF59', '#76FF03', '#64DD17', '#00C853', '#AED581', '#81C784', '#4CAF50', '#66BB6A', '#43A047', '#2E7D32', '#1B5E20', '#8BC34A', '#9CCC65', '#7CB342', '#689F38', '#558B2F', '#33691E'],
        'width': 400,
        'height': 280,
        'chartArea': {left: 10, right: 10, top: 20, bottom: 10}
    };

    let chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(data, options);

    return currencyData;
}

let getData = function (dd) {
    {
        let portfolio = dd;
        data = [];

        if (portfolio.percentageAED !== 0) {
            data.push(['🇦🇪AED', portfolio.percentageAED]);
        }
        if (portfolio.percentageARS !== 0) {
            data.push(['🇦🇷ARS', portfolio.percentageARS]);
        }

        if (portfolio.percentageAUD !== 0) {
            data.push(['🇦🇺AUD', portfolio.percentageAUD]);
        }

        if (portfolio.percentageBHD !== 0) {
            data.push(['🇧🇭BHD', portfolio.percentageBHD]);
        }

        if (portfolio.percentageCAD !== 0) {
            data.push(['🇨🇦CAD', portfolio.percentageCAD]);
        }

        if (portfolio.percentageCHF !== 0) {
            data.push(['🇨🇭CHF', portfolio.percentageCHF]);
        }

        if (portfolio.percentageCNY !== 0) {
            data.push(['🇨🇳CNY', portfolio.percentageCNY]);
        }

        if (portfolio.percentageDKK !== 0) {
            data.push(['🇩🇰DKK', portfolio.percentageDKK]);
        }

        if (portfolio.percentageEUR !== 0) {
            data.push(['🇪🇺EUR', portfolio.percentageEUR]);
        }

        if (portfolio.percentageGBP !== 0) {
            data.push(['🇬🇧GBP', portfolio.percentageGBP]);
        }

        if (portfolio.percentageHKD !== 0) {
            data.push(['🇭🇰HKD', portfolio.percentageHKD]);
        }

        if (portfolio.percentageHUF !== 0) {
            data.push(['🇭🇺HUF', portfolio.percentageHUF]);
        }

        if (portfolio.percentageIDR !== 0) {
            data.push(['🇮🇩IDR', portfolio.percentageIDR]);
        }

        if (portfolio.percentageILS !== 0) {
            data.push(['🇮🇱ILS', portfolio.percentageILS]);
        }

        if (portfolio.percentageINR !== 0) {
            data.push(['🇮🇳INR', portfolio.percentageINR]);
        }

        if (portfolio.percentageJPY !== 0) {
            data.push(['🇯🇵JPY', portfolio.percentageJPY]);
        }

        if (portfolio.percentageKWD !== 0) {
            data.push(['🇰🇼KWD', portfolio.percentageKWD]);
        }

        if (portfolio.percentageMXN !== 0) {
            data.push(['🇲🇽MXN', portfolio.percentageMXN]);
        }

        if (portfolio.percentageMYR !== 0) {
            data.push(['🇲🇾MYR', portfolio.percentageMYR]);
        }

        if (portfolio.percentageNOK !== 0) {
            data.push(['🇳🇴NOK', portfolio.percentageNOK]);
        }

        if (portfolio.percentageNZD !== 0) {
            data.push(['🇳🇿NZD', portfolio.percentageNZD]);
        }

        if (portfolio.percentagePHP !== 0) {
            data.push(['🇵🇭PHP', portfolio.percentagePHP]);
        }

        if (portfolio.percentagePKR !== 0) {
            data.push(['🇵🇰PKR', portfolio.percentagePKR]);
        }

        if (portfolio.percentagePLN !== 0) {
            data.push(['🇵🇱PLN', portfolio.percentagePLN]);
        }

        if (portfolio.percentageQAR !== 0) {
            data.push(['🇶🇦QAR', portfolio.percentageQAR]);
        }

        if (portfolio.percentageRUB !== 0) {
            data.push(['🇷🇺RUB', portfolio.percentageRUB]);
        }

        if (portfolio.percentageSAR !== 0) {
            data.push(['🇸🇦SAR', portfolio.percentageSAR]);
        }

        if (portfolio.percentageSEK !== 0) {
            data.push(['🇸🇪SEK', portfolio.percentageSEK]);
        }

        if (portfolio.percentageSGD !== 0) {
            data.push(['🇸🇬SGD', portfolio.percentageSGD]);
        }

        if (portfolio.percentageTHB !== 0) {
            data.push(['🇹🇭THB', portfolio.percentageTHB]);
        }

        if (portfolio.percentageTRY !== 0) {
            data.push(['🇹🇷TRY', portfolio.percentageTRY]);
        }

        if (portfolio.percentageTWD !== 0) {
            data.push(['🇹🇼TWD', portfolio.percentageTWD]);
        }

        if (portfolio.percentageUSD !== 0) {
            data.push(['🇺🇸USD', portfolio.percentageUSD]);
        }

        if (portfolio.percentageVND !== 0) {
            data.push(['🇻🇳VND', portfolio.percentageVND]);
        }

        if (portfolio.percentageZAR !== 0) {
            data.push(['🇿🇦ZAR', portfolio.percentageZAR]);
        }

        return data;
    }
}

let highChartOption = function () {
    return {
        title: {
            text: 'Portfolio Growth', align: 'left'
        },

        yAxis: {
            title: {
                text: 'Portfolio Balance'
            }, min: 0, max: null, tickInterval: 100
        },

        xAxis: {
            type: 'datetime', title: {
                text: 'Date'
            }, rangeSelector: {
                inputDateFormat: '%b %e, %Y'
            }
        },

        legend: {
            layout: 'vertical', align: 'right', verticalAlign: 'middle'
        },

        plotOptions: {
            series: {
                label: {
                    connectorAllowed: false
                }, pointStart: 2010
            }
        },

        series: [],

        responsive: {
            rules: [{
                condition: {
                    maxWidth: 500
                }, chartOptions: {
                    legend: {
                        layout: 'horizontal', align: 'center', verticalAlign: 'bottom'
                    }
                }
            }]
        }
    }
}