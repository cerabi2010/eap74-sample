<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:/jdbc/TestDS");
        conn = ds.getConnection();

        // 고의로 5초 지연
        String sql = "SELECT SLEEP(5), id, name FROM users";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>
<h2>회원 목록 (5초 후 표시)</h2>
<table border="1">
    <tr><th>ID</th><th>이름</th></tr>
<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("에러: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</table>

