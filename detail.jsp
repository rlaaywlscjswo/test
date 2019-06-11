<%@page import="com.bitcamp.dto.BoardDTO"%>
<%@page import="com.bitcamp.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	padding: 10px;
}

table {
	margin: 0 auto;
	width: 800px;
	font-size: 20px;
}

th {
	background-color: pink;
}

table, th, td {
	border: 1px solid;
	border-collapse: collapse;
	text-align: center;
}

#btn {
	width: 300px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%
		String searchno = request.getParameter("no");
		int no = 1;
		if (!(searchno == null) && !"".equals(searchno))
			no = Integer.parseInt(searchno);
		BoardDAO dao = BoardDAO.getInstance();
		BoardDTO dto = dao.detailList(no);
		dao.viewCount(no);
	%>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=dto.getTblno()%></td>
				<td><%=dto.getTbltitle()%></td>
				<td><%=dto.getTblcontent()%></td>
				<td><%=dto.getTblwriter()%></td>
				<td><%=dto.getTblwritedate()%></td>
				<td><%=dto.getViewcnt()%></td>
			</tr>
		</tbody>
	</table>
	<div id="btn">
		<a href="list.jsp"><input type="button" value="뒤로가기"></a> 
		<a
			href="modify.jsp?no=<%=dto.getTblno()%>">
			<input type="button"
			value="수정"></a> 
			<a href="del.jsp?no=<%=dto.getTblno()%>">
			<input type="button" value="삭제"></a>
	</div>
</body>
</html>
