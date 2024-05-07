<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/create-edit.css"/>"/>

<script>
    const asianCountries = [
        {emoji: "🇨🇳", name: "China", currencyCode: "CNY", currencyName: "Chinese Yuan"},
        {emoji: "🇭🇰", name: "Hongkong", currencyCode: "HKD", currencyName: "Hong Kong Dollar"},
        {emoji: "🇯🇵", name: "Japan", currencyCode: "JPY", currencyName: "Japanese Yen"},
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
        {emoji: "🇹🇼", name: "Taiwan", currencyCode: "TWD", currencyName: "New Taiwan Dollar"},
        {emoji: "🇹🇷", name: "Turkey", currencyCode: "TRY", currencyName: "Turkish Lira"}
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
    const oceaniaCountries = [
        {emoji: "🇦🇺", name: "Australia", currencyCode: "AUD", currencyName: "Australian Dollar"},
        {emoji: "🇳🇿", name: "New Zealand", currencyCode: "NZD", currencyName: "New Zealand Dollar"}
    ]
    let i = 1;
    let update = {
        init: function () {
            // 값 불러오기
            $('#portfolioName').val("${portfolio.portfolioName}");
            $('#portfolioDescription').val("${portfolio.portfolioDesc}");

            let percentages = {};

            if (${portfolio.percentageARS} != 0) {
                percentages['percentageARS'] = ${portfolio.percentageARS};
            }

            if (${portfolio.percentageAED} != 0) {
                percentages['percentageAED'] = ${portfolio.percentageAED};
            }

            if (${portfolio.percentageAUD} != 0) {
                percentages['percentageAUD'] = ${portfolio.percentageAUD};
            }

            if (${portfolio.percentageBHD} != 0) {
                percentages['percentageBHD'] = ${portfolio.percentageBHD};
            }

            if (${portfolio.percentageCAD} != 0) {
                percentages['percentageCAD'] = ${portfolio.percentageCAD};
            }

            if (${portfolio.percentageCHF} != 0) {
                percentages['percentageCHF'] = ${portfolio.percentageCHF};
            }

            if (${portfolio.percentageCNY} != 0) {
                percentages['percentageCNY'] = ${portfolio.percentageCNY};
            }

            if (${portfolio.percentageDKK} != 0) {
                percentages['percentageDKK'] = ${portfolio.percentageDKK};
            }

            if (${portfolio.percentageEUR} != 0) {
                percentages['percentageEUR'] = ${portfolio.percentageEUR};
            }

            if (${portfolio.percentageGBP} != 0) {
                percentages['percentageGBP'] = ${portfolio.percentageGBP};
            }

            if (${portfolio.percentageHKD} != 0) {
                percentages['percentageHKD'] = ${portfolio.percentageHKD};
            }

            if (${portfolio.percentageHUF} != 0) {
                percentages['percentageHUF'] = ${portfolio.percentageHUF};
            }

            if (${portfolio.percentageIDR} != 0) {
                percentages['percentageIDR'] = ${portfolio.percentageIDR};
            }

            if (${portfolio.percentageILS} != 0) {
                percentages['percentageILS'] = ${portfolio.percentageILS};
            }

            if (${portfolio.percentageINR} != 0) {
                percentages['percentageINR'] = ${portfolio.percentageINR};
            }

            if (${portfolio.percentageJPY} != 0) {
                percentages['percentageJPY'] = ${portfolio.percentageJPY};
            }

            if (${portfolio.percentageKWD} != 0) {
                percentages['percentageKWD'] = ${portfolio.percentageKWD};
            }

            if (${portfolio.percentageMXN} != 0) {
                percentages['percentageMXN'] = ${portfolio.percentageMXN};
            }

            if (${portfolio.percentageMYR} != 0) {
                percentages['percentageMYR'] = ${portfolio.percentageMYR};
            }

            if (${portfolio.percentageNOK} != 0) {
                percentages['percentageNOK'] = ${portfolio.percentageNOK};
            }

            if (${portfolio.percentageNZD} != 0) {
                percentages['percentageNZD'] = ${portfolio.percentageNZD};
            }

            if (${portfolio.percentagePHP} != 0) {
                percentages['percentagePHP'] = ${portfolio.percentagePHP};
            }

            if (${portfolio.percentagePKR} != 0) {
                percentages['percentagePKR'] = ${portfolio.percentagePKR};
            }

            if (${portfolio.percentagePLN} != 0) {
                percentages['percentagePLN'] = ${portfolio.percentagePLN};
            }

            if (${portfolio.percentageQAR} != 0) {
                percentages['percentageQAR'] = ${portfolio.percentageQAR};
            }

            if (${portfolio.percentageRUB} != 0) {
                percentages['percentageRUB'] = ${portfolio.percentageRUB};
            }

            if (${portfolio.percentageSAR} != 0) {
                percentages['percentageSAR'] = ${portfolio.percentageSAR};
            }

            if (${portfolio.percentageSEK} != 0) {
                percentages['percentageSEK'] = ${portfolio.percentageSEK};
            }

            if (${portfolio.percentageSGD} != 0) {
                percentages['percentageSGD'] = ${portfolio.percentageSGD};
            }

            if (${portfolio.percentageTHB} != 0) {
                percentages['percentageTHB'] = ${portfolio.percentageTHB};
            }

            if (${portfolio.percentageTRY} != 0) {
                percentages['percentageTRY'] = ${portfolio.percentageTRY};
            }

            if (${portfolio.percentageTWD} != 0) {
                percentages['percentageTWD'] = ${portfolio.percentageTWD};
            }

            if (${portfolio.percentageUSD} != 0) {
                percentages['percentageUSD'] = ${portfolio.percentageUSD};
            }

            if (${portfolio.percentageVND} != 0) {
                percentages['percentageVND'] = ${portfolio.percentageVND};
            }

            if (${portfolio.percentageZAR} != 0) {
                percentages['percentageZAR'] = ${portfolio.percentageZAR};
            }

            for (let j = 1; j <= Object.keys(percentages).length; j++) {
                this.dummy(i++);
                let key = Object.keys(percentages)[j - 1];
                let value = percentages[key];
                $('#asset' + j).val(key);
                $('#allocation' + j).val(value);
            }
            this.sumPercentages();

            $('#submitButton').click(() => {
                let dict = {};
                let total = 0;
                dict['userId'] = 1;
                dict['portfolioName'] = $('#portfolioName').val();
                dict['portfolioDesc'] = $('#portfolioDescription').val();

                for (let j = 1; j < i; j++) {
                    let key = $('#asset' + j).val();
                    let v = Number.parseFloat($('#allocation' + j).val());
                    total += v;
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
                if (total != 100) {
                    alert("Should be summed up to 100");
                    return;
                }

                $.ajax({
                    url: '/portfolio/updateImpl?id=' + ${portfolio.id},
                    data: dict,
                    success: function (data) {
                        alert("수정되었습니다.");
                        window.location.href = "/portfolio/result?id=" + ${portfolio.id};
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
            assetNum.id = "assetText" + i;
            assetNum.classList.add("col-md-3", "separateTop", "asset-num");
            assetNum.textContent = "Asset" + i;
            assetNum.style.fontWeight = "bold";


            let assetColumn = document.createElement("div");
            assetColumn.classList.add("col-md-5", "asset-column");

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

            addDeleteButton(rowDiv);

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
            let oceaniaGroup = this.addCountries("Oceania", oceaniaCountries);

            assetSelect.append(defaultOption, asiaGroup, africaGroup, northAmericaGroup, southAmericaGroup, europeGroup, oceaniaGroup);
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

            if (total > 100 || total < 0) {
                totalCell.style.backgroundColor = 'rgb(255, 200, 200)';
            } else {
                totalCell.style.backgroundColor = 'rgb(223, 240, 216)';
            }
        }
    };
    $(function () {
        update.init();
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
                this.style.backgroundColor = "rgb(255, 200, 200)";
                otherSelect.style.backgroundColor = "rgb(255, 200, 200)";
                return;
            } else {
                this.style.backgroundColor = "";
                otherSelect.style.backgroundColor = "";
            }
        }
    }

    // delete button 추가 함수
    function addDeleteButton(rowDiv) {
        // 삭제 버튼 생성
        let deleteButton = document.createElement("button");
        deleteButton.textContent = "X";
        deleteButton.classList.add("btn", "delete-button");
        deleteButton.addEventListener("mouseover", function() {
            deleteButton.style.color = "red";
        });
        deleteButton.addEventListener("mouseout", function() {
            deleteButton.style.backgroundColor = "transparent";
            deleteButton.style.color = "black";
        });
        // 삭제 버튼 클릭 이벤트 핸들러 등록
        deleteButton.addEventListener("click", function() {
            // 삭제할 행(rowDiv) 제거
            rowDiv.remove();
            i--;
            let dummyIdx = 1;
            // 삭제된 후에 남은 모든 행의 innerText를 재설정하여 숫자순으로 정렬
            let assetTextElements = document.querySelectorAll('[id^="assetText"]');
            assetTextElements.forEach((element, index) => {
                element.innerText = "Asset" + (index + 1);
            });
        });

        // 행의 맨 오른쪽에 삭제 버튼 추가
        rowDiv.append(deleteButton);
    }
</script>

<div class="container">
    <div>
        <div class="form-group">
            <label for="portfolioName">포트폴리오 이름</label>
            <input type="text" id="portfolioName">
        </div>

        <div class="form-group">
            <label for="portfolioDescription">포트폴리오 상세</label>
            <input type="text" id="portfolioDescription">
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
            <div class="col-md-3 separateTop text-nowrap">
                <b>Asset Allocation</b>
            </div>
            <div class="col-md-5 separateTop"><b>Asset Class</b></div>
            <div class="col-md-4 separateTop text-nowrap">
                <b>Portfolio</b>
                <div id="allocation-menu-1" class="dropdown d-inline-block allocation-menu px-2"></div>
            </div>
        </div>

        <hr>

    </div>

    <button id="addButton"><b>+ ADD</b></button>
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
    <button id="submitButton">UPDATE</button>
</div>
