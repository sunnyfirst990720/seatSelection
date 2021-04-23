package dingzhen.controller;

import java.io.Writer;
// 班级管理控制器
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dingzhen.entity.Classes;
import dingzhen.service.ClassesService;
import dingzhen.util.StringUtil;
import dingzhen.util.WriterUtil;

@Controller
@RequestMapping("classes")
public class ClassesController {

	private int page;
	private int rows;
	@Autowired
	private ClassesService<Classes> classesService;
	private Classes classes;
	
	@RequestMapping("classesIndex")
	public String index(){
		return "info/classes";
	}
	
	
	
	@RequestMapping("classesList")
	public void list(HttpServletRequest request ,HttpServletResponse response) {
		try {
			page = Integer.parseInt(request.getParameter("page"));
			rows = Integer.parseInt(request.getParameter("limit"));
			
			classes = new Classes();
			classes.setPage((page-1)*rows);
			classes.setRows(rows);
			
			String instituteId = request.getParameter("instituteId");
			if (StringUtil.isNotEmpty(instituteId)) {
				classes.setInstituteId(Integer.parseInt(instituteId));
			} else {
				classes.setInstituteId(null);
			}
			
			String specialtyId = request.getParameter("specialtyId");
			if (StringUtil.isNotEmpty(specialtyId)) {
				classes.setSpecialtyId(Integer.parseInt(specialtyId));
			} else {
				classes.setSpecialtyId(null);
			}
			
			List<Classes> list = classesService.findClasses(classes);
			int total = classesService.countClasses(classes);
			
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
	
	@RequestMapping("classesSelect")
	public void classesSelect(HttpServletRequest request ,HttpServletResponse response) {
		try {
			classes = new Classes();
			String instituteId = request.getParameter("instituteId");
			if (StringUtil.isNotEmpty(instituteId)) {
				classes.setInstituteId(Integer.parseInt(instituteId));
			} else {
				classes.setInstituteId(null);
			}
			
			String specialtyId = request.getParameter("specialtyId");
			if (StringUtil.isNotEmpty(specialtyId)) {
				classes.setSpecialtyId(Integer.parseInt(specialtyId));
			} else {
				classes.setSpecialtyId(null);
			}
			
			List<Classes> classlist = classesService.findClasses(classes);
			
			JSONObject jsonObj = new JSONObject();//new一个JSON
			jsonObj.put("classlist", classlist);//row是代表显示的页的数据
	        WriterUtil.write(response,jsonObj.toString()); //将上述Json输出，前台ajax接收
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("reserveClasses")
	public void reserveClasses(HttpServletRequest request,HttpServletResponse response,Classes classes) {
		JSONObject result = new JSONObject();
		try {
			classesService.addClasses(classes);
			result.put("returnCode", 200);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起！保存失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	
	
	@RequestMapping("deleteClasses")
	public void deleteClasses(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String[] ids=request.getParameter("ids").split(",");
			Classes classes=new Classes();
			for (String id : ids) {
				classesService.deleteClasses(Integer.parseInt(id));
			}
			result.put("returnCode", 200);
			result.put("delNums", ids.length);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，删除失败");
		}
		WriterUtil.write(response, result.toString());
	}
	

	@RequestMapping("comboList")
	public void comboList(HttpServletRequest request,HttpServletResponse response){
		try {
			List<Classes> list = classesService.findClasses(new Classes());
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("instituteList")
	public void instituteList(HttpServletRequest request,HttpServletResponse response) {
		JSONObject result=new JSONObject();
		try {
			List<Classes> institutelist = classesService.findInstitute();
			result.put("institutelist", institutelist);
			WriterUtil.write(response, result.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("specialtyList")
	public void specialtyList(HttpServletRequest request,HttpServletResponse response) {
		JSONObject result=new JSONObject();
		int instituteId=Integer.parseInt(request.getParameter("instituteId"));
		try {
			List<Classes> specialtylist = classesService.findSpecialty(instituteId);
			result.put("specialtylist", specialtylist);
			WriterUtil.write(response, result.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
