<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.UserDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="../css/loginstyle.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("loginUserId");
    String resultMsg = "";

    if (userId != null) {
        userId = userId.trim();

        if (!userId.isEmpty()) {
            UserDAO dao = new UserDAO();
            boolean exists = dao.isUserExists(userId);

            if (exists) {
                String userName = dao.getUserName(userId); // 이름 조회
                session.setAttribute("userId", userId);     
                session.setAttribute("userName", userName); 
                resultMsg = "로그인 성공! 반갑습니다, " + userName + "님!";
            } else {
                resultMsg = "존재하지 않는 아이디입니다.";
            }
        } else {
            resultMsg = "⚠ 아이디를 입력해주세요.";
        }
    }
%>

    <main>
        <header>
            <h2>로그인</h2>
        </header>

        <section>
            <form method="post" action="login.jsp">
                <input type="text" id="loginUserId" name="loginUserId" placeholder="아이디" required
                       value="<%= userId != null ? userId : "" %>">
                <button type="submit">로그인</button>
            </form>
            <p id="resultMsg"><%= resultMsg %></p>
        </section>

        <footer>
            <p>아이디를 잊으셨나요? <a href="find-id.jsp" target="mainFrame">아이디 찾기</a></p>
            <p>아직 회원이 아니신가요? <a href="signUp.jsp" target="mainFrame">회원가입</a></p>
        </footer>
    </main>
</body>
</html>
