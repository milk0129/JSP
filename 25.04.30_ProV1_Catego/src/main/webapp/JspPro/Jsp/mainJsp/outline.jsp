<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>outline.jsp</title>
    <link rel="stylesheet" href="./../css/outline.css">
</head>
<body>
<hr class="visible">
<!-- 메인 화면 -->
<a name="home">
    <hr class="visible">
	<div id="main">
                <p class="mainTitle">당신의 가까운 가계부 </h1>
                <p class="subTitle">ㄱㄱㅂ</p>
                <img src="../img/mainBg.png" class="mainImg">
    </div>
    <br><br><br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br><br><br>
</a>

<!-- 개요 화면 -->
<a name="gaeyo">
    <hr class="visible">
    <br><br><br><br><br>
    <h1 class="title">Easy, Safely,<br>기본에 집중하다</h1>
    <div class="decoline"></div>
    <br><br>
    <table class="gaeyoTable">
        <tr>
            <td rowspan="4" class="gaeyoImg">
                <img src="./../img/logo.jpg" class="img">
            </td>
            <td class="tdTitle" colspan="2"> 사용해 보세요!<br></td>
        </tr>
        <tr>
            <td><img src="./../img/icon1.png"></td>
            <td class="tdCont">직관적인 내역 작성 및 확인<br>각 항목에 대해 선택 또는 입력이 가능합니다</td>
        </tr>
        <tr>
            <td><img src="./../img/icon2.png"></td>
            <td class="tdCont">안전한 데이터 관리<br>모든 데이터는 실시간으로 저장됩니다</td>
        </tr>
        <tr>
            <td><img src="./../img/icon3.png"></td>
            <td class="tdCont">내역 레이아웃의 다양성<br>항목의 모든 정보를 한 눈에 보는 엑셀형과 다이어리형 레이아웃을 제공합니다</td>
        </tr>
    </table>
</a>
<br><br><br><br>
<hr class="visible">

<!-- 개요 내 레이아웃 선택1 화면 -->
<a name="gaeyoLayout">
    <br><br><br><br>
    <h1 class="title2">당신에게 직관적인<br>레이아웃</h1>
    <div class="decoline2"></div>
    <div id="layoutOutline">
        <section class="section1">
            <img src="./../img/add.PNG">
        </section>
        <section class="section2">
            <img src="./../img/upd.PNG">
        </section>
        <section class="section1">
            <img src="./../img/chk.PNG">
        </section>
    </div>

    <br><br><br><br>
    <hr class="visible">
</a>

<!-- 개요 내 레이아웃 선택2 화면 -->
<a name="gaeyoLayout2">
    <br><br><br><br>
    <h1 class="title2">취향에 따라 선택,<br>레이아웃</h1>
    <div class="decoline2"></div>
    <div id="layoutOutline2">
        <section class="section">
            <input type="image" src="./../img/excel.PNG" class="img1">
        </section>
        <section class="section">
            <img src="./../img/cal.PNG" class="img2">
        </section>
    </div>

    <br><br><br><br>
    <hr class="visible">

    <!-- 메인 하단 copyright 부분 -->
    <div class="footer">
        <div class="gubunsun"></div>
        <p>ⓒ Copyright 1조</p>
    </div>
</a>

</body>
</html>
