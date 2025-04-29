<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>mainAfter.jsp</title>
    <link rel="stylesheet" href="./../css/mainMenu.css">
</head>
<body>
<%
    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        userName = "회원"; // 세션 없으면 기본
    }
%>
<div id="wrapper">
    <header>
        <nav>
            <img src="../img/logo.jpg">
            <ul>
                <li><a href="outline.jsp#home" target="mainFrame">홈</a></li>
                <li><a href="outline.jsp#gaeyo" target="mainFrame">개요</a></li>

                <li class="afterLogin"><a href="../historyJsp/historyAdd.jsp" target="mainFrame"><%= userName %> 님</a></li>
				<li>
				    <form method="post" action="../mainJsp/index.jsp" style="display:inline;">
				        <button type="submit" class="logout-button">로그아웃</button>
				    </form>
				</li>
            </ul>
        </nav>
    </header>

    <div class="gubunsun"></div>

    <section>
        <iframe src="../mainJsp/outline.jsp" class="iframe" name="mainFrame"></iframe>
    </section>
</div>
</body>
</html>
