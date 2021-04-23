package dingzhen.controller;

// 统计图
import java.awt.Color;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer3D;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.ui.TextAnchor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dingzhen.entity.Choice;
import dingzhen.entity.Illegal;
import dingzhen.entity.Room;
import dingzhen.entity.Seat;
import dingzhen.service.ChoiceService;
import dingzhen.service.IllegalService;
import dingzhen.service.RoomService;
import dingzhen.service.SeatService;
import dingzhen.util.WriterUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("chart")
@Controller
public class ChartController {

	@Autowired
	private IllegalService<Illegal> illegalService;
	private Illegal illegal;
	private Room room;
	@Autowired
	private RoomService<Room> roomService;
	private Seat seat;
	@Autowired
	private SeatService<Seat> seatService;
	@Autowired
	private ChoiceService<Choice> choiceService;
	
	
	// 进入违规统计
	@RequestMapping("illegalChart")
	public String illegalIndex(){
		return "chart/illegal";
	}
	
	// 违规统计表
	@RequestMapping("findIllegalChart")
	public void findIllegalChart(HttpServletRequest request,HttpServletResponse response){
		try {
			JSONArray datarray=new JSONArray();
			for(int i=1;i<13;i++){
				// 每月违规人数
				String start = getCurrentYear();
				String end = getCurrentYear();
				if(i<10){
					start = start + "-0" + i +"-01 00:00:01";
					end = end + "-0" + i + "-31 23:59:59";
				} else {
					start = start + "-" + i +"-01 00:00:01";
					end = end + "-" + i + "-31 23:59:59";
				}
				illegal = new Illegal();
				illegal.setStart(start);
				illegal.setEnd(end);
				int total = illegalService.countIllegal(illegal);
				datarray.add(total);
			}
			JSONObject jsonObj = new JSONObject();
			
			JSONObject title = new JSONObject();
			title.put("text", getCurrentYear()+"全年度违规人数统计");
			title.put("subtext", "违规人数统计");
			
			JSONObject legend = new JSONObject();
			JSONArray array=new JSONArray();
			array.add("违规统计");
			legend.put("data", array);
			
			jsonObj.put("title", title);
			jsonObj.put("legend", legend);
			jsonObj.put("datarray", datarray);
			
			WriterUtil.write(response,jsonObj.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	// 进入占座统计
	@RequestMapping("seatChart")
	public String seatIndex(){
		return "chart/seat";
	}
	
	
	@RequestMapping("findSeatChart")
	public void findSeatChart(HttpServletRequest request,HttpServletResponse response){
		try {
			JSONArray datarray=new JSONArray();
			List<Room> roomList = roomService.findRoom(new Room());
			for(int i=0;i<roomList.size();i++){
				room = roomList.get(i);
				JSONArray array=new JSONArray();
				for(int j=1;j<13;j++){
					String start = getCurrentYear();
					String end = getCurrentYear();
					if(j<10){
						start = start + "-0" + j +"-01 00:00:01";
						end = end + "-0" + j + "-31 23:59:59";
					} else {
						start = start + "-" + j +"-01 00:00:01";
						end = end + "-" + j + "-31 23:59:59";
					}
					Choice c = new Choice();
					c.setStart(start);
					c.setEnd(end);
					c.setRows(room.getId());
					int total = choiceService.count(c);
					array.add(total);
				}
				datarray.add(array);
			}
			JSONObject jsonObj = new JSONObject();
			
			//title
			JSONObject title = new JSONObject();
			title.put("text", getCurrentYear()+"全年度占座人数统计");
			title.put("subtext", "占座人数统计");
			
			//legend
			JSONObject legend = new JSONObject();
			JSONArray array=new JSONArray();
			for(int i=0;i<roomList.size();i++){
				array.add(roomList.get(i).getName());
			}
			legend.put("data", array);
			jsonObj.put("title", title);
			jsonObj.put("legend", legend);
			jsonObj.put("datarray", datarray);
			
			WriterUtil.write(response,jsonObj.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getCurrentYear(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		return sdf.format(new Date());
	}
}
