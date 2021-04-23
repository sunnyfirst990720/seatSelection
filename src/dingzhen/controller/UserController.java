package dingzhen.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dingzhen.util.StringUtil;

import dingzhen.entity.User;
import dingzhen.service.UserService;
import dingzhen.util.WriterUtil;

/**
 * 用户管理
 */

@Controller
@RequestMapping("user")
public class UserController extends LogController{

	private int page;
	private int rows;
	private User user;
	@Autowired
	private UserService<User> userService;
	
	
	
	@RequestMapping("userIndex")
	public String index(){
		return "sys/user";
	}
	
	
	@RequestMapping("userList")
	public void userList(HttpServletRequest request,HttpServletResponse response){
		try {
			page = Integer.parseInt(request.getParameter("page"));
			rows = Integer.parseInt(request.getParameter("limit"));
			user = new User();
			user.setPage((page-1)*rows);
			user.setRows(rows);
			user.setUserName(request.getParameter("userName"));
			String roleId = request.getParameter("roleId");
			if (StringUtil.isNotEmpty(roleId)) {
				user.setRoleId(Integer.parseInt(roleId));
			} else {
				user.setRoleId(null);
			}
			List<User> list = userService.findUser(user);
			int total = userService.countUser(user);
			JSONObject jsonObj = new JSONObject();//new一个JSON
			jsonObj.put("code", 0);
			jsonObj.put("msg", "");
			jsonObj.put("count",total );//total代表一共有多少数据
			jsonObj.put("data", list);//row是代表显示的页的数据
			response.setContentType("application/json");
	        WriterUtil.write(response,jsonObj.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 新增或修改
	@RequestMapping("reserveUser")
	public void reserveUser(HttpServletRequest request,User user,HttpServletResponse response){
		String userId = request.getParameter("userId");
		JSONObject result=new JSONObject();
		try {
			if (StringUtil.isNotEmpty(userId)) {   // userId不为空 说明是修改
				user.setUserId(Integer.parseInt(userId));
				userService.updateUser(user);
				result.put("returnCode",200);
			}else {   // 添加
				if(userService.existUserWithUserName(user.getUserName())==null){  // 没有重复可以添加
					switch (user.getRoleId()) {
					case 2:
						user.setHeadPortrait("/LibrarySeatSystem/upload/headPortrait/teacher_default.jpg");
						break;
					case 3:
						user.setHeadPortrait("/LibrarySeatSystem/upload/headPortrait/student_default.jpg");
						break;
					default:
						break;
					}
					userService.addUser(user);
					result.put("returnCode",300);
				} else {
					result.put("returnCode", "该用户名被使用");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，操作失败");
		}
		response.setContentType("application/json");
		WriterUtil.write(response, result.toString());
	}
	
	
	@RequestMapping("deleteUser")
	public void delUser(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String[] ids=request.getParameter("ids").split(",");
			for (String id : ids) {
				user = userService.findOneUser(Integer.parseInt(id));
				userService.deleteUser(Integer.parseInt(id));
			}
			result.put("returnCode", 200);
			result.put("delNums", ids.length);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，删除失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	@RequestMapping("updataPortrait")
	public void updataPortrait(HttpServletRequest request,HttpServletResponse response,@RequestParam MultipartFile file,User user){
		JSONObject jsonObj = new JSONObject();//new一个JSON
		String userId = request.getParameter("userId");
		HttpSession session = request.getSession();
		try {
			if (StringUtil.isNotEmpty(userId)) {
				user.setUserId(Integer.parseInt(userId));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String now = System.currentTimeMillis()+"";
		if (!file.isEmpty()) {
			String filePath = "D:\\Tomcat 7.0\\webapps\\temp\\" + now + ".jpg";
			try {
				file.transferTo(new File(filePath));
				user.setHeadPortrait("/LibrarySeatSystem/files/" + now + ".jpg");
				userService.updateUser(user);
				
				//更新session里的用户信息
				User usertemp=(User)session.getAttribute("currentUser");
				usertemp.setHeadPortrait("/LibrarySeatSystem/files/" + now + ".jpg");
				session.setAttribute("currentUser", usertemp);
				
				jsonObj.put("code", 0);
				jsonObj.put("msg", "");
				jsonObj.put("src","/LibrarySeatSystem/files/" + now + ".jpg" );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		WriterUtil.write(response, jsonObj.toString());
	}
}
