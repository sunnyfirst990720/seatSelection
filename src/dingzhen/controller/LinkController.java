package dingzhen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("link")
public class LinkController {
	
	@RequestMapping("index")
	public String index(){
		return "client/index";
	}
	@RequestMapping("contact")
	public String contact(){
		return "client/contact";
	}
	@RequestMapping("openTime")
	public String openTime(){
		return "client/openTime";
	}
	@RequestMapping("icons")
	public String icons(){
		return "client/icons";
	}
	@RequestMapping("codes")
	public String codes(){
		return "client/codes";
	}
	@RequestMapping("portfolio")
	public String portfolio(){
		return "client/portfolio";
	}
	@RequestMapping("seatsRule")
	public String seatsRule(){
		return "client/seatsRule";
	}
	@RequestMapping("recommend")
	public String recommend(){
		return "client/recommend";
	}
	@RequestMapping("myInfo")
	public String myInfo(){
		return "client/myInfo";
	}
	@RequestMapping("myRecommend")
	public String myRecommend(){
		return "client/myRecommend";
	}
	@RequestMapping("selectSeat")
	public String selectSeat(){
		return "client/selectSeat";
	}
	@RequestMapping("mySeat")
	public String mySeat(){
		return "client/mySeat";
	}
}
