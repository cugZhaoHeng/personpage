<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head> 
  <meta charset="utf-8" /> 
  <!-- 引入BoorStrap插件 -->
  <link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css" /> 
  <link rel="stylesheet" href="static/loginPlugin/css/login.css" /> 
  <script src="static/jQuery/jquery-3.3.1.min.js"></script>
  <script src="static/jQuery/jquery.cookie.js"></script>
  <script src="static/bootstrap/js/bootstrap.js"></script>
  <!-- 引入EasyUI插件 -->
  <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
  <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css" />
  <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css" />
  <script>
	$(document).ready(function() {
	 	/* 切换为注册 */
		$("#toRegist").click(function() {
			$("#login_container").hide(500);
			$("#regist_container").show(500);
		});
		/* 切换为登录 */
		$("#toLogin").click(function() {
			$("#regist_container").hide(500);
			$("#login_container").show(500);
		});
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
		
		/* 判断用户是否勾选记住密码，即浏览器中是否保存了Cookie */
		if($.cookie("rememberCookie") == "true") {
			$("#username").val($.cookie("username"));
			$("#password").val($.cookie("password"));
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
 </head> 
 <body style="background-color: #ffffff;"> 
  <!-- 会员登录  --> 
  <div id="_start"> 
   <!--登录框--> 
   <div id="login_container"> 
    <div id="lab1"> 
     <span id="lab_login">会员登录</span> 
     <span id="lab_toRegist">  还没有账号&nbsp; <span id="toRegist" style="color: #EB9316; cursor: pointer;">立即注册</span> </span> 
    </div> 
    <div style="width: 330px;"> 
     <span id="lab_type1">手机号/账号登陆</span> 
    </div> 
    <div id="form_container1"> 
     <br /> 
     <input type="text" class="form-control" placeholder="手机号/用户名" id="username" name="username" /> 
     <input type="password" class="form-control" placeholder="密码" id="password" name="password" /> 
     <input type="button" value="登录" class="btn btn-success" id="login_btn" /> 
     <span id="rememberOrfindPwd">
     	<span><input id="remember" type="checkbox" style="margin-bottom: -1.5px;" /></span>
     	<span style="color: #000000"> 记住密码 </span>
     	<span style="color: #000000"> 忘记密码 </span>
     </span> 
    </div> 
    <div style="display: block; width: 330px;"> 
     <span id="lab_type2">使用第三方直接登陆</span> 
    </div> 
    <div style="width: 330px; height: 100px; border-bottom: 1px solid #FFFFFF;"> 
     <br /> 
     <button id="login_QQ" type="button" class="btn btn-info"> <img src="static/loginPlugin/img/qq32.png" style="width: 20px; margin-top: -4px;" /> QQ登录 </button> 
     <button id="login_WB" type="button" class="btn btn-danger"> <img src="static/loginPlugin/img/sina32.png" style="width: 20px; margin-top: -4px;" /> 微博登录 </button> 
    </div> 
   </div> 
   <!-- 会员注册 --> 
   <div id="regist_container" style="display: none;"> 
    <div id="lab1"> 
     <span id="lab_login">会员注册</span> 
     <span id="lab_toLogin">  已有账号&nbsp; <span id="toLogin" style="color: #EB9316; cursor: pointer;">立即登录</span> </span> 
    </div> 
    <div id="form_container2" style="padding-top: 25px;"> 
     <input type="text" class="form-control" placeholder="用户名" id="regist_account" /> 
     <input type="password" class="form-control" placeholder="密码" id="regist_password1" /> 
     <input type="password" class="form-control" placeholder="确认密码" id="regist_password2" /> 
     <input type="text" class="form-control" placeholder="手机号" id="regist_phone" /> 
     <input type="text" class="form-control" placeholder="验证码" id="regist_vcode" /> 
     <!--<button id="getVCode" type="button" class="btn btn-success" >获取验证码</button>--> 
     <input id="getVCode" type="button" class="btn btn-success" value="点击发送验证码" onclick="sendCode(this)" /> 
    </div> 
    <input type="button" value="注册" class="btn btn-success" id="regist_btn" /> 
   </div> 
  </div>
  
  
 
  <script type="text/javascript">
	var clock = '';
	var nums = 30;
	var btn;
	function sendCode(thisBtn) {
		btn = thisBtn;
		btn.disabled = true; //将按钮置为不可点击
		btn.value = '重新获取（' + nums + '）';
		clock = setInterval(doLoop, 1000); //一秒执行一次
	}

	function doLoop() {
		nums--;
		if (nums > 0) {
			btn.value = '重新获取（' + nums + '）';
		} else {
			clearInterval(clock); //清除js定时器
			btn.disabled = false;
			btn.value = '点击发送验证码';
			nums = 10; //重置时间
		}
	}

	$(document).ready(function() {
		$("#login_QQ").click(function() {
			alert("暂停使用！");
		});
		$("#login_WB").click(function() {
			alert("暂停使用！");
		});
	});
</script> 
 </body>
</html>