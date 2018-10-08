package com.cug.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cug.entity.User;
import com.cug.service.UserService;
import com.cug.util.EmailUtil;

@Controller
public class UserController {
	@Resource
	UserService userService;
	// 获取用户名
	@RequestMapping("getUser")
	@ResponseBody
	public String getUserById(String id) {
		User user = userService.getUserById(id);
		return user.getUsername();
	}
	
	// 登录事件
	@RequestMapping("login")
	@ResponseBody
	public Map<String, Object> login(User user, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user1 = userService.getUserByName(user.getUsername());
		if(null == user1) {
			map.put("message", "用户名不存在！");
			map.put("success", false);
		} else if(!user1.getPassword().equals(user.getPassword())) {
			map.put("message", "密码不正确！");
			map.put("success", false);
		} else {
			session.setAttribute("user", user1);
			map.put("message", "登录成功！");
			map.put("success", true);
		}
		return map;
	}
	
	// 注册事件
	@RequestMapping("register.do")
	@ResponseBody
	public Map<String, Object> register(User user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		//检测账号是否被注册过
		if(usernameIsRegistered(user.getUsername())) {
			map.put("message", "该账号已经被注册");
			map.put("success", false);
			return map;
		}
		// 检测邮箱是否被注册过
		/*if(emailIsRegistered(user.getEmail())) {
			map.put("message", "该邮箱已经被注册");
			map.put("success", false);
			return map;
		}*/
		//点击注册时向数据库中存入一个UUID识别码，并设置激活状态为activeState = 0;
		String activeCode = UUID.randomUUID().toString();
		user.setActiveCode(activeCode);
		user.setActiveState(0);
		user.setRemoveState(0);
		Integer a = userService.addUser(user);
		if(a>0) {
			String link = "http://127.0.0.1:8080/personpage/active.do?username="+user.getUsername()+"&activeCode="+activeCode;
			EmailUtil.sendMessage(link, user.getEmail());
			map.put("message", "我们向您的邮箱中发送了一个激活地址，请前往注册的邮箱中点击激活该账号");
			map.put("success", true);
		} else {
			map.put("message", "注册失败");
			map.put("success", false);
		}
		return map;
	}
	
	// 跳转到主页
	@RequestMapping("toIndex")
	public String toIndex(HttpSession session) {
		if(session.getAttribute("user") != null) {
			return "index";
		}
		return "redirect:login.jsp";
	}
	
	// 跳转到查看个人信息页面
	@RequestMapping("toLookUserInfo")
	public String lookUserInfo(String id) {
		return "lookUserInfo";
	}
	
	// 跳转到修改个人信息页面
	@RequestMapping("toUpdateUserInfo")
	public String updateUserInfo() {
		return "updateUserInfo";
	}
	
	// 跳转到修改密码页面
	@RequestMapping("toUpdatePassword")
	public String updatePassword() {
		return "updatePassword";
	}
	
	// 修改个人信息
	@RequestMapping("updateUserInfo")
	@ResponseBody
	public Map<String, Object> updateUserInfo(User user, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		//调用方法，将图片存储到服务器端
		String headImage = saveHeadImage(file, request);
		user.setHeadImage(headImage);
		boolean flag = userService.updateUserInfo(user);
		if(flag) {
			map.put("message", "修改成功");
			map.put("success", true);
		} else {
			map.put("message", "修改失败");
			map.put("success", false);
		}
		updateSession(session);
		return map;
	}
	
	// 修改个人信息，不上传头像
	@RequestMapping("updateUserInfoNoImage")
	@ResponseBody
	public Map<String, Object> updateUserInfoNoImage(User user, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = userService.updateUserInfo(user);
		if(flag) {
			map.put("message", "修改成功");
			map.put("success", true);
		} else {
			map.put("message", "修改失败");
			map.put("success", false);
		}
		updateSession(session);
		return map;
	}
	
	// 修改密码
	@RequestMapping("updatePassword")
	@ResponseBody
	public Map<String, Object> updatePassword(String id, String password, String password1) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(passwordIsTrue(id, password)) {
			boolean flag = userService.updatePassword(id,password1);
			if(flag) {
				map.put("message", "密码修改成功，请重新登录！");
				map.put("success", true);
			} else {
				map.put("message", "密码修改失败！");
				map.put("success", false);
			}
		} else {
			map.put("message", "当前密码输入错误");
			map.put("success", false);
		}
		return map;
	}
	
	// 处理上传的头像，返回保存后该图片的加密名称
     public String saveHeadImage( MultipartFile file, HttpServletRequest request) {
        //上传文件路径
        String path = request.getServletContext().getRealPath("/static/image/headImage");
    	//String path = "F:"+File.separator+"Icon"+File.separator+"headImage";
        //上传文件名
        String filename = UUID.randomUUID() + file.getOriginalFilename();
        File filepath = new File(path,filename);
        //判断路径是否存在，如果不存在就创建一个
        if (!filepath.getParentFile().exists()) { 
            filepath.getParentFile().mkdirs();
        }
        //将上传文件保存到一个目标文件当中
        try {
			file.transferTo(new File(path + File.separator + filename));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return filename;
     }
	
	// 判断账号是否被注册
	public boolean usernameIsRegistered(String username) {
		return userService.usernameIsRegistered(username);
	}
	
	// 判断邮箱是否被注册
	public boolean emailIsRegistered(String email) {
		return userService.emailIsRegistered(email);
	}
	
	// 用户在链接中点击之后，激活该账号
	@RequestMapping("active.do")
	public String active(String username, String activeCode) {
		boolean flag = userService.active(username, activeCode);
		if(flag) {
			return "login";
		} else {
			return "404";
		}
		
	}
	
	// 判断前端传入的当前密码是否正确
	public boolean passwordIsTrue(String id, String password) {
		boolean flag = userService.passwordIsTrue(id, password);
		return flag;
	}
	
	// 更改session中的user
	public void updateSession(HttpSession session) {
		User user = userService.getUserById(((User)session.getAttribute("user")).getId().toString());
		session.setAttribute("user", user);
	}
	
}
