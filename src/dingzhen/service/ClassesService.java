package dingzhen.service;

import java.util.List;

public interface ClassesService<T> {

	// 查询所有
	public abstract List<T> findClasses(T t) throws Exception;

	// 数量
	public abstract int countClasses(T t) throws Exception;

	// 新增
	public abstract void addClasses(T t) throws Exception;

	// 修改
	public abstract void updateClasses(T t) throws Exception;

	// 删除
	public abstract void deleteClasses(Integer id) throws Exception;
	
	//查询学院
	public abstract List<T> findInstitute() throws Exception;
	
	//查询专业
	public abstract List<T> findSpecialty(Integer id) throws Exception;
	
}
