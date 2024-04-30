<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<style>
    .main-content {
        padding: 0px 100px 20px 100px;
    }

    #addButton {
        /* 테이블의 너비와 같은 너비 */
        width: 100%;
        /* 버튼 높이 설정 */
        height: 30px;
        /* 배경 색상 및 글자색 설정 */
        background-color: #ffffff;
        color: #808080;
        /* 테두리 제거 */
        border: none;
        /* 커서가 버튼 위에 있을 때 포인터로 변경 */
        cursor: pointer;
        text-align: left;
        transition: background-color 0.3s, color 0.3s;
    }

    /* 버튼에 마우스를 갖다대면 */
    #addButton:hover {
        /* 배경색과 글자색 변경 */
        background-color: #808080;
        color: #ffffff;
    }

    #submitButton {
        /* 너비 설정 */
        width: 100%;
        /* 높이 설정 */
        height: 40px;
        /* 배경색 및 글자색 설정 */
        background-color: #4CAF50; /* 녹색 */
        color: #ffffff; /* 흰색 */
        /* 테두리 및 테두리 반경 설정 */
        border: none;
        border-radius: 5px;
        /* 마우스 커서를 포인터로 변경 */
        cursor: pointer;
        /* 글꼴과 글꼴 크기 설정 */
        font-family: Arial, sans-serif;
        font-size: 16px;
        /* 버튼 안의 텍스트 정렬 */
        text-align: center;
        /* 텍스트 세로 중앙 정렬 */
        line-height: 40px;
        /* 그림자 효과 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        /* transition 효과 설정 */
        transition: background-color 0.3s, color 0.3s, box-shadow 0.3s;
    }

    /* 마우스를 버튼 위로 이동했을 때 */
    #submitButton:hover {
        /* 배경색과 글자색 변경 */
        background-color: #45a049; /* 어두운 녹색 */
        color: #ffffff; /* 흰색 */
        /* 그림자 효과 강화 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    input[type="text"],
    select {
        width: calc(100% - 10px);
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        margin-bottom: 10px;
    }

    .asset-num {
        width: calc((100% - 20px) / 3); /* 각 열의 너비를 동일하게 설정하는 부분 */
    }

</style>

<%-- TODO: Data input verification--%>

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
    let i = 1;
    let create = {
        init: function () {
            this.dummy(i++);
            $('#submitButton').click(() => {
                let dict = {};
                dict['userId'] = 1;
                dict['portfolioName'] = $('#portfolioName').val();
                dict['portfolioDesc'] = $('#portfolioDescription').val();

                for (let j = 1; j < i; j++) {
                    let key = $('#asset' + j).val();
                    let v = Number.parseFloat($('#allocation' + j).val());
                    if (dict.hasOwnProperty(key)) {
                        alert("Duplicate input");
                        return;
                    }
                    dict[key] = v;
                    if (key == "Select Currency" || v == 0) {
                        alert("Invalid Input");
                        return;
                    }
                }

                $.ajax({
                    url: '/portfolio/createImpl',
                    data: dict,
                    success: function (data) {
                        console.log(data);
                        alert("COMPLETE");
                    },
                    error: function () {

                    },
                });


            });
            $('#addButton').click(() => {
                this.dummy(i++);
            });
        },

        dummy: function (i) {
            let rowDiv = document.createElement("div");
            rowDiv.classList.add("row", "asset-row");

            let assetNum = document.createElement("div");
            assetNum.classList.add("col-md-4", "separateTop", "asset-num");
            assetNum.textContent = "Asset" + i;
            assetNum.style.fontWeight = "bold";


            let assetColumn = document.createElement("div");
            assetColumn.classList.add("col-md-4", "asset-column");

            let assetLabel = document.createElement("label");
            assetLabel.style.display = "none";
            assetLabel.htmlFor = "asset" + i;
            assetLabel.textContent = "Select asset " + i;

            let selectParent = document.createElement("div");
            selectParent.classList.add("select-parent");

            let select = this.addSelect(i);

            selectParent.append(select);
            assetColumn.append(assetLabel);
            assetColumn.append(selectParent);
            rowDiv.append(assetNum);
            rowDiv.append(assetColumn);

            let percentage = document.createElement("div");
            percentage.classList.add("col-md-2");

            let input_group = document.createElement("div");
            input_group.classList.add("input-group", "flex-nowrap", "smallMargin");

            let input = document.createElement("input");
            input.type = "number";
            input.id = "allocation" + i;
            input.name = "allocation" + i;
            input.classList.add("form-control", "fmt-pospct", "asset-weight");
            input.onchange = this.sumPercentages;

            let percentSpan = document.createElement("span");
            percentSpan.classList.add("input-group-text");
            percentSpan.innerText = "%";

            input_group.append(input, percentSpan);
            percentage.append(input_group);

            rowDiv.append(percentage);

            document.getElementById("pfSection").append(rowDiv);
        },

        addSelect: function (i) {
            let assetSelect = document.createElement("select");
            assetSelect.id = "asset" + i;
            assetSelect.name = "asset" + i;
            assetSelect.classList.add("form-control", "form-select");
            assetSelect.addEventListener("change", checkDuplicate);
            let defaultOption = document.createElement("option");
            defaultOption.innerText = "Select Currency";

            let asiaGroup = this.addCountries("Asia", asianCountries);
            let africaGroup = this.addCountries("Africa", africanCountries);
            let northAmericaGroup = this.addCountries("North America", northAmericanCountries);
            let southAmericaGroup = this.addCountries("South America", southAmericanCountries);
            let europeGroup = this.addCountries("Europe", europeanCountries);

            assetSelect.append(defaultOption, asiaGroup, africaGroup, northAmericaGroup, southAmericaGroup, europeGroup);
            return assetSelect;
        },

        addCountries: function (continent, countries) {
            let group = document.createElement("optgroup");
            group.label = continent
            countries.forEach((x) => {
                let country = document.createElement("option");
                country.value = "percentage" + x.currencyCode;
                country.textContent = x.emoji + " " + x.currencyCode + "(" + x.currencyName + ")";
                group.append(country);
            })
            return group;
        },

        sumPercentages: function () {
            let total = 0;
            for (let j = 1; j <= i; j++) {
                let allocationInput = document.getElementById("allocation" + j);
                if (allocationInput) {
                    let value = parseFloat(allocationInput.value);
                    if (!isNaN(value)) {
                        total += value;
                    }
                }
            }
            let totalCell = document.getElementById("total1");

            totalCell.value = total;

            if (total > 100) {
                totalCell.style.backgroundColor = 'rgb(255, 200, 200)';
            } else {
                totalCell.style.backgroundColor = 'rgb(223, 240, 216)';
            }

        }
    };
    $(function () {
        create.init();
    });

    function checkTotal(input) {
        let total = parseFloat(input.value);
        console.log(input.value);
        if (isNaN(total) || total <= 100) {
            input.style.backgroundColor = 'rgb(223, 240, 216)';
        } else {
            input.style.backgroundColor = 'rgb(255, 200, 200)';
        }
    }

    function checkDuplicate() {
        let selectedValue = this.value; // 현재 선택된 값

        // 모든 asset select 요소를 순회하며 현재 선택된 값과 비교
        for (let j = 1; j < i; j++) {
            // 현재 select 요소는 비교하지 않음
            if (this.id === "asset" + j) {
                continue;
            }

            // 다른 asset select 요소의 값과 비교하여 중복 여부 확인
            let otherSelect = document.getElementById("asset" + j);
            let otherValue = otherSelect.value;
            if (selectedValue === otherValue) {
                // 중복된 값을 선택한 경우, 해당 select 요소들의 배경 색을 변경
                this.style.backgroundColor = "lightcoral";
                otherSelect.style.backgroundColor = "lightcoral";
                return;
            }
        }
    }
