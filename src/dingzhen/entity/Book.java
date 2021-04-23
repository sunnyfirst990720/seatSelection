package dingzhen.entity;

// 书籍管理

public class Book extends BaseEntity{

	private Integer id;
	private String name;  //书名
	private String author; //作者
	private String publish; //出版社
	private String cover;   //封面。地址
	private String remarks;  //简介
	private String findnumber; //索书号
	private Integer lentime;//推荐次数
	private Integer status;//审核状态
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublish() {
		return publish;
	}
	public void setPublish(String publish) {
		this.publish = publish;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getFindnumber() {
		return findnumber;
	}
	public void setFindnumber(String findnumber) {
		this.findnumber = findnumber;
	}
	public Integer getLentime() {
		return lentime;
	}
	public void setLentime(Integer lentime) {
		this.lentime = lentime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
}
