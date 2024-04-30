<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hanaro FX</title>

    <!-- Main CSS : Navbar, Main, Footer -->
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>

    <!-- Bootstrap CSS -->
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
            integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
            crossorigin="anonymous"
    />
    <!-- Bootstarp JS -->
    <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
    ></script>
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"
            crossorigin="anonymous"
    ></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/aa90a3ea04.js" crossorigin="anonymous"></script>

    <!--PieChart API -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <!-- Datepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-md navbar-light bg-white sticky-top">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-auto">
                    <span onclick="openNav()" class="nav-icon">
                        <div class="hamburger-icon"></div>
                        <div class="hamburger-icon"></div>
                        <div class="hamburger-icon"></div>
                    </span>
            </div>
            <div class="col-auto">
                <a class="navbar-brand" href="<c:url value="/"/>"><img src="https://i.ibb.co/N6DJGnw/logo.png" alt="로고" width="55px"></a>
            </div>
        </div>

        <!-- Side Menu -->
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <a href="<c:url value="/"/>" class="menu-item"><img src="https://i.ibb.co/PcsvJQ2/home-icon.png" alt="home" style="margin-top: -5px; width: 30px">&nbsp; HOME</a>
            <a href="<c:url value="/mypage"/>" class="menu-item"><img src="https://i.ibb.co/7tPN2jx/mypage-icon.png" alt="mypage" width="30px">&nbsp; MYPAGE</a>
            <a href="<c:url value="/portfolio/create"/>" class="menu-item"><img src="https://i.ibb.co/MB36wd6/portfolio-icon.png" alt="portfolio" width="30px">&nbsp; PORTFOLIO</a>
        </div>

        <!-- Login / Logout -->
        <div class="login-btn">LOGIN</div>
    </div>
</nav>
<br/>

<!-- Main -->
<div class="main-content">
    <c:choose>
        <c:when test="${center == null}">
            <jsp:include page="main.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="${center}.jsp"/>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<div class="footer">
    <div class="container text-center">
        <img src="https://i.ibb.co/7JFLzT3/footer-logo.png" alt="로고" width="55px">
        <div>
            <a href="#">서비스 이용약관&nbsp;&nbsp;<span>|</span></a>
            <a href="#">개인정보 처리방침&nbsp;&nbsp;<span>|</span></a>
            <a href="https://github.com/Hanaro-FX/Hanaro-FX"><img src="https://i.ibb.co/mDwgHbK/github.png" alt="깃허브" style="margin-top: -5px; width: 25px"></a>
        </div>
        <div>
            <span>Copyright © 2024 Hanaro-FX. All rights reserved.</span>
        </div>
    </div>
</div>

<script>
    function openNav() {
        document.getElementById("mySidenav").style.width = "250px";
    }
    function closeNav() {
        document.getElementById("mySidenav").style.width = "0";
    }

    $('html').click(function(e){
        if(!$(e.target).hasClass('sidenav') && !$(e.target).hasClass('nav-icon') && !$(e.target).hasClass('hamburger-icon')){
            closeNav();
        }
    });
</script>
</body>
</html>