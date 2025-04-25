<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.UserDAO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="../css/loginstyle.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("findName");
    String birth = request.getParameter("findBirth");
    String resultMsg = "";

    if (name != null && birth != null) {
        name = name.trim();
        birth = birth.trim();

        if (!name.isEmpty() && !birth.isEmpty()) {
            UserDAO dao = new UserDAO();
            String foundId = dao.findUserId(name, birth);

            if (foundId != null) {
                resultMsg = "찾은 아이디: " + foundId;
            } else {
                resultMsg = "일치하는 회원 정보를 찾을 수 없습니다.";
            }
        } else {
            resultMsg = "⚠ 이름과 생년월일을 모두 입력해주세요.";
        }
    }
%>

    <main>
        <header>
            <h2>아이디 찾기</h2>
        </header>

        <section class="container">
            <form method="post" action="find-id.jsp">
                <label for="findName">이름</label>
                <input type="text" id="findName" name="findName" placeholder="이름" required
                       value="<%= name != null ? name : "" %>">

                <label for="findBirth">생년월일</label>
                <input type="date" id="findBirth" name="findBirth" required
                       value="<%= birth != null ? birth : "" %>">

                <button type="submit">아이디 찾기</button>
            </form>
            <p id="resultMsg"><%= resultMsg %></p>
        </section>

        <footer>
            <p><a href="login.jsp" target="mainFrame">로그인하기</a></p>
        </footer>
    </main>
</body>
</html>
