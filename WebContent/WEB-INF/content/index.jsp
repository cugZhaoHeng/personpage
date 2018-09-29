<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<title>Insert title here</title>
<%@include file="script.html" %>
</head>

<body>
	<div class="easyui-layout" data-options="fit:true">
		<!-- 首页顶部内容 -->
		<div data-options="region:'north'" style="height: 50px;">
			<div class="easyui-panel" style="padding: 5px;" border="false">
				<a href="#" class="easyui-linkbutton" data-options="plain:true, iconCls:'icon-home'">首页</a> 
				<a href="#" class="easyui-linkbutton" data-options="plain:true, iconCls:'icon-book'">文章</a>
				<a href="#" class="easyui-linkbutton" data-options="plain:true, iconCls:'icon-resume'">简历</a> 
				<a href="#" class="easyui-linkbutton" data-options="plain:true, iconCls:'icon-diary'">日记</a>
				<input class="easyui-searchbox" data-options="prompt:'Please Input Value',searcher:search" style="width:300px"></input>
				<a href="#" class="easyui-menubutton" data-options="menu:'#mm2',iconCls:'icon-user'">
				<img alt="" src="" id="headImage" width="25" height="25">
				</a>
				<div id="mm2" style="width:100px;">
					<div><a href="javascript:lookUserInfo()">个人信息</a></div>
					<div><a href="javascript:updateUserInfo()">修改个人信息</a></div>
					<div><a href="javascript:updatePassword()">修改密码</a></div>
					<div><a href="javascript:toLink('login.jsp')">退出登录</a></div>
				</div>
			</div>
		</div>
		<!-- 首页左边内容 -->
		<div data-options="region:'west'" title="west" style="width: 100px;">
			
		</div>
		<div data-options="region:'center', iconCls:'icon-ok'">
			<iframe width="100%" height="100%" src=""></iframe>
		</div>
		<div data-options="region:'south'" style="height: 50px;"></div>
		<div data-options="region:'east'" title="East" style="width: 100px;"></div>
		<div id="topWindow" style="overflow: hidden;"></div>
	</div>
	<script type="text/javascript">
	
		var parentWidth = $(this).width();
		var parentHeight = $(this).height();
		
		$(document).ready(function() {
			$("#headImage").attr('src', "/img/${user.headImage}")
		})
		// 搜索框事件
		function search(value){
			alert('You input: ' + value);
		}
		
		// 点击查看个人信息
		function lookUserInfo() {
			$("#topWindow").window({
				title:"个人信息",
				content:"<iframe width='100%' height='100%' src='toLookUserInfo.do'></iframe>",
				width:1000,
				height:600
			})
		}
		
		// 点击修改个人信息
		function updateUserInfo() {
			$("#topWindow").window({
				title:"修改个人信息",
				content:"<iframe width='100%' height='100%' src='toUpdateUserInfo.do'></iframe>",
				width:500,
				height:500,
				top:(parentHeight-500)/2,
				left:(parentWidth-500)/2
			})
		}
		// 点击修改密码
		function updatePassword() {
			$("#topWindow").window({
				title:"修改密码",
				content:"<iframe width='100%' height='100%' src='toUpdatePassword.do'></iframe>",
				width:600,
				height:300
			})
		}
		
		// 关闭当前子窗口
		function closeWindow() {
			$("#topWindow").window('close');
		}
		
		// 跳转到其他页面
		function toLink(url) {
			window.location.href=url;
		}
		
	</script>
</body>
</html>