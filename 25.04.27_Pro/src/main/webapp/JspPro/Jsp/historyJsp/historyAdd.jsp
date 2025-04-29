<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="java.util.*" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>historyAdd.jsp</title>
    <link rel="stylesheet" href="../css/HistoryCss.css">
    <script src="../jas/hisAdd.js"></script> 
</head>
<body onload="mInit()">

<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String resultMsg = "";

    String expDate = request.getParameter("mdate");
    String expMoney = request.getParameter("mMoney");
    String expCategory = request.getParameter("mCategory");
    String expItem = request.getParameter("mItem");
    String expMemo = request.getParameter("mMemo");
    String expType = request.getParameter("expType");

    if (expDate != null && expMoney != null && expType != null && expCategory != null && expItem != null) {
        expDate = expDate.trim();
        expMoney = expMoney.trim();
        expCategory = expCategory.trim();
        expItem = expItem.trim();
        expMemo = (expMemo != null) ? expMemo.trim() : "";

        if (!expDate.isEmpty() && !expMoney.isEmpty() && !expType.isEmpty() && !expCategory.isEmpty() && !expItem.isEmpty()) {
            try {
                ExpenseDTO dto = new ExpenseDTO(userId, expDate, expItem, Integer.parseInt(expMoney), expType, expCategory, expMemo);
                ExpenseDAO dao = new ExpenseDAO();
                int result = dao.insertExpense(dto);
                resultMsg = (result > 0) ? "내역 추가 성공!" : "내역 추가 실패!";
            } catch (Exception e) {
                resultMsg = "금액은 숫자로 입력해야 합니다.";
            }
        } else {
            resultMsg = "날짜, 금액, 카테고리, 항목, 분류(수입/지출)는 필수입니다.";
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

    <img src="../img/calEx.png" width="450px">

    <form method="post" action="historyAdd.jsp" onsubmit="return validateForm();">
        <p class="tTitle">내역추가</p>
        <table>
            <thead>
                <tr>
                    <td><label for="expType">분류</label></td>
                    <td>
                        <input type="radio" id="income" name="expType" value="수입"> 수입
                        <input type="radio" id="outcome" name="expType" value="지출"> 지출
                    </td>
                </tr>
                <tr>
                    <td><label for="mdate">날짜</label></td>
                    <td><input type="date" class="mDate" id="mdate" name="mdate"></td>
                </tr>
                <tr>
                    <td><label for="mMoney">금액</label></td>
                    <td><input type="text" id="mMoney" name="mMoney" placeholder="0"></td>
                </tr>
                <tr>
                    <td><label for="mCategory">카테고리</label></td>
                    <td><input type="text" id="mCategory" name="mCategory" placeholder="미분류"></td>
                </tr>
                <tr>
                    <td><label for="mItem">항목</label></td>
                    <td><input type="text" id="mItem" name="mItem" placeholder="입력하세요"></td>
                </tr>
                <tr>
                    <td><label for="mMemo">메모</label></td>
                    <td><input type="text" id="mMemo" name="mMemo" placeholder="입력하세요"></td>
                </tr>
            </thead>
            <tr>
                <td colspan="2">
                    <button type="submit" class="saveButton">추가하기</button>
                    <input type="button" value="🗑" class="trashButton" onclick="mReset()">
                </td>
            </tr>
        </table>
    </form>

    <p id="resultMsg"><%= resultMsg %></p>
</div>
</body>
</html>
