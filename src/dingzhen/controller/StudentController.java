package dingzhen.controller;

// 学生信息
import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dingzhen.entity.Score;
import dingzhen.entity.Student;
import dingzhen.entity.User;
import dingzhen.service.ScoreService;
import dingzhen.service.StudentService;
import dingzhen.service.UserService;
import dingzhen.util.StringUtil;
import dingzhen.util.WriterUtil;

@Controller
@RequestMapping("student")
public class StudentController {

	private int page;
	private int rows;
	private Student student;
	@Autowired
	private StudentService<Student> studentService;
	@Autowired
	private ScoreService<Score> scoreService;
	private Score score;
	private User user;
	@Autowired
	private UserService<User> userService;
	
	
	@RequestMapping("studentIndex")
	public String index(){
		return "info/student";
	}
	
	
	
	@RequestMapping("studentList")
	public void studentList(HttpServletRequest request,HttpServletResponse response) {
		try {
			page = Integer.parseInt(request.getParameter("page"));
			rows = Integer.parseInt(request.getParameter("limit"));
			student = new Student();
			if(request.getParameter("clazzid")!=null && request.getParameter("clazzid").length() > 0){
				student.setClazzid(Integer.parseInt(request.getParameter("clazzid")));
			}
			student.setName(request.getParameter("name"));
			student.setNo(request.getParameter("no"));
			student.setPage((page-1)*rows);
			student.setRows(rows);
			List<Student> list = studentService.findStudent(student);
			int total = studentService.countStudent(student);
			
			JSONObject jsonObj = new JSONObject();//new一个JSON
			jsonObj.put("code", 0);
			jsonObj.put("msg", "");
			jsonObj.put("count",total );//total代表一共有多少数据
			jsonObj.put("data", list);//row是代表显示的页的数据
	        WriterUtil.write(response,jsonObj.toString()); //将上述Json输出，前台ajax接收
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("findOneStudent")
	public void findOneStudent(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		student = new Student();
		String no=request.getParameter("no");
		try {
			student=studentService.findOneStudentByno(no);
			result.put("studentInfo", student);
		} catch (Exception e) {
			e.printStackTrace();
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	@RequestMapping("reserveStudent")
	public void reserveStudent(HttpServletRequest request,HttpServletResponse response,Student student) {
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		try {
			if(StringUtil.isNotEmpty(id)){
				student.setId(Integer.parseInt(id));
				studentService.updateStudent(student);
				result.put("returnCode", 200);
			} else {
				studentService.addStudent(student);
				// 添加学生的时候同时添加默认的100信用分数
				score = new Score();
				score.setStudentname(student.getName());
				score.setStudentno(student.getNo());
				score.setTotal(100);
				scoreService.addScore(score);
				
				// 同时自动注册user表
				user = new User();
				user.setRoleId(3);             //角色为3表示学生
				user.setPassword("123456");    //密码
				user.setUserName(student.getNo()); //用户名
				user.setHeadPortrait("/LibrarySeatSystem/upload/headPortrait/student_default.jpg");
				userService.addUser(user);
				
				//返回状态码
				result.put("returnCode", 300);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起！保存失败");
		}
		WriterUtil.write(response,result.toString());
	}
	
	
	
	
	@RequestMapping("deleteStudent")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String[] ids=request.getParameter("ids").split(",");
			String[] nos = request.getParameter("nos").split(",");
			for (int i=0;i<ids.length;i++) {
				studentService.deleteStudent(Integer.parseInt(ids[i]));
				scoreService.deleteOneScore(nos[i]);
			}
			result.put("returnCode", 200);
			result.put("delNums", ids.length);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，删除失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	
	@RequestMapping("uploadPhoto")
	public void uploadPhoto(HttpServletRequest request,HttpServletResponse response,@RequestParam MultipartFile photo){
		String now = System.currentTimeMillis()+"";
		if (!photo.isEmpty()) {
			String filePath = request.getSession().getServletContext().getRealPath("/")+ "upload/student/" + now + ".jpg";
			try {
				photo.transferTo(new File(filePath));
				student.setPhoto("upload/student/" + now + ".jpg");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		WriterUtil.write(response, "upload/student/" + now + ".jpg");
	}
	
	
}
