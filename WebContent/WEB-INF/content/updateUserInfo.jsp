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
<%@include file="script.html" %>
</head>
<body>
<form id="ff" action="updateUserInfo.do" method="post" enctype="multipart/form-data">
	<table align="center">
		<tr>
			<td><label id="chooseImage">上传头像</label></td>
			<td>
				<input type="file" id="headImage" />
				<img alt="" src="" id="previewImage" width="100" height="110">
				<input type="hidden" id="headImage" value="${user.headImage }" />
			</td>
		</tr>
		<tr>
			<td>用户名：</td>
			<td><input type="text" id="username" name="username" class="easyui-textbox" style="width:200px" value="${user.username}"/>
				<input type="hidden" id="id" name="id" value="${user.id }" />
			</td>
		</tr>
		<tr>
			<td>性别：</td>
			<td>
				<input type="radio" name="sex" id="optionsRadios1" value="男"/>男
	    		<input type="radio" name="sex" id="optionsRadios2" value="女" />女
	    	</td>
	    </tr>
	    <tr>
	    	<td>出生日期：</td>
	    	<td><input class="easyui-datebox" id="mdate" name="birthday" ></input></td>
	    </tr>
	    <tr>
	    	<td>手机号：</td>
	    	<td><input class="easyui-textbox" type="text" id="tel" name="tel" value="${user.tel }"></input></td>
	    </tr>
	    <tr>
   			<td>住址：</td>
   			<td><input class="easyui-textbox" type="text" id="address" name="address" value="${user.address }"></input></td>
   		</tr>
	</table>
	<div style="text-align:center;padding:5px">
	    	<a href="javascript:updateUserInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>
	    	&nbsp;&nbsp;&nbsp;&nbsp;
	    	<a href="javascript:reset()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">重置</a>
	    </div>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		// 设置性别
		if("${user.sex}" == "男") {
			$("input[name=sex]").eq(0).attr('checked', 'checked')
		} else {
			$("input[name=sex]").eq(1).attr('checked', 'checked')
		}
		// 设置出生日期
		$("#mdate").datebox('setValue', "${user.birthday}");
		
		// 图片回显
		$("#headImage").change(function() {
			var headImage = $("#headImage")[0].files[0];
			$("#previewImage").attr('src', window.URL.createObjectURL(file));
		})
	})
	// 点击提交按钮
	function updateUserInfo() {
		var headImage = $("#headImage")[0].files[0];
		var id = "${user.id}";
		var sex = $("input[name=sex]").val();
		var birthday = $("#mdate").datebox('getValue');
		var tel = $("#tel").val();
		var address = $("#address").val();
		var formData = new FormData();
		
		formData.append("file", headImage);
		formData.append("id", id);
		formData.append("sex", sex);
		formData.append("birthday", birthday);
		formData.append("tel", tel);
		formData.append("address", address);
		// 如果用户没有上传图片
		if(typeof(headImage) == "undefined") {
			$.ajax({
				url:"updateUserInfoNoImage.do",
				type:"post",
				data:formData,
				contentType: false,
				processData: false,
				success:function(data) {
	            	$.messager.alert('提示信息', data.message, 'info');
				}
			}) 
		} else {
			$.ajax({
				url:"updateUserInfo.do",
				type:"post",
				data:formData,
				contentType: false,
				processData: false,
				success:function(data) {
	            	$.messager.alert('提示信息', data.message, 'info');
				}
			}) 
		}
		
	}
	
</script>


</body>
</html>