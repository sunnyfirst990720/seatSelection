package dingzhen.entity;

public class ComboValue {

	private String zhi;  //value值 隐藏的值
	private String biaoqian;  //标签 显示的
	public String getZhi() {
		return zhi;
	}
	public void setZhi(String zhi) {
		this.zhi = zhi;
	}
	
	public String getBiaoqian() {
		return biaoqian;
	}
	public void setBiaoqian(String biaoqian) {
		this.biaoqian = biaoqian;
	}
	public ComboValue() {
		super();
	}
	public ComboValue(String zhi, String biaoqian) {
		super();
		this.zhi = zhi;
		this.biaoqian = biaoqian;
	}
	
}
