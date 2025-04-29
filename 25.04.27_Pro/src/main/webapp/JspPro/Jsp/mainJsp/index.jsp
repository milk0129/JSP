<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Index</title>
    <link rel="stylesheet" href="../css/mainMenu.css">
</head>
<body>
<div id="wrapper">
          <header>
            <nav>
              <img src="../img/logo.jpg">
              <ul>
                  <li><a href="outline.jsp#home" target="mainFrame">홈</a></li>
                  <li><a href="outline.jsp#gaeyo" target="mainFrame">개요</a></li>
                  <li><a href="../userJsp/signUp.jsp" target="mainFrame">회원가입</a></li>
                  <li><a href="../userJsp/login.jsp" target="mainFrame">로그인</a></li>
              </ul>
            </nav>
          </header>
          <div class="gubunsun"></div>
          
          <section>
            <iframe src="outline.jsp" class="iframe" name="mainFrame"></iframe>
          </section>
</div>
</body>
</html>
