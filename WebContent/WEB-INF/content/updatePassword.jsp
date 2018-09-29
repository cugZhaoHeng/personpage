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
<script type="text/javascript" src="static/easyui/jquery.min.js"></script>
<script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css"
	href="static/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="static/easyui/themes/icon.css" />
</head>
<body>
	<form id="ff" method="post">
	    	<table cellpadding="5"  align="center">
	    		<tr>
	    			<td>当前密码:</td>
	    			<td><input class="easyui-textbox" type="password" id="password" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>新密码:</td>
	    			<td><input class="easyui-textbox" type="password" id="password1" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>确认密码:</td>
	    			<td><input class="easyui-textbox" type="password" id="password2" data-options="required:true"></input></td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:updatePassword()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>
	    	<a href="javascript:clearForm()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
	    	<a href="#" class="easyui-toolTip" id="prompt">查看密码设置规则</a>
	    </div>
	    <script type="text/javascript">
	    	$(document).ready(function() {
	    		$("#prompt").tooltip({
	    			position: 'right',
	    	        content: '<span style="color:#fff">以字母开头，长度在6~18之间，只能包含字母、数字和下划线.</span>',
	    	        onShow: function(){
	    	    		$(this).tooltip('tip').css({
	    	    			backgroundColor: '#666',
	    	    			borderColor: '#666'
	    	    		});
					}
				});
	    	})	
	    	
	    	// 点击提交按钮
			function updatePassword() {
	    		var id = "${user.id}";
				var password = $("#password").val();
				var password1 = $("#password1").val();
				var password2 = $("#password2").val();
				
				var reg = /^[a-zA-Z]\w{5,17}$/;
				if(!password.match(reg) || password == "") {
					$.messager.alert('提示信息', '当前密码格式错误', 'info');
					return;
				}
				if(!password1.match(reg) || password == "") {
					$.messager.alert('提示信息', '新密码格式错误', 'info');
					return;
				}
				if(!password2.match(reg) || password == "") {
					$.messager.alert('提示信息', '确认密码格式错误', 'info');
					return;
				}
				if(password1 != password2) {
					$.messager.alert('提示信息', '两次密码不一致', 'info');
					return;
				}
				
				var formData = {"id":id, "password":password, "password1":password1};
				$.ajax({
					url:"updatePassword.do",
					type:"post",
					data:formData,
					dataType:"json",
					success:function(data) {
		            	$.messager.alert('提示信息', data.message, 'info', function() {
		            			window.parent.toLink("login.jsp");
		        				window.parent.closeWindow();
		            	});
					}
				})
			}
			function clearForm(){
				$('#ff').form('clear');
			}
		</script>
</body>
</html>