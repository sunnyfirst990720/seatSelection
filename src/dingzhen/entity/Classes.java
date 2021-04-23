package dingzhen.entity;

public class Classes extends BaseEntity{

	private Integer id;
	private Integer instituteId;//学院id
	private String  instituteName;//学院名称
	private Integer specialtyId; //专业id
	private String  specialtyName; //专业名称
	private String  teacherno;   // 教师工号
	private String  teachername; // 教师姓名 
	private String  grade; //年级
	private String count; //班级人数
	private String  name;        // 班级名称
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInstituteId() {
		return instituteId;
	}
	public void setInstituteId(Integer instituteId) {
		this.instituteId = instituteId;
	}
	public Integer getSpecialtyId() {
		return specialtyId;
	}
	public void setSpecialtyId(Integer specialtyId) {
		this.specialtyId = specialtyId;
	}
	public String getInstituteName() {
		return instituteName;
	}
	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}
	public String getSpecialtyName() {
		return specialtyName;
	}
	public void setSpecialtyName(String specialtyName) {
		this.specialtyName = specialtyName;
	}
	public String getTeacherno() {
		return teacherno;
	}
	public void setTeacherno(String teacherno) {
		this.teacherno = teacherno;
	}
	public String getTeachername() {
		return teachername;
	}
	public void setTeachername(String teachername) {
		this.teachername = teachername;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
