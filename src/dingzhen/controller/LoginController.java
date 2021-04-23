package dingzhen.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dingzhen.util.StringUtil;
import dingzhen.util.WriterUtil;
import dingzhen.entity.Menu;
import dingzhen.entity.Role;
import dingzhen.entity.User;
import dingzhen.service.MenuService;
import dingzhen.service.RoleService;
import dingzhen.service.UserService;

/**
 * 登录
 */
@Controller
@SuppressWarnings("unchecked")
public class LoginController {

	private User user;
	private User currentUser;
	@Autowired
	private UserService<User> userService;
	@Autowired
	private MenuService<Menu> menuService;
	private Role role;
	@Autowired
	private RoleService<Role> roleService;
	private Map map;
	
	//登录验证
	@RequestMapping("login")
	public void login(HttpServletRequest request,HttpServletResponse response){
		try {
			HttpSession session = request.getSession();
			String userName=request.getParameter("userName");
			String password=request.getParameter("password");
			request.setAttribute("userName", userName);
			request.setAttribute("password", password);
			map = new HashMap<String, String>();
			map.put("userName", userName);
			map.put("password", password);
			currentUser = userService.loginUser(map);
			if(currentUser==null){
				request.setAttribute("error", "用户名或密码错误");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}else{
				role = roleService.findOneRole(currentUser.getRoleId());
				String roleName=role.getRoleName();
				currentUser.setRoleName(roleName);
				session.setAttribute("currentUser", currentUser);
				session.setAttribute("currentOperationIds", role.getOperationIds());
				if(roleName.equals("教师")||roleName.equals("学生")) {
					response.sendRedirect("userMain.htm");
				}else {
					response.sendRedirect("main.htm");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//登录验证
	@RequestMapping("userLogin")
	public void userLogin(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			HttpSession session = request.getSession();
			String userName=request.getParameter("userName");
			String password=request.getParameter("password");
			request.setAttribute("userName", userName);
			request.setAttribute("password", password);
			map = new HashMap<String, String>();
			map.put("userName", userName);
			map.put("password", password);
			currentUser = userService.loginUser(map);
			if(currentUser==null){
				result.put("returnCode","用户名或密码错误");
			}else{
				role = roleService.findOneRole(currentUser.getRoleId());
				String roleName=role.getRoleName();
				currentUser.setRoleName(roleName);
				session.setAttribute("currentUser", currentUser);
				result.put("returnCode",200);
			}
		} catch (Exception e) {
			result.put("returnCode", "对不起，操作失败");
			e.printStackTrace();
		}
		WriterUtil.write(response, result.toString());
	}
	
	// 进入管理员主界面
	@RequestMapping("main")
	public String toMain(HttpServletRequest request){
		Object attribute = request.getSession().getAttribute("currentUser");
		if(attribute == null){
			return "redirect:login.htm";
		}
		//return "main";
		return "sys/main";
	}
	
	//进入用户主界面
	@RequestMapping("userMain")
	public String toUserMain(HttpServletRequest request){
		Object attribute = request.getSession().getAttribute("currentUser");
		if(attribute == null){
			return "redirect:login.htm";
		}
		//return "main";
		return "client/index";
	}
	
	// 加载最上级左菜单树
	@RequestMapping("menuTree")
	public void getMenuTree(HttpServletRequest request,HttpServletResponse response){
		try {
			String parentId = request.getParameter("parentId");
			currentUser = (User) request.getSession().getAttribute("currentUser");
			role = roleService.findOneRole(currentUser.getRoleId());
			String[] menuIds = role.getMenuIds().split(",");
			map = new HashMap();
			map.put("parentId",parentId);
			map.put("menuIds", menuIds);
			JSONArray jsonArray = getMenusByParentId(parentId, menuIds);
			WriterUtil.write(response, jsonArray.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 递归加载所所有树菜单
	public JSONArray getMenusByParentId(String parentId,String[] menuIds)throws Exception{
		JSONArray jsonArray=this.getMenuByParentId(parentId,menuIds);
		for(int i=0;i<jsonArray.size();i++){
			JSONObject jsonObject=jsonArray.getJSONObject(i);
			if("open".equals(jsonObject.getString("state"))){
				continue;
			}else{
				jsonObject.put("children", getMenusByParentId(jsonObject.getString("id"),menuIds));
			}
		}
		return jsonArray;
	}
	
	
	// 将所有的树菜单放入easyui要求格式的json
	public JSONArray getMenuByParentId(String parentId,String[] menuIds)throws Exception{
		JSONArray jsonArray=new JSONArray();
		map= new HashMap();
		map.put("parentId",parentId);
		map.put("menuIds", menuIds);
		List<Menu> list = menuService.menuTree(map);
		for(Menu menu : list){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", menu.getMenuId());
			jsonObject.put("text", menu.getMenuName());
			jsonObject.put("iconCls", menu.getIconCls());
			JSONObject attributeObject = new JSONObject();
			attributeObject.put("menuUrl", menu.getMenuUrl());
			if(!hasChildren(menu.getMenuId(), menuIds)){
				jsonObject.put("state", "open");
			}else{
				jsonObject.put("state", menu.getState());				
			}
			jsonObject.put("attributes", attributeObject);
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	
	// 判断是不是有子孩子，人工结束递归树
	public boolean hasChildren(Integer parentId,String[] menuIds){
		boolean flag = false;
		try {
			map= new HashMap();
			map.put("parentId",parentId);
			map.put("menuIds", menuIds);
			List<Menu> list = menuService.menuTree(map);
			if (list == null || list.size()==0) {
				flag = false;
			}else {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	
	
	
	// 更新密码
	@RequestMapping("updatePassword")
	public void updatePassword(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String userId=request.getParameter("userId");
			String oldPassword=request.getParameter("oldpassword");
			String newPassword=request.getParameter("newpassword");
			user=new User();
			user = userService.findOneUser(Integer.parseInt(userId));
			if(user.getPassword().equals(oldPassword)) {
				user.setPassword(newPassword);
				userService.updateUser(user);
				result.put("returnCode", "200");
			}else {
				result.put("returnCode", "原密码错误，密码修改失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起！密码修改失败!");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	//安全退出
	@SuppressWarnings("unused")
	@RequestMapping("logout")
	private void logout(HttpServletRequest request,HttpServletResponse response) throws Exception{
		request.getSession().invalidate();
		response.sendRedirect("login.jsp");
	}
	
}
