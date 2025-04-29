<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>historySel.jsp</title>
    <link rel="stylesheet" href="./../css/HistoryCss.css">
    <script src="./../Jas/historyjas.js"></script>
</head>
<body onload="mInit()">

<div id="wrapper">
    <p class="pTitle">가계부</p>

    <div class="aMenu">
        <a href="./historySel.jsp">조회하기</a>
        <a href="./historyAdd.jsp">추가하기</a>
        <a href="./historyDelete.jsp">삭제하기</a>
    </div>

    <div class="monthDiv">
        <input type="button" value="◀" class="bMonth" onclick="monthChange(-1)">
        <span id="month">4월</span>
        <input type="button" value="▶" class="bMonth" onclick="monthChange(1)">
    </div>

    <img src="./../img/calEx.png" width="450px">

    <form>
        <p class="tTitle">내역조회</p>
        <table>
        <thead>
        <%
            request.setCharacterEncoding("UTF-8");

            String userId = (String) session.getAttribute("userId");

            if (userId != null) {
                ExpenseDAO dao = new ExpenseDAO();
                List<ExpenseDTO> list = dao.getExpenseList(userId);

                String lastDate = "";

                for (ExpenseDTO dto : list) {
                    String date = dto.getExpDate(); // yyyy-MM-dd
                    String item = dto.getExpItem();
                    int money = dto.getExpMoney();
                    String type = dto.getExpType(); // 수입/지출

                    // 날짜가 바뀌면 날짜 출력
                    if (!date.equals(lastDate)) {
                        lastDate = date;
        %>
                        <tr>
                            <th colspan="2" class="mDate"><%= date %><hr></th>
                        </tr>
        <%
                    }
        %>
			<tr>
			    <td class="mItem"><%= item %></td>
			    <td class="<%= type.equals("수입") ? "mIncome" : "mOutcome" %>">
			        <%= type.equals("수입") ? "+" : "-" %><%= String.format("%,d", money) %>원
			    </td>
			    <td>
			        <a href="historyUpdate.jsp?expId=<%= dto.getExpId() %>">수정</a>
			        <a href="historyDelete.jsp?expId=<%= dto.getExpId() %>" onclick="return confirm('정말 삭제할까요?')">삭제</a>
			    </td>
			</tr>
        <%
                } // end for
            } else {
        %>
            <tr><td colspan="2">로그인이 필요합니다.</td></tr>
        <%
            }
        %>
        </thead>
        
        </table>
    </form>
</div>

</body>
</html>
