<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    String expType = request.getParameter("expType");
    String expDate = request.getParameter("mdate");
    String expItem = request.getParameter("mItem");
    String expMoney = request.getParameter("mMoney");
    String expCategory = request.getParameter("mCategory");
    String customCategory = request.getParameter("customCategory");
    String expMemo = request.getParameter("mMemo");

    // 사용자 입력으로 expCategory 교체 처리
    if ("기타".equals(expCategory) && customCategory != null && !customCategory.trim().isEmpty()) {
        expCategory = customCategory.trim(); // 사용자 입력값으로 카테고리 덮어쓰기
    }

    ExpenseDAO expenseDAO = new ExpenseDAO();
    int categoryResult = 0;

    // 사용자별 카테고리 리스트 조회
    List<String> userCategories = expenseDAO.getUserCategories(userId);

    // 기존 카테고리인지 확인
    if (userCategories.contains(expCategory)) {
        categoryResult = 1;
    } else {
        categoryResult = expenseDAO.insertUserCategory(userId, expCategory); // 신규 카테고리 저장
        userCategories = expenseDAO.getUserCategories(userId); // 목록 갱신
    }

    int expenseResult = 0;
    String resultMsg = "";

    if (expType != null && expDate != null && expItem != null && expMoney != null && expCategory != null && expMemo != null) {
        if (categoryResult > 0) {
            ExpenseDTO expenseDTO = new ExpenseDTO(userId, expDate, expItem, Integer.parseInt(expMoney), expType, expCategory, expMemo);
            expenseResult = expenseDAO.insertExpense(expenseDTO);
        }

        resultMsg = (expenseResult > 0) ? "✅ 내역 추가 완료!" : "❌ 내역 추가 실패!";
    }
%>

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

    <img src="../img/calEx.png" width="450px">

   <form id="hisAddForm" action="historyAdd.jsp" method="post">
        <p class="tableTitle">내역추가</p>
        <table class="addTable">
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
                    <td>
                        <select id="mCategory" name="mCategory" onchange="toggleCustomCategory()">
                            <!-- 기본 카테고리 -->
                            <option value="식비">식비</option>
                            <option value="교통비">교통비</option>
                            <option value="통신비">통신비</option>
                            <option value="문화생활">문화생활</option>

                            <!-- 사용자 추가 카테고리 -->
						<%
						    for (String cat : userCategories) {
						%>
							<!-- value="<%= cat %>": 서버에 전송될 값 (form 전송 시)  -->
							<!-- <%= cat %>: 사용자 화면에 보이는 텍스트  -->
                            <option value="<%= cat %>"><%= cat %></option>
						<%
						    }
						%>
                            <option value="기타">기타 (직접입력)</option>
                        </select>
                        <input type="text" id="customCategory" name="customCategory" placeholder="직접 입력" style="display:none">
                    </td>
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