</script>
<div>
    <div class="form-group">
        <label for="portfolioName">포트폴리오 이름</label>
        <input type="text" id="portfolioName">
    </div>

    <div class="form-group">
        <label for="portfolioDescription">포트폴리오 상세</label>
        <input type="text" id="portfolioDescription">
    </div>

    <div class="form-group">
        <label for="rebalancing">리밸런싱 주기</label>
        <select id="rebalancing" name="rebalancing" class="form-control form-select">
            <option value="0" selected>No rebalancing</option>
            <option value="12">Rebalance annually</option>
            <option value="6">Rebalance semi-annually</option>
            <option value="3">Rebalance quarterly</option>
            <option value="1">Rebalance monthly</option>
        </select>
    </div>
</div>
<hr>
<div
        id="pfSection"
        class="portfolio-section pv-asset-classes pv-allow-expansion pv-multiple"
        data-count="3"
        data-maxrows="50"
        data-advanced="false"
>
    <div class="row bottomBorder">
        <div class="col-md-4 separateTop text-nowrap">
            <b>Asset Allocation</b>
        </div>
        <div class="col-md-4 separateTop"><b>Asset Class</b></div>
        <div class="col-md-4 separateTop text-nowrap">
            <b>Portfolio</b>
            <div id="allocation-menu-1" class="dropdown d-inline-block allocation-menu px-2"></div>
        </div>
    </div>

    <hr>

</div>

<button id="addButton"><b>ADD</b></button>
<hr>
<div class="row topBorder totals-row">
    <div class="col-md-2 separateTop custom-label"><b>Total</b></div>
    <div class="col-md-2 offset-md-4 totals-column"></div>
    <div class="col-md-2 totals-column"> <!-- 변경된 열 -->
        <div class="input-group flex-nowrap smallMargin">
            <input
                    type="number"
                    id="total1"
                    name="total1"
                    class="form-control"
                    readonly=""
                    autocomplete="off"
                    style="background-color: rgb(223, 240, 216)"
            />
            <label class="visually-hidden custom-label" for="total1" style="display: none">Total allocation for
                portfolio 1</label>
            <span class="input-group-text custom-label">%</span>
        </div>
    </div>
</div>


<hr>
<button id="submitButton">CREATE</button>