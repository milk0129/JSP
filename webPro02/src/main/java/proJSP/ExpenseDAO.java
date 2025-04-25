package proJSP;

import commonPro.DbSet;
import commonPro.DbClose;
import proJSP.ExpenseDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExpenseDAO {

    // 수입/지출 내역 추가
    public int insertExpense(ExpenseDTO dto) {
        int result = 0;
        String sql = "INSERT INTO EXPENSES (USER_ID, EXP_DATE, EXP_ITEM, EXP_MONEY, EXP_TYPE, EXP_CATEGORY, EXP_MEMO) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DbSet.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, dto.getUserId());
            pstmt.setDate(2, Date.valueOf(dto.getExpDate()));
            pstmt.setString(3, dto.getExpItem());
            pstmt.setInt(4, dto.getExpMoney());
            pstmt.setString(5, dto.getExpType()); // "수입" or "지출"
            pstmt.setString(6, dto.getExpCategory());
            pstmt.setString(7, dto.getExpMemo());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbClose.close(pstmt, conn);
        }

        return result;
    }

    // 특정 유저의 전체 수입/지출 내역 가져오기
    public List<ExpenseDTO> getExpenseList(String userId) {
        List<ExpenseDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM EXPENSES WHERE USER_ID = ? ORDER BY EXP_DATE DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbSet.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ExpenseDTO dto = new ExpenseDTO(
                    rs.getInt("EXP_ID"),
                    rs.getString("USER_ID"),
                    rs.getDate("EXP_DATE").toString(),
                    rs.getString("EXP_ITEM"),
                    rs.getInt("EXP_MONEY"),
                    rs.getString("EXP_TYPE"),
                    rs.getString("EXP_CATEGORY"),
                    rs.getString("EXP_MEMO")
                );
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbClose.close(rs, pstmt, conn);
        }

        return list;
    }

    // 지출 ID로 삭제
    public int deleteExpense(int expId) {
        int result = 0;
        String sql = "DELETE FROM EXPENSES WHERE EXP_ID = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DbSet.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, expId);

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbClose.close(pstmt, conn);
        }

        return result;
    }

    // 지출 수정 (expId로 찾고 덮어쓰기)
    public int updateExpense(ExpenseDTO dto) {
        int result = 0;
        String sql = "UPDATE EXPENSES SET EXP_DATE = ?, EXP_ITEM = ?, EXP_MONEY = ?, " +
                     "EXP_TYPE = ?, EXP_CATEGORY = ?, EXP_MEMO = ? WHERE EXP_ID = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DbSet.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setDate(1, Date.valueOf(dto.getExpDate()));
            pstmt.setString(2, dto.getExpItem());
            pstmt.setInt(3, dto.getExpMoney());
            pstmt.setString(4, dto.getExpType());
            pstmt.setString(5, dto.getExpCategory());
            pstmt.setString(6, dto.getExpMemo());
            pstmt.setInt(7, dto.getExpId());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbClose.close(pstmt, conn);
        }

        return result;
    }

    // 총 지출 또는 수입 금액 구하기
    public int getTotalByType(String userId, String type) {
        int total = 0;
        String sql = "SELECT SUM(EXP_MONEY) AS TOTAL FROM EXPENSES WHERE USER_ID = ? AND EXP_TYPE = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DbSet.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, type); // "수입" or "지출"

            rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt("TOTAL");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbClose.close(rs, pstmt, conn);
        }

        return total;
    }
}
