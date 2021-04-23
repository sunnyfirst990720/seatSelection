package dingzhen.controller;

// 通知信息
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import dingzhen.entity.Massage;
import dingzhen.service.MassageService;
import dingzhen.util.StringUtil;
import dingzhen.util.WriterUtil;

@Controller
@RequestMapping("massage")
public class MassageController {

	private int page;
	private int rows;
	private Massage massage;
	@Autowired
	private MassageService<Massage> massageService;
	
	@RequestMapping("massageIndex")
	public String index(){
		return "notice/massage";
	}
	
	
	@RequestMapping("massageList")
	public void massageList(HttpServletRequest request,HttpServletResponse response) {
		try {
			page = Integer.parseInt(request.getParameter("page"));
			rows = Integer.parseInt(request.getParameter("limit"));
			massage = new Massage();
			massage.setPage((page-1)*rows);
			massage.setRows(rows);
			if(request.getParameter("status")!=null && request.getParameter("status").length() > 0){
				massage.setStatus(Integer.parseInt(request.getParameter("status")));
			}
			massage.setName(request.getParameter("name"));
			massage.setPhone(request.getParameter("phone"));
			List<Massage> list = massageService.findMassage(massage);
			int total = massageService.countMassage(massage);
			
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
	
	
	
	
	@RequestMapping("reserveMassage")
	public void reserveMassage(HttpServletRequest request,HttpServletResponse response,Massage massage) {
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		try {
			if(StringUtil.isNotEmpty(id)){
				massage.setId(Integer.parseInt(id));
				massageService.updateMassage(massage);
				result.put("returnCode", 200);
			} else {
				massageService.addMassage(massage);
				//返回状态码
				result.put("returnCode", 300);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起！保存失败");
		}
		WriterUtil.write(response,result.toString());
	}
	
	@RequestMapping("deleteMassage")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String[] ids=request.getParameter("ids").split(",");
			for (int i=0;i<ids.length;i++) {
				massageService.deleteMassage(Integer.parseInt(ids[i]));
			}
			result.put("returnCode", 200);
			result.put("delNums", ids.length);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，删除失败");
		}
		WriterUtil.write(response, result.toString());
	}
		
}
