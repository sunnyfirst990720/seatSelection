package dingzhen.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.dao.ClassesDao;
import dingzhen.service.ClassesService;

@Service("classesService")
public class ClassesServiceImpl<T> implements ClassesService<T>{
	
	@Autowired
	private ClassesDao<T> dao;

	public List<T> findClasses(T t) throws Exception {
		return dao.findClasses(t);
	}

	public int countClasses(T t) throws Exception {
		return dao.countClasses(t);
	}

	public void addClasses(T t) throws Exception {
		dao.addClasses(t);
	}

	public void updateClasses(T t) throws Exception {
		dao.updateClasses(t);
	}

	public void deleteClasses(Integer id) throws Exception {
		dao.deleteClasses(id);
	}
	
	public List<T> findInstitute() throws Exception {
		return dao.findInstitute();
	}
	
	public List<T> findSpecialty(Integer id) throws Exception {
		return dao.findSpecialty(id);
	}
}
