<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="proJSP.ExpenseDAO" %>
<%@ page import="proJSP.ExpenseDTO" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>historyDelete.jsp</title>
  <link rel="stylesheet" href="./../css/HistoryCss.css">
  <script src="../jas/hisDel.js"></script>
  
</head>
<body>

<%
  request.setCharacterEncoding("UTF-8");
  String userId = (String) session.getAttribute("userId");
  String mode = request.getParameter("mode"); // "전체내역" 또는 "카테고리"
  if (mode == null) mode = "전체내역";

  ExpenseDAO dao = new ExpenseDAO();
  String resultMsg = "";

  // 항목 삭제 처리
  String[] expIds = request.getParameterValues("expId");
  if (expIds != null) {
    int success = 0;
    for (String idStr : expIds) {
      try {
        success += dao.deleteExpense(Integer.parseInt(idStr));
      } catch (Exception e) {}
    }
    if (success > 0) {
    	response.sendRedirect("historyDelete.jsp?mode=" + java.net.URLEncoder.encode("전체내역", "UTF-8"));

      return;
    } else {
      resultMsg = "내역 삭제 실패.";
    }
  }

  // 카테고리 삭제 처리
  String[] delCategories = request.getParameterValues("categoryName");
  if (delCategories != null) {
    for (String cat : delCategories) {
      dao.deleteUserCategory(userId, cat);
    }
    response.sendRedirect("historyDelete.jsp?mode=" + java.net.URLEncoder.encode("카테고리", "UTF-8"));
    return;
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

  <img src="./../img/calEx.png" width="450px">

  <!-- 콤보박스 -->
  <form method="get" action="historyDelete.jsp">
    <select name="mode" onchange="this.form.submit()">
      <option value="전체내역" <%= "전체내역".equals(mode) ? "selected" : "" %>>전체 내역</option>
      <option value="카테고리" <%= "카테고리".equals(mode) ? "selected" : "" %>>카테고리</option>
    </select>
  </form>

  <!-- 내역삭제 모드 -->
  <% if ("전체내역".equals(mode)) { 
       List<ExpenseDTO> list = dao.getExpenseList(userId);
  %>
  <form method="post" action="historyDelete.jsp" onsubmit="return confirm('정말로 삭제할까요?');">
    <input type="hidden" name="mode" value="전체내역">
    <p class="tableTitle">내역삭제</p>
    <table class="delTable">
      <thead>
        <tr>
          <th>선택</th><th>날짜</th><th>항목</th><th>금액</th>
        </tr>
      </thead>
      <tbody>
        <% for (ExpenseDTO dto : list) { %>
        <tr>
          <td><input type="checkbox" name="expId" value="<%= dto.getExpId() %>"></td>
          <td class="mDate"><%= dto.getExpDate() %></td>
          <td class="mItem"><%= dto.getExpItem() %></td>
          <td class="<%= dto.getExpType().equals("수입") ? "mIncome" : "mOutcome" %>">
            <%= dto.getExpType().equals("수입") ? "+" : "-" %><%= String.format("%,d", dto.getExpMoney()) %>원
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <div class="buttonWrapper">
      <input type="button" value="전체선택" class="saveButton" onclick="selectAll()">
      <input type="submit" value="삭제하기" class="saveButton">
      <input type="button" value="🗑" class="trashButton" onclick="deselectAll()">
    </div>
  </form>

  <% } else if ("카테고리".equals(mode)) { 
       List<String> userCats = dao.getCategoryList(userId); %>

  <!-- 카테고리 삭제 모드 -->
  <form method="post" action="historyDelete.jsp" onsubmit="return confirm('선택한 카테고리를 삭제할까요?');">
    <input type="hidden" name="mode" value="카테고리">
    <p class="tableTitle">카테고리 삭제</p>
    <table class="delTable">
      <thead>
        <tr><th>선택</th><th>카테고리명</th></tr>
      </thead>
      <tbody>
        <% for (String cat : userCats) { if (cat != null) { %>
        <tr>
          <td><input type="checkbox" name="categoryName" value="<%= cat %>"></td>
          <td><%= cat %></td>
        </tr>
        <% } } %>
      </tbody>
    </table>
    <div class="buttonWrapper">
      <input type="button" value="전체선택" class="saveButton" onclick="selectAllCategory()">
      <input type="submit" value="삭제하기" class="saveButton">
      <input type="button" value="🗑" class="trashButton" onclick="deselectAllCategory()">
    </div>
  </form>
  <% } %>

  <p id="resultMsg"><%= resultMsg %></p>
</div>

</body>
</html>
