<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>historySel.jsp</title>
    <link rel="stylesheet" href="../css/HistoryCss.css">
    <script src="../jas/hisAdd.js"></script>
</head>
<body>

<div id="wrapper">
    <p class="mainTitle">가계부</p>

    <div class="linkMenu">
        <a href="./historySel.jsp">조회하기</a>
        <a href="./historyAdd.jsp">추가하기</a>
        <a href="./historyDelete.jsp">삭제하기</a>
    </div>

    <div class="monthDiv">
        <input type="button" value="◀" class="monthButton" onclick="monthChange(-1)">
        <span id="month">4월</span>
        <input type="button" value="▶" class="monthButton" onclick="monthChange(1)">
    </div>

    <img src="./../img/calEx.png" width="450px">

    <form method="get" action="historySel.jsp">
        <p class="tableTitle">내역조회</p>
        <table class = "selTable">
        <thead>
        <tr>
          <td colspan="3">
            <select name="filter" onchange="this.form.submit()">
                <option value="all" <%= "all".equals(request.getParameter("filter")) || request.getParameter("filter") == null ? "selected" : "" %>>전체내역</option>
                <option value="지출" <%= "지출".equals(request.getParameter("filter")) ? "selected" : "" %>>지출</option>
                <option value="수입" <%= "수입".equals(request.getParameter("filter")) ? "selected" : "" %>>수입</option>
            </select>
         </td>
        </tr>        
        <%
            request.setCharacterEncoding("UTF-8");

            String userId = (String) session.getAttribute("userId");
            String filter = request.getParameter("filter");

            if (userId != null) {
                ExpenseDAO dao = new ExpenseDAO();
                List<ExpenseDTO> list;

                if (filter == null || "all".equals(filter)) { 
                    list = dao.getExpenseList(userId);
                } else {
                    list = dao.getExpenseListByType(userId, filter);
                }


                String lastDate = "";

                for (ExpenseDTO dto : list) {
                    String date = dto.getExpDate(); // yyyy-MM-dd
                    String item = dto.getExpItem();
                    int money = dto.getExpMoney();
                    String type = dto.getExpType(); // 수입/지출

                    if (!date.equals(lastDate)) {
                        lastDate = date;
        %>
                        <tr>
                            <th colspan="3" class="mDate"><%= date %><hr></th>
                        </tr>
        <%
                    }
        %>
						<tr>
						    <td class="mItem"><%= item %></td>
						    <td class="mCategory">[<%= dto.getExpCategory() %>]</td> 
						    <td class="<%= type.equals("수입") ? "mIncome" : "mOutcome" %>">
						        <%= type.equals("수입") ? "+" : "-" %><%= String.format("%,d", money) %>원
						    </td>
						    <td class="mUpdate">
						        <a href="historyUpdate.jsp?expId=<%= dto.getExpId() %>">수정</a>
						        <a href="historyDelete.jsp?expId=<%= dto.getExpId() %>" onclick="return confirm('정말 삭제할까요?')">삭제</a>
						    </td>
						</tr>
        <%
                } // end for
            } else {
        %>
            <tr><td colspan="3">로그인이 필요합니다.</td></tr>
        <%
            }
        %>
        </thead>
        </table>
    </form>
</div>

</body>
</html>
