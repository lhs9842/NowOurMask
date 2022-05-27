<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.AppleWebKit.WearMask.JDBCUtil" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>금일 수업 </title>
	<style>
		th{border-width : 2px; border-color : black; font-weight: 600;}
	</style>
</head>
<body>
	<h1 align = center>출석 및 조회</h1>
	<table>
		<thead>
	  		<tr>
	    		<th>순번</th>
	    		<th>학번</th>
	    		<th>성명</th>
	    		<th>출석</th>
	    		<th>태도</th>
	  		</tr>
		</thead>
		<tbody>
		<%
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			conn = JDBCUtil.getConnect();
			
			String USER_GET = "SELECT * FROM studentreport";
			pstmt = conn.prepareStatement(USER_GET);
			rs = pstmt.executeQuery();
			while(rs.next()){
				String idx = rs.getString("idx");
				String stdid = "";
				String name = "";
				String GET = "SELECT * FROM studentinfo WHERE idx=?";
				PreparedStatement pstmt_s = conn.prepareStatement(GET);
				pstmt_s.setString(1, idx);
				ResultSet rs_s = pstmt_s.executeQuery();
				if(rs_s.next()){
					stdid = rs_s.getString("stdId");
					name = rs_s.getString("name");
				}
				out.println("<tr>");
				out.println("<th>" + idx + "</th>");
				out.println("<th>" + stdid + "</th>");
				out.println("<th>" + name + "</th>");
				if(rs.getInt("attend") == 1) out.println("<th>O</th>");
				else out.println("<th>X</th>");
				if(rs.getInt("maskminuspoint") == 0) out.println("<th>0</th>");
				else out.println("<th>-" + rs.getString("maskminuspoint") + "</th>");
				out.println("</tr>");
			}
		%>
		</tbody>
	</table>
</body>
</html>