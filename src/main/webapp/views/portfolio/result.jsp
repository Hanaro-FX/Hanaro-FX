<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/result.css"/>"/>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js"
        integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01"
        crossorigin="anonymous"></script>

<script src="<c:url value="/js/countries.js" />"></script>
<script src="<c:url value="/js/drawChart.js"/>"></script>

<script>
    function formatNumber(number) {
        return Number(number.toFixed(3));
    }
    function initializeDatepicker(selector, minDate, maxDate, onSelectCallback) {
        $(selector).datepicker({
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
            minDate: minDate,
            maxDate: maxDate,
            yearRange: '2000:c',
            beforeShowDay: function (date) {
                let day = date.getDay();
                return [(day !== 0 && day !== 6), ''];
            },
            onSelect: onSelectCallback
        });
    }
    let result = {
        init: function () {
            let resultData;
            $('#test-btn').click(() => {
                let dArr = [];

                let startDate = $('#startDate').val();
                let endDate = $('#endDate').val();
                if (startDate === "") {
                    alert("Start Date를 입력해주세요.");
                    return;
                }
                if (endDate === "") {
                    alert("End Date를 입력해주세요.");
                    return;
                }

                resultData.forEach((x) => {
                    let tableName = '';
                    allCountries.forEach((country) => {
                        if (country.currencyCode === x[0].slice(-3)) {
                            tableName = country.name.split(' ').join('') + "_" + country.currencyCode;
                        }
                    })
                    dArr.push({
                        startDate: startDate,
                        endDate: endDate,
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
                        // 테이블 표 보이기
                        let table = document.getElementById("resultTable");
                        table.style.display = "table";

                        let result_portfolio_name = document.getElementById('portfolioName2');
                        result_portfolio_name.innerText = document.getElementById('portfolioName').innerText;

                        let result_initial_value = document.getElementById('initialValue');
                        if(Number.parseFloat($('#initialAmount').val()) > 1000000000000) {
                            alert("Amount too large");
                            return;
                        }
                        result_initial_value.innerText = Number.parseFloat($('#initialAmount').val()) + ' ₩';

                        let result_final_value = document.getElementById('finalValue');


                        let lastDay = $('#endDate').datepicker('getDate');
                        let year = lastDay.getFullYear();
                        let month = String(lastDay.getMonth() + 1).padStart(2, '0');
                        let day = String(lastDay.getDate()).padStart(2, '0');
                        let formattedDate = year + '-' + month + '-' + day;

                        let hcOpt = highChartOption();
                        var chart = Highcharts.chart('line-chart', hcOpt);

                        // 국가명을 담은 배열
                        let dupNameArray = [];
                        Object.values(response).forEach((nameValue) => {
                            dupNameArray.push(...Object.keys(nameValue));
                        })
                        let nameArray = [...new Set(dupNameArray)];

                        // TODO: currency에 total 추가
                        nameArray.push("TOTAL");

                        nameArray.forEach(function (country) {
                            series = chart.addSeries({
                                name: country,
                                data: []
                            }, false);
                        })

                        Object.keys(response).forEach(function (date) {
                            let totalValue = 0;
                            Object.keys(response[date]).forEach(function (country) {
                                let currentCurrency = formatNumber(response[date][country]);
                                totalValue += currentCurrency; // 각 나라의 값을 총합에 더합니다.
                                const seriesIndex = nameArray.indexOf(country);
                                const series = chart.series[seriesIndex];

                                series.addPoint([Date.parse(date), currentCurrency], false);
                            });
                            const seriesIndex = nameArray.indexOf("TOTAL"); // "Total"이라는 가상의 나라를 추가합니다.
                            const series = chart.series[seriesIndex];
                            series.addPoint([Date.parse(date), formatNumber(totalValue)], false); // 각 날짜별 총합을 차트에 추가합니다.
                        });

                        chart.redraw();

                        let info_of_last_day = response[formattedDate];

                        // info_of_last_day의 값들을 가져와서 합산
                        const total = formatNumber(Object.values(info_of_last_day).reduce((acc, curr) => acc + curr, 0));

                        result_final_value.innerText = total + ' ₩';
                    },
                    error: function (xhr, status, error) {
                        let errorMessage = JSON.parse(xhr.responseText).message;
                        alert(errorMessage);
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
                beforeShowDay: function (date) {
                    let day = date.getDay();
                    return [(day !== 0 && day !== 6), ''];
                },
                onSelect: function () {
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
                beforeShowDay: function (date) {
                    let day = date.getDay();
                    return [(day !== 0 && day !== 6), ''];
                },
                onSelect: function (selected) {
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
                        resultData = drawChart(data, document.getElementById('piechart'));
                    });
                }
            })

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
        </h3>
        <a id="kakaotalk-sharing-btn" href="javascript:;" style="text-decoration: none; cursor: default;">
            <img id="editIcon" src="https://i.ibb.co/n8LQ5Ys/edit-icon.png"
                 style="width: 6%; margin-left: 5px; margin-top: 5px; cursor: pointer;"
                 alt="edit icon"
                 onmouseover="changeImage('https://i.ibb.co/YhqtB8Q/edit-icon-hover.png')"
                 onmouseout="changeImage('https://i.ibb.co/n8LQ5Ys/edit-icon.png')"
                 onclick="updatePortfolio(${id})"
            />
            <img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
                 alt="카카오톡 공유 보내기 버튼"
                 style="width: 7%; margin-left: 7px; margin-top: 5px; cursor: pointer;"
                 onclick="share()"
            />
        </a>
        <div class="list-btn" onclick="location.href = '<c:url value="/mypage"/>'">목록으로</div>
    </div>
    <br/>
    <div class="row">
        <div class="col">
            <div class="info">
                포트폴리오 생성일: <span id="portfolioDate"></span>
                <br/>
                <span id="portfolioDesc"></span>
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
                            <option value="365">년마다</option>
                            <option value="180">반년마다</option>
                            <option value="90">분기마다</option>
                            <option value="30">매달</option>
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

    <table id="resultTable" class="table">
        <tr>
            <th scope="col">Portfolio Name</th>
            <th scope="col">Initial Balance</th>
            <th scope="col">Final Balance</th>
        </tr>
        <tr>
            <td id="portfolioName2"></td>
            <td id="initialValue"></td>
            <td id="finalValue"></td>
        </tr>
    </table>

    <div class="line-chart">
        <div id="line-chart"></div>
    </div>
</div>

<script>
    function changeImage(newSrc) {
        document.getElementById("editIcon").src = newSrc;
    }

    function updatePortfolio(id) {
        location.href = '<c:url value="/portfolio/update"/>?id=' + id;
    }

    let share = function () {
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
