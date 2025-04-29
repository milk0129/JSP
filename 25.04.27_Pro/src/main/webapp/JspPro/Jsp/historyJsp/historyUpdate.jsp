<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>historyUpdate.jsp</title>
    <link rel="stylesheet" href="./../css/HistoryCss.css">
    <script src="../jas/hisUpd.js"></script>
</head>
<body onload="mInit()">

<%
    request.setCharacterEncoding("UTF-8");

    String expIdStr = request.getParameter("expId");
    ExpenseDTO expense = null;
    String resultMsg = "";

    if (expIdStr != null) {
        try {
            int expId = Integer.parseInt(expIdStr.trim());
            ExpenseDAO dao = new ExpenseDAO();
            List<ExpenseDTO> list = dao.getExpenseList((String)session.getAttribute("userId"));
            
            for (ExpenseDTO dto : list) {
                if (dto.getExpId() == expId) {
                    expense = dto;
                    break;
                }
            }

            if (expense == null) {
                resultMsg = "해당 내역을 찾을 수 없습니다.";
            }
        } catch (Exception e) {
            resultMsg = "잘못된 접근입니다.";
        }
    }

    // 수정 form 제출 시
    if (request.getMethod().equalsIgnoreCase("POST")) {
    try {
        int expId = Integer.parseInt(request.getParameter("expId"));
        String expDate = request.getParameter("mdate");
        String expItem = request.getParameter("mItem");
        int expMoney = Integer.parseInt(request.getParameter("mMoney"));
        String expType = request.getParameter("expType");
        String expCategory = request.getParameter("mCategory");
        String expMemo = request.getParameter("mMemo");

        ExpenseDTO dto = new ExpenseDTO();
        dto.setExpId(expId);
        dto.setExpDate(expDate);
        dto.setExpItem(expItem);
        dto.setExpMoney(expMoney);
        dto.setExpType(expType);
        dto.setExpCategory(expCategory);
        dto.setExpMemo(expMemo);

        ExpenseDAO dao = new ExpenseDAO();
        int result = dao.updateExpense(dto);

        if (result > 0) {
            resultMsg = "수정 성공!";
        } else {
            resultMsg = "수정 실패!";
        }

        //수정 완료 후, 새로 DB 조회해서 expense 다시 세팅
        List<ExpenseDTO> list = dao.getExpenseList((String)session.getAttribute("userId"));
        for (ExpenseDTO updatedDto : list) {
            if (updatedDto.getExpId() == expId) {
                expense = updatedDto;
                break;
            }
        }

    } catch (Exception e) {
        resultMsg = "입력 오류입니다.";
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

    <form method="post" action="historyUpdate.jsp?expId=<%= expense != null ? expense.getExpId() : "" %>" onsubmit="return validateForm();">
        <p class="tTitle">내역수정</p>
        <table>
            <thead>
                <tr>
                    <td><label for="expType">분류</label></td>
                    <td>
                        <input type="radio" id="income" name="expType" value="수입" 
                        <%= expense != null && "수입".equals(expense.getExpType()) ? "checked" : "" %>> 수입
                        <input type="radio" id="outcome" name="expType" value="지출" 
                        <%= expense != null && "지출".equals(expense.getExpType()) ? "checked" : "" %>> 지출
                    </td>
                </tr>
                <tr>
                    <td><label for="mdate">날짜</label></td>
                    <td><input type="date" class="mDate" id="mdate" name="mdate" value="<%= expense != null ? expense.getExpDate() : "" %>" required></td>
                </tr>
                <tr>
                    <td><label for="mMoney">금액</label></td>
                    <td><input type="text" id="mMoney" name="mMoney" value="<%= expense != null ? expense.getExpMoney() : "" %>" placeholder="0" required></td>
                </tr>
                <tr>
                    <td><label for="mCategory">카테고리</label></td>
                    <td><input type="text" id="mCategory" name="mCategory" value="<%= expense != null ? expense.getExpCategory() : "" %>" placeholder="미분류"></td>
                </tr>
                <tr>
                    <td><label for="mItem">항목</label></td>
                    <td><input type="text" id="mItem" name="mItem" value="<%= expense != null ? expense.getExpItem() : "" %>" placeholder="입력하세요"></td>
                </tr>
                <tr>
                    <td><label for="mMemo">메모</label></td>
                    <td><input type="text" id="mMemo" name="mMemo" 
						value="<%= (expense != null && expense.getExpMemo() != null && !"null".equals(expense.getExpMemo())) ? expense.getExpMemo() : "" %>" 
						placeholder="입력하세요">
					</td>
                </tr>
            </thead>
            <tr>
                <td colspan="2">
                    <button type="submit" class="saveButton">수정하기</button>
                    <input type="button" value="🗑" class="trashButton" onclick="mReset()">
                </td>
            </tr>
        </table>
    </form>

    <p id="resultMsg"><%= resultMsg %></p>
</div>

</body>
</html>
