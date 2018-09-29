<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<title>Insert title here</title>
</head>
<body>
<table class="easyui-datagrid">
	<thead>
		<tr>
			<td>用户名</td>
			<td>密码</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${user.username }</td>
			<td>${password }</td>
		</tr>
	</tbody>
</table>
</body>
</html>