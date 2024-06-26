<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<link rel="stylesheet" href="<c:url value="/css/mypage/mypage.css"/>"/>

<div class="container">
    <h3>${name}님의 포트폴리오</h3>
    <br/>
    <c:choose>
        <c:when test="${empty portfolioList}">
            <div class="empty-version">
                <img src="<c:url value="/img/character.png"/>" alt="character"/>
                <h5>포트폴리오가 없습니다.</h5>
                <div class="btn-create" onclick="window.location.href='<c:url value="/portfolio/create"/>'">포트폴리오 생성하기</div>
            </div>
        </c:when>
        <c:otherwise>
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
                    <tr onclick="redirectResult(${portfolio.id})">
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
                            <i class="fa-regular fa-pen-to-square" onclick="updatePortfolio(event, ${portfolio.id})" style="color: #316ed8;"></i>&nbsp;&nbsp;
                            <i class="fa-regular fa-trash-can" onclick="deletePortfolio(event, ${portfolio.id})"
                               style="color: #ff0000;"></i>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
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

    icons.forEach(function (icon) {
        icon.addEventListener('mouseover', onMouseOver);
        icon.addEventListener('mouseout', onMouseOut);
    });

    // 결과 페이지 이동
    function redirectResult(id) {
        window.location.href = '<c:url value="/portfolio/result"/>?id=' + id;
    }

    // update
    function updatePortfolio(event, id) {
        event.stopPropagation(); // 이벤트 버블링 중지
        location.href = '<c:url value="/portfolio/update"/>?id=' + id;
    }

    // delete
    function deletePortfolio(event, id) {
        event.stopPropagation(); // 이벤트 버블링 중지
        let check = confirm('포트폴리오를 삭제하시겠습니까?');
        if (check == true) {
            location.href = '<c:url value="/portfolio/delete"/>?id=' + id;
        }
    }
</script>