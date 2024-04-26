<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<link rel="stylesheet" href="<c:url value="/css/mypage/mypage.css"/>"/>

<div class="container">
    <h3>${name}님의 포트폴리오</h3>
    <br/>
    <table class="table" id="board_table">
        <thead>
            <tr>
                <th>생성일</th>
                <th>이름</th>
                <th>설명</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="portfolio" items="${portfolioList}">
                <tr>
                    <td>${portfolio.portfolioDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${empty portfolio.portfolioName}">
                                제목 없는 포트폴리오
                            </c:when>
                            <c:otherwise>
                                ${portfolio.portfolioName}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${portfolio.portfolioDesc}</td>
                    <td>
                        <i class="fa-regular fa-pen-to-square" style="color: #316ed8;"></i>&nbsp;&nbsp;
                        <i class="fa-regular fa-trash-can" style="color: #ff0000;"></i>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
    let icons = document.querySelectorAll('.fa-regular');

    function onMouseOver() {
        this.classList.remove('fa-regular');
        this.classList.add('fa-solid');
    }

    function onMouseOut() {
        this.classList.remove('fa-solid');
        this.classList.add('fa-regular');
    }

    icons.forEach(function(icon) {
        icon.addEventListener('mouseover', onMouseOver);
        icon.addEventListener('mouseout', onMouseOut);
    });
</script>