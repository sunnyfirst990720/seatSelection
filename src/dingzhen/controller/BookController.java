package dingzhen.controller;

// 书籍管理控制器
import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dingzhen.entity.Book;
import dingzhen.entity.User;
import dingzhen.service.BookService;
import dingzhen.util.StringUtil;
import dingzhen.util.WriterUtil;

@Controller
@RequestMapping("book")
public class BookController {

	private int page;
	private int rows;
	@Autowired
	private BookService<Book> bookService;
	private Book book;
	
	
	@RequestMapping("bookIndex")
	public String index(HttpServletRequest request){
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		if(currentUser.getRoleId()==1){
			return "tuijian/bookIndexForAdmin";
		} else {
			return "tuijian/bookIndex";
		}
	}
	
	
	@RequestMapping("bookList")
	public void bookList(HttpServletRequest request,HttpServletResponse response) {
		try {
			page = Integer.parseInt(request.getParameter("page"));
			rows = Integer.parseInt(request.getParameter("limit"));
			book = new Book();
			book.setPage((page-1)*rows);
			book.setRows(rows);
			if(request.getParameter("status")!=null && request.getParameter("status").length() > 0){
				book.setStatus(Integer.parseInt(request.getParameter("status")));
			}
			book.setName(request.getParameter("name"));
			book.setAuthor(request.getParameter("author"));
			List<Book> list = bookService.findBook(book);
			int total = bookService.countBook(book);
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
	
	
	
	@RequestMapping("reserveBook")
	public void reserveBook(HttpServletRequest request,HttpServletResponse response,Book book) {
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		try {
			if(StringUtil.isNotEmpty(id)){
				book.setId(Integer.parseInt(id));
				bookService.updateBook(book);
				result.put("returnCode", 200);
			} else {
				bookService.addBook(book);
				result.put("returnCode", 300);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起！修改失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	
	
	@RequestMapping("deleteBook")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		try {
			String[] ids=request.getParameter("ids").split(",");
			for (int i=0;i<ids.length;i++) {
				bookService.deleteBook(Integer.parseInt(ids[i]));
			}
			result.put("returnCode", 200);
			result.put("delNums", ids.length);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("returnCode", "对不起，删除失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	
	@RequestMapping("uploadCover")
	public void uploadPhoto(HttpServletRequest request,HttpServletResponse response,@RequestParam MultipartFile file){
		JSONObject jsonObj = new JSONObject();//new一个JSON
		String now = System.currentTimeMillis()+"";
		if (!file.isEmpty()) {
			//String filePath = request.getSession().getServletContext().getRealPath("/")+ "upload/book/" + now + ".jpg";
			String filePath = "D:\\Tomcat 7.0\\webapps\\temp\\" + now + ".jpg";
			try {
				file.transferTo(new File(filePath));
				
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
