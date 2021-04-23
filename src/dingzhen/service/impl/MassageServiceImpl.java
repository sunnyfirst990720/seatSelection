package dingzhen.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.dao.MassageDao;
import dingzhen.service.MassageService;

@Service("massageService")
public class MassageServiceImpl<T> implements MassageService<T>{

	@Autowired
	private MassageDao<T> dao;
	
	public List<T> findMassage(T t) throws Exception {
		return dao.findMassage(t);
	}

	public int countMassage(T t) throws Exception {
		return dao.countMassage(t);
	}

	public void addMassage(T t) throws Exception {
		dao.addMassage(t);
	}

	public void updateMassage(T t) throws Exception {
		dao.updateMassage(t);
	}

	public void deleteMassage(Integer id) throws Exception {
		dao.deleteMassage(id);
	}

}
