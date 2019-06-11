<%@page import="java.util.List"%>
<%@page import="com.bitcamp.dao.BoardDAO"%>
<%@page import="com.bitcamp.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	margin: 0 auto;
	width: 800px;
	font-size: 20px;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
}

th {
	background-color: pink;
}

#title {
	text-decoration: none;
	color: black;
}

#title:hover {
	color: #9966ff;
}

#btn{
	margin: 0 auto;
	width: 500px;
}


</style>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String search = request.getParameter("search");
		String searchtxt=request.getParameter("searchtxt");
		
		if(search==null)
			search="";
		if(searchtxt==null)
			searchtxt="";
		
		BoardDAO dao = BoardDAO.getInstance();
		List<BoardDTO> list= dao.searchList(search, searchtxt);
				
	%>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<%
				if (list.size() == 0) {
			%>
			<tr>
				<td colspan="5">해당자료가없습니다</td>
			</tr>
			<%
				}
				for (int i = 0; i < list.size(); i++) {
					BoardDTO dto = list.get(i);
			%>
			<tr>
				<td><%=dto.getTblno()%></td>
				<td><a id="title" href="detail.jsp?no=<%=dto.getTblno()%>"><%=dto.getTbltitle()%></a></td>
				<td><%=dto.getTblwriter()%></td>
				<td><%=dto.getTblwritedate()%></td>
				<td><%=dto.getViewcnt()%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
		<form method="post" action="list.jsp" id="btn">
		<select name="search">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
		</select>
		<input type="text" name="searchtxt">
		<input type="submit" value="검색">
		<input type="reset" value="취소">
		<a href="insert.jsp"><input type="button" value="추가"></a>
		</form>
</body>
</html>
