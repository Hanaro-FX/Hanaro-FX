<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/result.css"/>"/>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js"
        integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script>

<script>
    const asianCountries = [
        {emoji: "🇨🇳", name: "China", currencyCode: "CNY", currencyName: "Chinese Yuan"},
        {emoji: "🇭🇰", name: "Hongkong", currencyCode: "HKD", currencyName: "Hong Kong Dollar"},
        {emoji: "🇮🇳", name: "India", currencyCode: "INR", currencyName: "Indian Rupee"},
        {emoji: "🇮🇩", name: "Indonesia", currencyCode: "IDR", currencyName: "Indonesian Rupiah"},
        {emoji: "🇮🇱", name: "Israel", currencyCode: "ILS", currencyName: "Israeli New Shekel"},
        {emoji: "🇰🇼", name: "Kuwait", currencyCode: "KWD", currencyName: "Kuwaiti Dinar"},
        {emoji: "🇲🇾", name: "Malaysia", currencyCode: "MYR", currencyName: "Malaysian Ringgit"},
        {emoji: "🇧🇭", name: "Bahrain", currencyCode: "BHD", currencyName: "Bahraini Dinar"},
        {emoji: "🇵🇰", name: "Pakistan", currencyCode: "PKR", currencyName: "Pakistani Rupee"},
        {emoji: "🇵🇭", name: "Philippines", currencyCode: "PHP", currencyName: "Philippine Peso"},
        {emoji: "🇶🇦", name: "Qatar", currencyCode: "QAR", currencyName: "Qatari Riyal"},
        {emoji: "🇷🇺", name: "Russia", currencyCode: "RUB", currencyName: "Russian Ruble"},
        {emoji: "🇸🇦", name: "Saudi Arabia", currencyCode: "SAR", currencyName: "Saudi Riyal"},
        {emoji: "🇸🇬", name: "Singapore", currencyCode: "SGD", currencyName: "Singapore Dollar"},
        {emoji: "🇻🇳", name: "Vietnam", currencyCode: "VND", currencyName: "Vietnamese Dong"},
        {emoji: "🇹🇭", name: "Thailand", currencyCode: "THB", currencyName: "Thai Baht"},
        {emoji: "🇦🇪", name: "UAE", currencyCode: "AED", currencyName: "United Arab Emirates Dirham"},
        {emoji: "🇹🇼", name: "Taiwan", currencyCode: "TWD", currencyName: "New Taiwan Dollar"}
    ];
    const africanCountries = [
        {emoji: "🇿🇦", name: "South Africa", currencyCode: "ZAR", currencyName: "South African Rand"},
    ]
    const northAmericanCountries = [
        {emoji: "🇨🇦", name: "Canada", currencyCode: "CAD", currencyName: "Canadian Dollar"},
        {emoji: "🇲🇽", name: "Mexico", currencyCode: "MXN", currencyName: "Mexican Peso"},
        {emoji: "🇺🇸", name: "United States", currencyCode: "USD", currencyName: "United States Dollar"},
    ]
    const southAmericanCountries = [
        {emoji: "🇦🇷", name: "Argentina", currencyCode: "ARS", currencyName: "Argentine Peso"}
    ]
    const europeanCountries = [
        {emoji: "🇩🇰", name: "Denmark", currencyCode: "DKK", currencyName: "Danish Krone"},
        {emoji: "🇭🇺", name: "Hungary", currencyCode: "HUF", currencyName: "Hungarian Forint"},
        {emoji: "🇳🇴", name: "Norway", currencyCode: "NOK", currencyName: "Norwegian Krone"},
        {emoji: "🇸🇪", name: "Sweden", currencyCode: "SEK", currencyName: "Swedish Krona"},
        {emoji: "🇨🇭", name: "Switzerland", currencyCode: "CHF", currencyName: "Swiss Franc"},
        {emoji: "🇬🇧", name: "United Kingdom", currencyCode: "GBP", currencyName: "British Pound"},
        {emoji: "🇪🇺", name: "European Union", currencyCode: "EUR", currencyName: "Euro"},
        {emoji: "🇵🇱", name: "Poland", currencyCode: "PLN", currencyName: "Polish Zloty"}
    ]
    let allCountries = [
        ...africanCountries,
        ...asianCountries,
        ...europeanCountries,
        ...northAmericanCountries,
        ...southAmericanCountries
    ];
    let result = {
        init: function () {
            let resultData;
            $('#test-btn').click(() => {
                let dArr = [];

                resultData.forEach((x) => {
                    let tableName = '';
                    allCountries.forEach((country) => {
                        if (country.currencyCode === x[0].slice(-3)) {
                            tableName = country.name + "_" + country.currencyCode;
                        }
                    })
                    dArr.push({
                        startDate: $('#startDate').val(),
                        endDate: $('#endDate').val(),
                        tableName: tableName,
                        percentage: x[1],
                        initialAmount: Number.parseFloat($('#initialAmount').val()),
                        rebalance: $('#rebalanceType').val()
                    })
                })
                $.ajax({
                    type: "POST",
                    url: '/portfolio/testImpl',
                    contentType: 'application/json', // 전송하는 데이터의 타입을 명시
                    data: JSON.stringify(dArr), // 객체를 JSON 문자열로 변환하여 전송
                    success: function (response) {
                        // TODO: Refer to https://jsfiddle.net/api/post/library/pure/
                        console.log(response);
                    }
                });
            });

            $('#startDate').datepicker({
                startYear: 2000,
                finalYear: new Date().getFullYear(),
                monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                dateFormat: 'yy-mm-dd',
                showOtherMonths: true,
                showMonthAfterYear: true,
                changeYear: true,
                changeMonth: true,
                showOn: 'both',
                buttonImage: "https://cdn-icons-png.flaticon.com/512/2838/2838779.png",
                buttonImageOnly: true,
                minDate: new Date(2000, 0),
                maxDate: new Date(2024, 2, 31),
                yearRange: '2000:c',
                beforeShowDay: function(date) {
                    let day = date.getDay();
                    return [(day !== 0 && day !== 6), ''];
                },
                onSelect: function(selected) {
                    let selectedDate = $('#startDate').datepicker('getDate');
                    selectedDate.setDate(selectedDate.getDate() + 1);
                    $('#endDate').datepicker('option', 'minDate', selectedDate);
                    $("#ui-datepicker-div").find(".ui-state-active").removeClass("ui-state-active");
                }
            });
            $('#endDate').datepicker({
                startYear: 2000,
                finalYear: new Date().getFullYear(),
                monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                dateFormat: 'yy-mm-dd',
                showOtherMonths: true,
                showMonthAfterYear: true,
                changeYear: true,
                changeMonth: true,
                showOn: 'both',
                buttonImage: "https://cdn-icons-png.flaticon.com/512/2838/2838779.png",
                buttonImageOnly: true,
                minDate: new Date(2000, 0),
                maxDate: new Date(2024, 2, 31),
                yearRange: '2000:c',
                beforeShowDay: function(date) {
                    let day = date.getDay();
                    return [(day !== 0 && day !== 6), ''];
                },
                onSelect: function(selected) {
                    let selectedDate = $('#endDate').datepicker('getDate');
                    selectedDate.setDate(selectedDate.getDate() - 1);
                    $('#startDate').datepicker('option', 'maxDate', selectedDate);
                    $("#ui-datepicker-div").find(".ui-state-active").removeClass("ui-state-active");
                }
            });

            $.ajax({
                url: '<c:url value="/portfolio/resultImpl"/>',
                data: {'id': ${id}},
                success: function (data) {

                    let portfolioName = data.portfolioName;
                    let portfolioDesc = data.portfolioDesc;
                    let portfolioDate = data.portfolioDate;
                    let nameSpace = document.getElementById('portfolioName');
                    let descSpace = document.getElementById('portfolioDesc');
                    let dateSpace = document.getElementById('portfolioDate');

                    nameSpace.innerText = portfolioName.trim() === "" ? "제목 없는 포트폴리오" : portfolioName;
                    descSpace.innerText = portfolioDesc;
                    dateSpace.innerText = portfolioDate;
                    console.log(portfolioName, portfolioDesc, portfolioDate);
                    google.charts.load('current', {'packages': ['corechart']});
                    google.charts.setOnLoadCallback(function () {
                        drawChart(data);
                    });
                }
            })

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

            let drawChart = function (dd) {
                let currencyData = getData(dd);
                resultData = currencyData;
                let data = google.visualization.arrayToDataTable([
                    ['Currency', 'Ratio'],
                    ...currencyData
                ]);

                let options = {
                    'title': '선택한 외화',
                    'colors': [
                        '#C8E6C9', '#A5D6A7', '#81C784', '#66BB6A', '#4CAF50',
                        '#43A047', '#388E3C', '#2E7D32', '#1B5E20', '#8BC34A',
                        '#9CCC65', '#7CB342', '#689F38', '#558B2F', '#33691E',
                        '#CCFF90', '#B2FF59', '#76FF03', '#64DD17', '#00C853',
                        '#AED581', '#81C784', '#4CAF50', '#66BB6A', '#43A047',
                        '#2E7D32', '#1B5E20', '#8BC34A', '#9CCC65', '#7CB342',
                        '#689F38', '#558B2F', '#33691E'
                    ],
                    'width': 400,
                    'height': 280,
                    'chartArea': {left: 10, right: 10, top: 20, bottom: 10}
                };

                let chart = new google.visualization.PieChart(document.getElementById('piechart'));
                chart.draw(data, options);
            }

        }
    };
    $(function () {
        result.init();
    });
