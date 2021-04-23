package dingzhen.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

@Mapper("massageDao")
public interface MassageDao<T> {
	// 查询所有
	public abstract List<T> findMassage(T t) throws Exception;

	// 数量
	public abstract int countMassage(T t) throws Exception;

	// 新增
	public abstract void addMassage(T t) throws Exception;

	// 修改
	public abstract void updateMassage(T t) throws Exception;

	// 删除
	public abstract void deleteMassage(Integer id) throws Exception;
	
}
