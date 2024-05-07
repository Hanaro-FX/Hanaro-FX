<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/css/portfolio/create-edit.css"/>"/>

<%-- TODO: Data input verification--%>
<script src="<c:url value="/js/countries.js" />"></script>

<script>
    let portfolio_id = 0;
    let portfolio_text = 0;
    let create = {
        init: function () {
            this.addRow();
            $('#submitButton').click(() => {
                let dict = {};
                let total = 0;
                dict['userId'] = ${userId};
                dict['portfolioName'] = $('#portfolioName').val();
                dict['portfolioDesc'] = $('#portfolioDescription').val();

                for (let j = 1; j <= portfolio_id; j++) {
                    let key = $('#asset' + j).val();
                    let valSpace = $('#allocation' + j).val();
                    if (valSpace == null) continue;
                    let v = Number.parseFloat(valSpace);
                    console.log(v);
                    total += v;
                    if (dict.hasOwnProperty(key)) {
                        alert("Duplicate input");
                        return;
                    }
                    if (key == "Select Currency" || v == 0) {
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
                    url: '/portfolio/createImpl',
                    data: dict,
                    success: function (data) {
                        console.log(data);
                        window.location.href = "/portfolio/result?id=" + parseInt(data);
                        alert("COMPLETE");
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
            let rowDiv = document.createElement("div");
            rowDiv.classList.add("row", "asset-row");

            let assetNum = document.createElement("div");
            assetNum.id = "assetText" + portfolio_id;
            assetNum.classList.add("col-md-3", "separateTop", "asset-num");
            assetNum.textContent = "Asset" + portfolio_text;
            assetNum.style.fontWeight = "bold";

            let assetColumn = document.createElement("div");
            assetColumn.classList.add("col-md-5", "asset-column");

            let assetLabel = document.createElement("label");
            assetLabel.style.display = "none";
            assetLabel.htmlFor = "asset" + portfolio_id;
            assetLabel.textContent = "Select asset " + portfolio_text;

            let selectParent = document.createElement("div");
            selectParent.classList.add("select-parent");

            let select = this.addSelect();

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
            input.id = "allocation" + portfolio_id;
            input.name = "allocation" + portfolio_id;
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
        for (let j = 1; j <= portfolio_id; j++) {
            // 현재 select 요소는 비교하지 않음
            if (this.id === "asset" + j) {
                continue;
            }

            // 다른 asset select 요소의 값과 비교하여 중복 여부 확인
            let otherSelect = document.getElementById("asset" + j);
            if (otherSelect == null) continue;
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
            rowDiv.querySelector("input[type='number']").value = 0;
            rowDiv.remove();
            portfolio_text--;
            create.sumPercentages();
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
    <button id="submitButton">CREATE</button>
</div>