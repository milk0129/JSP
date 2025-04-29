<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>historyDelete.jsp</title>
    <link rel="stylesheet" href="./../css/HistoryCss.css">
    <script src="../jas/hisDel.js"></script>
</head>
<body onload="mInit()">

<%
    request.setCharacterEncoding("UTF-8");

    String[] expIds = request.getParameterValues("expId");
    String resultMsg = "";

    if (expIds != null) {
        ExpenseDAO dao = new ExpenseDAO();
        int success = 0;

        for (String idStr : expIds) {
            try {
                int expId = Integer.parseInt(idStr);
                success += dao.deleteExpense(expId);
            } catch (Exception e) {
                // 무시
            }
        }

        if (success > 0) {
            response.sendRedirect("historySel.jsp");
            return;
        } else {
            resultMsg = "삭제 실패했습니다.";
        }
    }
%>

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

    <form method="post" action="historyDelete.jsp" onsubmit="return confirm('정말로 삭제할까요?');">
        <p class="tTitle">내역삭제</p>
        <table>
            <thead>
                <tr>
                    <th>선택</th>
                    <th>날짜</th>
                    <th>항목</th>
                    <th>금액</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String userId = (String)session.getAttribute("userId");
                    if (userId != null) {
                        ExpenseDAO dao = new ExpenseDAO();
                        List<ExpenseDTO> list = dao.getExpenseList(userId);

                        for (ExpenseDTO dto : list) {
                            String date = dto.getExpDate();
                            String item = dto.getExpItem();
                            int money = dto.getExpMoney();
                            String type = dto.getExpType();
                %>
                            <tr>
                                <td class="chkbox"><input type="checkbox" name="expId" value="<%= dto.getExpId() %>"></td>
                                <td class="mDate"><%= date %></td>
                                <td class="mItem"><%= item %></td>
                                <td class="<%= type.equals("수입") ? "mIncome" : "mOutcome" %>">
                                    <%= type.equals("수입") ? "+" : "-" %><%= String.format("%,d", money) %>원
                                </td>
                            </tr>
                <%
                        }
                    }
                %>
            </tbody>
            <tfoot>
            </tfoot>
        </table>
    <div class="buttonWrapper">
        <input type="button" value="전체선택" class="saveButton" onclick="selectAll()">
        <input type="submit" value="삭제하기" class="saveButton">
        <input type="button" value="🗑" class="trashButton" onclick="deselectAll()">
    </div>
    </form>

    <p id="resultMsg"><%= resultMsg %></p>
</div>

</body>
</html>
