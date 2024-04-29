<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<style>
    .main-content {
        padding: 0px 100px 20px 100px;
    }
</style>


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
            $('#submitButton').click(() => {
                let dict = {};

                for (let j = 1; j < i; j++) {
                    dict[$('#asset' + j).val()] = Number.parseFloat($('#allocation' + j).val());
                }

                $.ajax({
                    url: 'portfolio/create',
                    success: function (data) {
                        console.log(data);
                        alert("COMPLETE");
                    },
                    error: function () {

                    },
                });

                console.log(dict);

            });
            $('#addButton').click(() => {
                this.dummy(i++);
            });
        },

        dummy: function (i) {
            let rowDiv = document.createElement("div");
            rowDiv.classList.add("row", "asset-row");

            let assetNum = document.createElement("div");
            assetNum.classList.add("col-md-2", "separateTop");
            assetNum.textContent = "Asset" + i;

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
                country.value = "percentage_" + x.currencyCode;
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
</script>
<figure>
    <blockquote class="blockquote">
        <h1>Portfolio Composition.</h1>
    </blockquote>
    <figcaption class="blockquote-footer">
        Be considerate
    </figcaption>
</figure>
<div
        id="pfSection"
        class="portfolio-section pv-asset-classes pv-allow-expansion pv-multiple"
        data-count="3"
        data-maxrows="50"
        data-advanced="false"
>
    <div class="row bottomBorder">
        <div class="col-md-2 separateTop text-nowrap">
            <b>Asset Allocation</b>
        </div>
        <div class="col-md-4 separateTop"><b>Asset Class</b></div>
        <div class="col-md-2 separateTop text-nowrap">
            <b>Portfolio</b>
            <div
                    id="allocation-menu-1"
                    class="dropdown d-inline-block allocation-menu px-2"
            >
            </div>
        </div>
    </div>
</div>

<button id="addButton">ADD</button>
<div class="row topBorder totals-row">
    <div class="col-md-2 separateTop"><b>Total</b></div>
    <div class="col-md-2 offset-md-4 totals-column">
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
            <label class="visually-hidden" for="total1" style="display: none">Total allocation for portfolio 1</label>
            <span class="input-group-text">%</span>
        </div>
    </div>
</div>

<button id="submitButton">CREATE</button>