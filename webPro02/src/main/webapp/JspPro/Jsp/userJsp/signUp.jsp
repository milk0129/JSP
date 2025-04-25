<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.UserDTO" %>
<%@ page import="proJSP.UserDAO" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="../css/loginstyle.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String birth = request.getParameter("birth");
    String userId = request.getParameter("userId");

    String resultMsg = "";

    if (name != null && birth != null && userId != null) {
        name = name.trim();
        birth = birth.trim();
        userId = userId.trim();

        if (!name.isEmpty() && !birth.isEmpty() && !userId.isEmpty()) {
            UserDTO dto = new UserDTO(userId, name, birth);
            UserDAO dao = new UserDAO();

            boolean exists = dao.isUserExists(userId);
            if (exists) {
                resultMsg = "⚠ 이미 사용 중인 아이디입니다.";
            } else {
                int result = dao.insertUser(dto);
                resultMsg = (result > 0) ? "회원가입 성공!" : "회원가입 실패. 다시 시도해주세요.";
            }
        } else {
            resultMsg = "⚠ 모든 항목을 빠짐없이 입력해주세요.";
        }
    }
%>

    <main>
        <header>
            <h2>회원가입</h2>
        </header>

        <section>
            <form method="post" action="signUp.jsp">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" placeholder="이름" required value="<%= name != null ? name : "" %>">

                <label for="birth">생년월일</label>
                <input type="date" id="birth" name="birth" required value="<%= birth != null ? birth : "" %>">

                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디" required value="<%= userId != null ? userId : "" %>">
                <p class="info-text">5자 이상의 숫자와 영문자 조합으로 입력하세요</p>

                <button type="submit">회원가입</button>
            </form>
            <p id="resultMsg"><%= resultMsg %></p>
        </section>

        <footer>
            <p>이미 회원이신가요? <a href="login.jsp" target="mainFrame">로그인</a></p>
        </footer>
    </main>
</body>
</html>
