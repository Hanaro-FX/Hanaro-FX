<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<script>
    let create = {
        init: function () {
        }
    };
    $(function () {
        create.init();
    });
</script>

<div class="container-fluid">
    <form id="assetAllocationForm">
        <div class="row">
            <label for="mode" class="col-form-label col-md-3"
            >Portfolio View
                <span
                        class="fa fa-pv-info"
                        data-bs-toggle="tooltip"
                        aria-label="Choose between table or list view of asset classes"
                        data-bs-original-title="Choose between table or list view of asset classes"
                ></span>
            </label>
            <div class="col-md-3">
                <div class="select-parent">
                    <select
                            id="mode"
                            name="mode"
                            class="form-control form-select"
                    >
                        <option value="1" selected="">List View</option>
                        <option value="2">Table View</option>
                    </select>
                </div>
            </div>
        </div>
    </form>
</div>