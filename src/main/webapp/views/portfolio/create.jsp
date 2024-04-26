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
        <!-- Start Year -->
        <div class="row">
            <label for="startYear" class="col-form-label col-md-3"
            >Start Year
            </label>
            <div class="col-md-2">
                <div class="select-parent">
                    <select id="startYear" name="startYear" class="form-control form-select">
                        <%
                            // Create options
                            for (int year = 1972; year <= 2024; year++) {
                        %>
                        <option value="<%= year %>" <%= year == 2024 ? "selected" : "" %>><%= year %>
                        </option>
                        <%
                            }
                        %>
                    </select>

                </div>
            </div>
        </div>

        <!-- First Month -->
        <div class="row">
            <label for="firstMonth" class="col-form-label col-md-3"
            >First Month
                <span
                        class="fa fa-pv-info"
                        data-bs-toggle="tooltip"
                        aria-label="Start month for portfolio backtest"
                        data-bs-original-title="Start month for portfolio backtest"
                ></span>
            </label>
            <div class="col-md-2">
                <div class="select-parent">
                    <select id="firstMonth" name="firstMonth" class="form-control form-select">
                        <%
                            // 반복문을 사용하여 옵션을 생성합니다.
                            String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
                            for (int i = 0; i < months.length; i++) {
                        %>
                        <option value="<%= i + 1 %>" <%= i == 0 ? "selected" : "" %>><%= months[i] %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>
        </div>

        <!-- End Year -->
        <div class="row">
            <label for="endYear" class="col-form-label col-md-3"
            >End Year
            </label>
            <div class="col-md-2">
                <div class="select-parent">
                    <select id="endYear" name="startYear" class="form-control form-select">
                        <%
                            // Create options
                            for (int year = 1972; year <= 2024; year++) {
                        %>
                        <option value="<%= year %>" <%= year == 2024 ? "selected" : "" %>><%= year %>
                        </option>
                        <%
                            }
                        %>
                    </select>

                </div>
            </div>
        </div>

        <!-- Last Month -->
        <div class="row">
            <label for="lastMonth" class="col-form-label col-md-3"
            >First Month
                <span
                        class="fa fa-pv-info"
                        data-bs-toggle="tooltip"
                        aria-label="Start month for portfolio backtest"
                        data-bs-original-title="Start month for portfolio backtest"
                ></span>
            </label>
            <div class="col-md-2">
                <div class="select-parent">
                    <select id="lastMonth" name="lastMonth" class="form-control form-select">
                        <%
                            // 반복문을 사용하여 옵션을 생성합니다.
                            for (int i = 0; i < months.length; i++) {
                        %>
                        <option value="<%= i + 1 %>" <%= i == 0 ? "selected" : "" %>><%= months[i] %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>
        </div>

    </form>
</div>