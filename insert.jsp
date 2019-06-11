<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form {
	border: 2px solid pink;
	width: 300px;
	height: 500px;
	margin: 0 auto;	
}

ul li {
	list-style: none;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<form method="post" action="insresult.jsp">
		<ul>
			<li><label for="title">제목</label> <input type="text" id="title"
				name="title"></li>
			<li><label for="content">내용</label> <textarea rows="4" cols="20"
					id="content" name="content"></textarea></li>
			<li><label for="writer">작성자</label> <input type="text"
				id="writer" name="writer"></li>
			<li><a href="list.jsp"><input type="button" value="뒤로가기"></a>
				<input type="submit" value="추가"> <input type="reset"
				value="취소"></li>
		</ul>
	</form>
</body>
</html>
