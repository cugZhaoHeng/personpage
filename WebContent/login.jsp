<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head> 
  <meta charset="utf-8" /> 
  <!-- 引入EasyUI插件 -->
  <script src="static/jQuery/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
  <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css" />
  <script src="static/jQuery/jquery.cookie.js"></script>
  <link rel="shortcut icon" href="static/easyui/themes/icons/lock.png" type="image/x-icon">
  
  
 </head> 
 <body style="background-color: #ffffff;">
 	<!-- 登录面板 -->
   <div id="login_container" class="easyui-panel" title="用户登录" style="width:400px" data-options="iconCls:'icon-save'">
		<div style="padding:10px 60px 20px 60px">
	    <form id="loginForm" method="post">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-textbox" type="text" name="username" id="username" value=""></input></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="password" id="password"></input></td>
	    		</tr>
	    	</table>
			<span>&emsp;&emsp;&emsp;<input id="remember" type="checkbox" style="margin-bottom: -1.5px;" /></span>
				<span style="color: #000000">记住密码 </span>
			<span style="color: #000000">&emsp;&emsp;忘记密码 </span>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" id="login_btn">登录</a>
	    	<a href="javascript:$('#register_container').panel('open'),$('#login_container').panel('close')" class="easyui-linkbutton" id="toRegister">注册</a>
	    </div>
	    </div>
	</div>
	
	<!-- 注册面板 -->
	<div id="register_container" class="easyui-panel" title="用户注册" style="width:400px" closed="true">
		<div style="padding:10px 60px 20px 60px">
	    <form id="registerForm" method="post">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-textbox" type="text" name="register_username" id="register_username"></input></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="register_password1" id="register_password1"></input></td>
	    		</tr>
	    		<tr>
	    			<td>确认密码:</td>
	    			<td><input class="easyui-textbox" type="password" name="register_password2" id="register_password2"></input></td>
	    		</tr>
	    		<tr>
	    			<td>性别:</td>
	    			<td>
	    				<input type="radio" name="sexRadio" id="optionsRadios1" value="男" checked>男
	    				<input type="radio" name="sexRadio" id="optionsRadios2" value="女">女
	    			</td>
	    		</tr>
	    		
	    		<tr>
	    			<td>出生日期：</td>
	    			<td><input class="easyui-datebox" id="mdate"></input></td>
	    		</tr>
	    		<tr>
	    			<td>邮箱：</td>
	    			<td><input class="easyui-textbox" type="text" name="register_email" id="register_email" data-options="validType:'email'"></input></td>
	    		</tr>
	    		<tr>
	    			<td>手机号：</td>
	    			<td><input class="easyui-textbox" type="text" name="register_phone" id="register_phone"></input></td>
	    		</tr>
	    		<tr>
	    			<td>住址：</td>
	    			<td><input class="easyui-textbox" type="text" name="register_address" id="register_address"></input></td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:$('#register_container').panel('close'),$('#login_container').panel('open')" class="easyui-linkbutton" onclick="">登录</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" id="register_btn">注册</a>
	    </div>
	    </div>
	</div>
  <script>
	$(document).ready(function() {
		/* 点击登录按钮  */
		$("#login_btn").click(function() {
			var user = {"username":$("#username").val(), "password": $("#password").val()};
			$.ajax({
				url: "login.do",
				type: "post",
				data: user,
				dataType: "json",
                success: function(data) {
                	if(data.success) {
                		$.messager.alert('提示信息', data.message, 'info', function(yes) {
                    		window.location.href = "toIndex.do";
                    	})
                	} else {
                		$.messager.alert('提示信息', data.message, 'info')
                	}
                }
			})
		})
		
		/* 点击注册按钮 */
		$("#register_btn").click(function() {
			var username = $("#register_username").val();
			var password = $("#register_password1").val();
			var sex = $('input:radio[name="sexRadio"]:checked').val();
			var birthday = $('#mdate').datebox('getValue'); 
			var tel = $("#register_phone").val();
			var email = $("#register_email").val();
			var address = $("#register_address").val();
			if(username == "" || username == null) {
				$.messager.alert('提示信息', '用户名不能为空', 'info');
				return;
			}
			var user = {"username":username, "password":password, "sex":sex, 
					"birthday":birthday, "tel":tel, "email":email, "address":address}
			$.ajax({
				url:"register.do",
				type:"post",
				data:user,
				dataType:"json",
				success:function(data) {
                	$.messager.alert('提示信息', data.message, 'info');
				}
			})
		})
		
		/* 判断用户是否勾选记住密码，即浏览器中是否保存了Cookie */
		if($.cookie("rememberCookie") == "true") {
			//$("#username").val($.cookie("username"));
			$("#username").textbox('setValue', $.cookie("username"));
			$("#password").textbox('setValue', $.cookie("password"));
		}
		
		/* 如果用户勾选了记住密码，则设置下面的Cookie到浏览器中  */
		$("#remember").click(function() {
			if(this.checked) {
				var username = $("#username").val();
				var password = $("#password").val();
				$.cookie("rememberCookie", "true", {expires:7});
				$.cookie("username", username, {expires:7});
				$.cookie("password", password, {expires:7});
			} else {
				$.cookie("rememberCookie", "false", {expires:-1});
				$.cookie("username", "", {expires:-1});
				$.cookie("password", "", {expires:-1});
			}
		})
		
		
	});
</script> 
 </body>
</html>