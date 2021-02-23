<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "";
	String url = "jdbc:mysql://localhost:3306/jspstudy";
	String uid = "root";
	String upw = "1234";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, uid, upw);
		if(conn != null) {
			sql = "select mem_idx, mem_name from tb_member where mem_userid=? and mem_userpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				session.setAttribute("userid", userid);
				session.setAttribute("username", rs.getString("mem_name"));
				session.setAttribute("useridx", rs.getString("mem_idx"));
%>
				<script> 
					alert('로그인 되었습니다');
					location.href = 'login.jsp';
				</script>
<%
			}else {
%>
				<script>
					alert('아이디 또는 비밀번호를 확인하세요');
					history.back();
				</script>
<%	
			}
		}
	}catch(Exception e){
		e.printStackTrace();	
	}
%>