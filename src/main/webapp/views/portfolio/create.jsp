<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<style>
    .main-content {
        padding: 0px 200px 20px 200px;
    }
</style>

<script>
    let create = {
        init: function () {
        }
    };
    $(function () {
        create.init();
    });
</script>

<div class="container-fluid main-content">
    <form id="assetAllocationForm">
        <select
                id="asset1"
                name="asset1"
                class="form-control form-select"
        >
            <option value="">Select asset class...</option>
            <optgroup label="Asia">
                <option value="Japan" selected="">
                    Japan
                </option>
            </optgroup>
            <optgroup label="Africa">
                <option value="Congo" selected="">
                    Congo
                </option>
            </optgroup>
            <optgroup label="North America">
                <option value="US" selected="">
                    US
                </option>
            </optgroup>
            <optgroup label="South America">
                <option value="Mexico" selected="">
                    Mexico
                </option>
            </optgroup>
            <optgroup label="South pole">
                <option value="South pole" selected="">
                    South pole
                </option>
            </optgroup>
            <optgroup label="Europe">
                <option value="Italy" selected="">
                    Italy
                </option>
            </optgroup>
            <optgroup label="Oseania">
                <option value="Osi" selected="">
                    Osi
                </option>
            </optgroup>
        </select>
    </form>
</div>