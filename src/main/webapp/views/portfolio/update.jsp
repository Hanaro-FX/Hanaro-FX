<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/create-edit.css"/>"/>

<script src="<c:url value="/js/countries.js" />"></script>
<script>
    let portfolio_id = 0;
    let portfolio_text = 0;
    let update = {
        init: function () {
            // 값 불러오기
            $('#portfolioName').val("${portfolio.portfolioName}");
            $('#portfolioDescription').val("${portfolio.portfolioDesc}");

            let percentages = {};

            if (${portfolio.percentageARS} != 0) {
                percentages['percentageARS'] = ${portfolio.percentageARS};
            }

            if (${portfolio.percentageAED} != 0){
                percentages['percentageAED'] = ${portfolio.percentageAED};
            }

            if (${portfolio.percentageAUD} != 0){
                percentages['percentageAUD'] = ${portfolio.percentageAUD};
            }

            if (${portfolio.percentageBHD} != 0){
                percentages['percentageBHD'] = ${portfolio.percentageBHD};
            }

            if (${portfolio.percentageCAD} != 0){
                percentages['percentageCAD'] = ${portfolio.percentageCAD};
            }

            if (${portfolio.percentageCHF} != 0){
                percentages['percentageCHF'] = ${portfolio.percentageCHF};
            }

            if (${portfolio.percentageCNY} != 0){
                percentages['percentageCNY'] = ${portfolio.percentageCNY};
            }

            if (${portfolio.percentageDKK} != 0){
                percentages['percentageDKK'] = ${portfolio.percentageDKK};
            }

            if (${portfolio.percentageEUR} != 0){
                percentages['percentageEUR'] = ${portfolio.percentageEUR};
            }

            if (${portfolio.percentageGBP} != 0){
                percentages['percentageGBP'] = ${portfolio.percentageGBP};
            }

            if (${portfolio.percentageHKD} != 0){
                percentages['percentageHKD'] = ${portfolio.percentageHKD};
            }

            if (${portfolio.percentageHUF} != 0){
                percentages['percentageHUF'] = ${portfolio.percentageHUF};
            }

            if (${portfolio.percentageIDR} != 0){
                percentages['percentageIDR'] = ${portfolio.percentageIDR};
            }

            if (${portfolio.percentageILS} != 0){
                percentages['percentageILS'] = ${portfolio.percentageILS};
            }

            if (${portfolio.percentageINR} != 0){
                percentages['percentageINR'] = ${portfolio.percentageINR};
            }

            if (${portfolio.percentageJPY} != 0){
                percentages['percentageJPY'] = ${portfolio.percentageJPY};
            }

            if (${portfolio.percentageKWD} != 0){
                percentages['percentageKWD'] = ${portfolio.percentageKWD};
            }

            if (${portfolio.percentageMXN} != 0){
                percentages['percentageMXN'] = ${portfolio.percentageMXN};
            }

            if (${portfolio.percentageMYR} != 0){
                percentages['percentageMYR'] = ${portfolio.percentageMYR};
            }

            if (${portfolio.percentageNOK} != 0){
                percentages['percentageNOK'] = ${portfolio.percentageNOK};
            }

            if (${portfolio.percentageNZD} !=0){
                percentages['percentageNZD'] = ${portfolio.percentageNZD};
            }

            if (${portfolio.percentagePHP} != 0){
                percentages['percentagePHP'] = ${portfolio.percentagePHP};
            }

            if (${portfolio.percentagePKR} != 0){
                percentages['percentagePKR'] = ${portfolio.percentagePKR};
            }

            if (${portfolio.percentagePLN} != 0){
                percentages['percentagePLN'] = ${portfolio.percentagePLN};
            }

            if (${portfolio.percentageQAR} != 0){
                percentages['percentageQAR'] = ${portfolio.percentageQAR};
            }

            if (${portfolio.percentageRUB} != 0){
                percentages['percentageRUB'] = ${portfolio.percentageRUB};
            }

            if (${portfolio.percentageSAR} != 0){
                percentages['percentageSAR'] = ${portfolio.percentageSAR};
            }

            if (${portfolio.percentageSEK} != 0){
                percentages['percentageSEK'] = ${portfolio.percentageSEK};
            }

            if (${portfolio.percentageSGD} != 0){
                percentages['percentageSGD'] = ${portfolio.percentageSGD};
            }

            if (${portfolio.percentageTHB} != 0){
                percentages['percentageTHB'] = ${portfolio.percentageTHB};
            }

            if (${portfolio.percentageTRY} != 0){
                percentages['percentageTRY'] = ${portfolio.percentageTRY};
            }

            if (${portfolio.percentageTWD} != 0){
                percentages['percentageTWD'] = ${portfolio.percentageTWD};
            }

            if (${portfolio.percentageUSD} != 0){
                percentages['percentageUSD'] = ${portfolio.percentageUSD};
            }

            if (${portfolio.percentageVND} != 0){
                percentages['percentageVND'] = ${portfolio.percentageVND};
            }

            if (${portfolio.percentageZAR} != 0){
                percentages['percentageZAR'] = ${portfolio.percentageZAR};
            }

            for (let j = 1; j <= Object.keys(percentages).length; j++) {
                this.addRow();
                let key = Object.keys(percentages)[j - 1];
                let value = percentages[key];
                $('#asset' + j).val(key);
                $('#allocation' + j).val(value);
            }
            this.sumPercentages();

            $('#submitButton').click(() => {
                let dict = {};
                let total = 0;
                dict['userId'] = ${portfolio.id};
                dict['portfolioName'] = $('#portfolioName').val();
                dict['portfolioDesc'] = $('#portfolioDescription').val();

                for (let j = 1; j <= portfolio_id; j++) {
                    let key = $('#asset' + j).val();
                    let valSpace = $('#allocation' + j).val();
                    if (valSpace == null) continue;
                    let v = Number.parseFloat(valSpace);
                    total += v;
                    if (dict.hasOwnProperty(key)) {
                        alert("Duplicate input");
                        return;
                    }
                    if (key == "Select Currency" || v == 0) {
                        alert("Invalid Input");
                        return;
                    }
                    if (valSpace < 0) {
                        alert("Invalid Input");
                        return;
                    }
                    dict[key] = v;
                }
                if (total != 100) {
                    alert("Should be summed up to 100\nCurrently " + total);
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
                this.addRow();
            });
        },

        addRow: function () {
            portfolio_id += 1;
            portfolio_text += 1;

            let rowDiv = this.createRowElement();
            let assetNum = this.createAssetNumberElement();
            let assetColumn = this.createAssetColumnElement();
            let select = this.createSelectElement();
            let percentage = this.createPercentageElement();

            // 각 요소를 부모 요소에 추가
            assetColumn.appendChild(this.createAssetLabelElement());
            assetColumn.appendChild(this.createSelectParentElement(select));
            rowDiv.appendChild(assetNum);
            rowDiv.appendChild(assetColumn);
            rowDiv.appendChild(percentage);

            addDeleteButton(rowDiv);

            document.getElementById("pfSection").appendChild(rowDiv);
        },

        // 자산이 추가되는 행 구성.
        createRowElement: function () {
            let rowDiv = document.createElement("div");
            rowDiv.classList.add("row", "asset-row");
            return rowDiv;
        },

        // 자산에 대한 이름을 담은 부분 구성
        createAssetNumberElement: function () {
            let assetNum = document.createElement("div");
            assetNum.id = "assetText" + portfolio_id;
            assetNum.classList.add("col-md-3", "separateTop", "asset-num");
            assetNum.textContent = "Asset" + portfolio_text;
            assetNum.style.fontWeight = "bold";
            return assetNum;
        },

        // 자산에 대한 입력값을 담는 부분 구성
        createAssetColumnElement: function () {
            let assetColumn = document.createElement("div");
            assetColumn.classList.add("col-md-5", "asset-column");
            return assetColumn;
        },

        // 입력값에 대한 label 구성
        createAssetLabelElement: function () {
            let assetLabel = document.createElement("label");
            assetLabel.style.display = "none";
            assetLabel.htmlFor = "asset" + portfolio_id;
            assetLabel.textContent = "Select asset " + portfolio_text;
            return assetLabel;
        },

        // 자산으로 활용할 국가 선택 부분 구성
        createSelectParentElement: function (select) {
            let selectParent = document.createElement("div");
            selectParent.classList.add("select-parent");
            selectParent.appendChild(select);
            return selectParent;
        },

        createSelectElement: function () {
            return this.addSelect();
        },

        // 자산 비율 구성
        createPercentageElement: function () {
            let percentage = document.createElement("div");
            percentage.classList.add("col-md-2");

            let input_group = document.createElement("div");
            input_group.classList.add("input-group", "flex-nowrap", "smallMargin");

            let input = document.createElement("input");
            input.type = "number";
            input.id = "allocation" + portfolio_id;
            input.name = "allocation" + portfolio_id;
            input.classList.add("form-control", "fmt-pospct", "asset-weight");
            input.onchange = this.sumPercentages;

            let percentSpan = document.createElement("span");
            percentSpan.classList.add("input-group-text");
            percentSpan.innerText = "%";

            input_group.appendChild(input);
            input_group.appendChild(percentSpan);
            percentage.appendChild(input_group);

            return percentage;
        },

        // 국가 선택지 구성
        addSelect: function () {
            let assetSelect = document.createElement("select");
            assetSelect.id = "asset" + portfolio_id;
            assetSelect.name = "asset" + portfolio_id;
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

        // 국가 선택지 대륙별 구성
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
            for (let j = 1; j <= portfolio_id; j++) {
                let allocationInput = document.getElementById("allocation" + j);
                if (allocationInput) {
                    let value = parseFloat(allocationInput.value);
                    if (value > 100 || value < 0) {
                        allocationInput.style.backgroundColor = 'rgb(255, 200, 200)';
                    }

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

    // 국가에 대해 중복된 입력이 있는지 확인
    function checkDuplicate() {
        let selectedValue = this.value; // 현재 선택된 값

        // 모든 asset select 요소를 순회하며 현재 선택된 값과 비교
        for (let j = 1; j <= portfolio_id; j++) {
            // 현재 select 요소는 비교하지 않음
            if (this.id === "asset" + j) {
                continue;
            }

            // 다른 asset select 요소의 값과 비교하여 중복 여부 확인
            let otherSelect = document.getElementById("asset" + j);
            if (otherSelect == null) continue;
            let otherValue = otherSelect.value;
            let dupStyle = (selectedValue === otherValue) ? "rgb(255, 200, 200)" : "";

            this.style.backgroundColor = dupStyle;
            otherSelect.style.backgroundColor = dupStyle;
        }
    }

    // delete button 추가 함수
    function addDeleteButton(rowDiv) {
        // 삭제 버튼 생성
        let deleteButton = document.createElement("button");
        deleteButton.textContent = "X";
        deleteButton.classList.add("btn", "delete-button");

        // 삭제 버튼에 mouseover, mouseout 이벤트 리스너 추가
        deleteButton.addEventListener("mouseover", handleMouseOver);
        deleteButton.addEventListener("mouseout", handleMouseOut);

        // 삭제 버튼 클릭 이벤트 핸들러 등록
        deleteButton.addEventListener("click", function () {
            onDeleteButtonClick(rowDiv);
        });

        // 행의 맨 오른쪽에 삭제 버튼 추가
        rowDiv.appendChild(deleteButton);
    }

    // 삭제 버튼의 mouseover 이벤트 핸들러
    function handleMouseOver(event) {
        event.target.style.color = "red";
    }

    // 삭제 버튼의 mouseout 이벤트 핸들러
    function handleMouseOut(event) {
        event.target.style.color = "black";
    }

    // 삭제 버튼 클릭 이벤트 핸들러
    function onDeleteButtonClick(rowDiv) {
        rowDiv.querySelector("input[type='number']").value = 0;
        rowDiv.remove();
        portfolio_text--;
        update.sumPercentages();

        // 삭제된 후에 남은 모든 행의 innerText를 재설정하여 숫자순으로 정렬
        let assetTextElements = document.querySelectorAll('[id^="assetText"]');
        assetTextElements.forEach((element, index) => {
            element.innerText = "Asset" + (index + 1);
        });
    }

    $(function () {
        update.init();
    });

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