package dingzhen.controller;

// 座位管理
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sun.org.apache.bcel.internal.generic.NEW;

import dingzhen.entity.Choice;
import dingzhen.entity.ComboValue;
import dingzhen.entity.Room;
import dingzhen.entity.Score;
import dingzhen.entity.Seat;
import dingzhen.entity.User;
import dingzhen.service.ChoiceService;
import dingzhen.service.RoomService;
import dingzhen.service.ScoreService;
import dingzhen.service.SeatService;
import dingzhen.util.WriterUtil;
@Controller
@RequestMapping("seat")
public class SeatController {

	private int page;
	private int rows;
	@Autowired
	private SeatService<Seat> seatService;
	private Seat seat;
	private Room room;
	@Autowired
	private RoomService<Room> roomService;
	@Autowired
	private ChoiceService<Choice> choiceService;
	private Choice choice;
	@Autowired
	private ScoreService<Score> scoreService;
	private Score score;
	
	@RequestMapping("seatIndex")
	public String index(){
		return "seat/selectSeat";
	}
	
	//获取座位
	@RequestMapping("combolist")
	public void seatList(HttpServletRequest request,HttpServletResponse response) {
		try {
			room = new Room();
			seat = new Seat();
			String date = request.getParameter("date");
			if(date==null || date.length()==0){
				seat.setDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			}else {
				seat.setDate(date);
			}
			if(request.getParameter("roomid")!=null && request.getParameter("roomid").length() > 0){
				seat.setRoomid(Integer.parseInt(request.getParameter("roomid")));
				room.setId(Integer.parseInt(request.getParameter("roomid")));
			} else {
				seat.setRoomid(1);
				room.setId(1);
			}
			String time = request.getParameter("time");
			if(time == null || time.length()==0){
				seat.setTime("08点-12点");
			}else {
				seat.setTime(time);
			}
			List<Seat> list = seatService.findSeat(seat);
			List<Room> roomlist = roomService.findRoom(room);
			room = roomlist.get(0);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("seatList", list);
			jsonObject.put("row", room.getRow());
			jsonObject.put("col", room.getCol());
			WriterUtil.write(response, jsonObject.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 今天和明天
	@RequestMapping("dateCombo")
	public void dateCombo(HttpServletRequest request,HttpServletResponse response){
		try {
			// 获取今明两天时间的String值。格式是yyyy-MM-dd
			Date todayDate = new Date();
			Date tomorrowDate = getNextDay(todayDate);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(todayDate);
			String tomorrow = sdf.format(tomorrowDate);
			
			List<ComboValue> list = new ArrayList<ComboValue>();
			ComboValue cv = new ComboValue(today, "今天  "+today);
			list.add(cv);
			ComboValue cv2 = new ComboValue(tomorrow, "明天  "+tomorrow);
			list.add(cv2);
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 获取明天日期
	public static Date getNextDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		date = calendar.getTime();
		return date;
	}
	
	
	
	
	// 3个时间段
	@RequestMapping("timeCombo")
	public void timeCombo(HttpServletRequest request,HttpServletResponse response) {
		try {
			List<ComboValue> list = new ArrayList<ComboValue>();
			ComboValue cv =  new ComboValue("08点-12点","08点-12点");
			list.add(cv);
			ComboValue cv2 = new ComboValue("14点-18点","14点-18点");
			list.add(cv2);
			ComboValue cv3 = new ComboValue("18点-22点","18点-22点");
			list.add(cv3);
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 阅览室
	@RequestMapping("roomCombo")
	public void roomCombo(HttpServletRequest request,HttpServletResponse response){
		try {
			List<Room> list = roomService.findRoom(new Room());
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	//查找自己的座位
	@RequestMapping("myselfSeat")
	public void myselfSeat(HttpServletRequest request,HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		try {
			String date = request.getParameter("date");
			if(date==null || date.length()==0){
				date = (new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			}
			String roomid = request.getParameter("roomid");
			if(roomid==null || roomid.length()==0){
				roomid = "1";
			} 
			String time = request.getParameter("time");
			if(time == null || time.length()==0){
				time = "08点-12点";
			}
			Choice c = new Choice();
			c.setSeatkeyword(date + "-" +time + "-" +roomid);
			c.setStudentno(currentUser.getUserName());
			choice = choiceService.findOneChoice(c);
			if(choice == null){
				WriterUtil.write(response, "no");
			} else {
				WriterUtil.write(response, choice.getSeatkeyword());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	
	//查找我的座位
	@RequestMapping("mySeat")
	public void mySeat(HttpServletRequest request,HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		page = Integer.parseInt(request.getParameter("page"));
		rows = Integer.parseInt(request.getParameter("limit"));
		seat = new Seat();
		seat.setPage((page-1)*rows);
		seat.setRows(rows);
		JSONObject jsonObject = new JSONObject();
		try {
			seat.setStudentno(currentUser.getUserName());
			List<Seat> list = seatService.findSeat(seat);
			jsonObject.put("code", 0);
			jsonObject.put("msg", "");
			//jsonObject.put("count",10 );//total代表一共有多少数据
			jsonObject.put("data", list);//row是代表显示的页的数据
		} catch (Exception e) {
			e.printStackTrace();
		}
		WriterUtil.write(response, jsonObject.toString());
	}	
	
	// 保存选中座位
	@RequestMapping("saveSeat")
	public void saveSeat(HttpServletRequest request,HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		String keyword = request.getParameter("keyword");
		System.out.println("key---"+keyword);
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		if(currentUser.getRoleId() == 1  || currentUser.getRoleId()==2){  //超管和教师不能选座
			jsonObject.put("returnCode","对不起，该阅览室选座只对学生开放");
			WriterUtil.write(response, jsonObject.toString());
			return;
		}
		String studentno = currentUser.getUserName();
		String nowDateHour = new SimpleDateFormat("yyyy-MM-dd-HH").format(new Date());  //当前小时数
		String selectedDate = keyword.substring(0,13);  
		try {
			//判断信用积分
			score = scoreService.findOneScore(studentno);
			int myScore = score.getTotal();     //该学生分数
			
			int roomid = Integer.parseInt(keyword.substring(19,20));
			int needScore = roomService.findScoreByRoomid(roomid);
			if(needScore >= myScore){
				jsonObject.put("returnCode", "预约失败！您的信用积分不允许在该阅览室选座");
				WriterUtil.write(response, jsonObject.toString());
				return;
			}
			String flag = "1";
			Choice c = new Choice();
			c.setStudentno(studentno);
			c.setStatus("0");
			List<Choice> list = choiceService.findChoice(c);
			if(list==null || list.size()==0){
				// 无预约 OK的
			} else if(list.size()>3){
				// 限预约3次
				flag = "3";
			}else {
				for(Choice choice : list){
					if(choice.getSeatkeyword().substring(0,17).equals(keyword.substring(0,17))){
						//重复了
						flag = "2";
						break;
					}
				}
				
			}
			if("3".equals(flag)){
				jsonObject.put("returnCode", "预约失败！今天已经预约3次了，退座后可再次预约哦！");
				WriterUtil.write(response, jsonObject.toString());
				return;
			} else if ("2".equals(flag)) {
				jsonObject.put("returnCode", "预约失败！这个时间段已经预约过一个座位了");
				WriterUtil.write(response, jsonObject.toString());
				return;
			} else {
				choice = new Choice();
				choice.setSeatkeyword(keyword);
				choice.setStudentno(studentno);
				choice.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				choiceService.addChoice(choice);
				
				seat = new Seat();
				seat.setKeyword(keyword);
				seat.setStudentno(studentno);
				seat.setStatus(1);
				seatService.occupySeat(seat);
				
				//创建签到线程并启动
				SignTimer signtimer=new SignTimer(seat.getKeyword(),seat.getStudentno());
				Thread signthread=new Thread(signtimer);
				signthread.start();
				
				jsonObject.put("returnCode", 200);
				WriterUtil.write(response, jsonObject.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("returnCode", "对不起！系统错误，选座失败！");
			WriterUtil.write(response, jsonObject.toString());
		}
	}
	
	//改变座位状态
	@RequestMapping("reserveSeat")
	public void reserveSeat(HttpServletRequest request,HttpServletResponse response,Seat seat){
		JSONObject jsonObject = new JSONObject();
		try {
			seatService.occupySeat(seat);
			if(seat.getStatus()==3) { //如果要改变为暂离状态-->设置暂离定时器
				LeaveTimer leavetimer=new LeaveTimer(seat.getKeyword(),seat.getStudentno());
				Thread leavethread=new Thread(leavetimer);
				leavethread.start();
			}
			
			jsonObject.put("returnCode", 200);
			WriterUtil.write(response, jsonObject.toString());
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("returnCode", "对不起！系统错误，操作失败！");
			WriterUtil.write(response, jsonObject.toString());
		}
	}
	
	
	
	//取消选座
	@RequestMapping("cancelSeat")
	public void cancelSeat(HttpServletRequest request,HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		JSONObject jsonObject = new JSONObject();
		try {
			// 删除choice表中的记录
			String keyword = request.getParameter("seatkeyword");
			Choice choice = new Choice();
			choice.setSeatkeyword(keyword.substring(0, 20));
			choice.setStudentno(currentUser.getUserName());
			choiceService.cancelChoice(choice);
			
			// 将seat表中该条记录学号变成1
			seatService.cancelSeat(keyword); //
			
			jsonObject.put("returnCode", 200);
			WriterUtil.write(response, jsonObject.toString());
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put("returnCode", "对不起！系统错误，操作失败！");
			WriterUtil.write(response, jsonObject.toString());
		}
	}
	
	//签到定时器
	public class SignTimer implements Runnable{
		private String Keyword;
		private String Studentno;
		public SignTimer(String keyword,String studentno) {
			this.Keyword=keyword;
			this.Studentno=studentno;
		}
		@Override
		public void run() {
			try {
				Thread.sleep(30*60*1000);//休眠半小时
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			try {
				seat=new Seat();
				seat=seatService.findOneSeat(Keyword);
				if(seat.getStatus()==1) { //如果到时间后仍未签到
					Choice choice = new Choice();
					choice.setSeatkeyword(Keyword.substring(0, 20));
					choice.setStudentno(Studentno);
					choiceService.cancelChoice(choice);//取消选择
					seatService.cancelSeat(Keyword);//取消预约
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	//暂离定时器
	public class LeaveTimer implements Runnable{
		private String Keyword;
		private String Studentno;
		public LeaveTimer(String keyword,String studentno) {
			this.Keyword=keyword;
			this.Studentno=studentno;
		}
		@Override
		public void run() {
			try {
				Thread.sleep(90*60*1000);//休眠90分钟
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			try {
				seat=new Seat();
				seat=seatService.findOneSeat(Keyword);
				if(seat.getStatus()==3) { //如果到时间后仍为暂离状态
					Choice choice = new Choice();
					choice.setSeatkeyword(Keyword.substring(0, 20));
					choice.setStudentno(Studentno);
					choiceService.cancelChoice(choice);//取消选择
					seatService.cancelSeat(Keyword);//暂离失效，退座
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
}