</script>
<div style="display: none" id="validData"></div>
<div class="container">
    <div style="display: flex">
        <h3 id="portfolioName">
            <%--        <c:choose>--%>
            <%--            <c:when test="${empty portfolio.portfolioName}">--%>
            <%--                제목 없는 포트폴리오--%>
            <%--            </c:when>--%>
            <%--            <c:otherwise>--%>
            <%--                ${portfolio.portfolioName}--%>
            <%--            </c:otherwise>--%>
            <%--        </c:choose>--%>
        </h3>
        <a id="kakaotalk-sharing-btn" href="javascript:;">
            <img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
                 alt="카카오톡 공유 보내기 버튼"
                 style="height: 30px; margin-left: 10px"
                 onclick="share()"
            />
        </a>
    </div>
    <br/>

    <div class="row">
        <div class="col">
            <div class="info">
                <%-- ${portfolio.portfolioDate} --%>
                포트폴리오 생성일: <span id="portfolioDate"></span>
                    <br/>
                    <span id="portfolioDesc"></span>
<%--                <c:if test="${not empty portfolio.portfolioDesc}">--%>
<%--                    <br/>--%>
<%--                    전략 설명: ${portfolio.portfolioDesc}--%>
<%--                </c:if>--%>
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
                            <option value="9000" selected="">No rebalancing</option>
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
        <div class="test-btn" id="test-btn">TEST</div>
    </div>
</div>

<script>
    let share = function(){
        let nameSpace = document.getElementById('portfolioName');
        let descSpace = document.getElementById('portfolioDesc');
        let title = nameSpace.innerText;
        let description = descSpace.innerText;
        let url = window.location.href;

        Kakao.init('825ac3e00ada1cf630540be763bf07e6'); // JavaScript key
        Kakao.Share.createDefaultButton({
            container: '#kakaotalk-sharing-btn',
            objectType: 'feed',
            content: {
                title: title,
                description: description,
                imageUrl:
                    '<c:url value="http://localhost:8080/img/Hanaro-FX.png"/>',
                link: {
                    mobileWebUrl: url,
                    webUrl: url,
                },
            },
            social: {
                likeCount: 286,
                commentCount: 45,
                sharedCount: 845,
            },
            buttons: [
                {
                    title: '웹으로 보기',
                    link: {
                        mobileWebUrl: url,
                        webUrl: url,
                    },
                },
            ],
        });
    }
</script>

<%-- 1. won_amount = Initial amount * portfolio percentage --%>
<%-- 2. 외화 수 = won_amount / (start date) 기준환율 --%>
<%-- 3. 현재 가치 = 외화 수 * (end date) 기준환율 --%>