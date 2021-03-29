package com.human.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.human.DAOIF.IF_flatDAO;
import com.human.DTO.FileDTO;
import com.human.DTO.FlatsDTO;
import com.human.util.PageNumber;

@Service
public class FlatServiceImpl implements IF_flatService {
	@Inject
	private IF_flatDAO fdao;

	@Override
	public void saveFile(FileDTO file) {
		fdao.saveFile(file);
	}

	@Override
	public void insertF(FlatsDTO f) {
		fdao.insertF(f);
	}

	@Override
	public List<Map<String, String>> selectAll() {
		return fdao.selectAll();
	}

	@Override
	public List<FlatsDTO> selectCluster(List<Integer> flatIDArr) {
		return fdao.selectCluster(flatIDArr);
	}

	@Override
	public List<FlatsDTO> selectInBounds(JSONObject bounds) {
		return fdao.selectInBounds(bounds);
	}

	@Override
	public List<FlatsDTO> selectWExtra(JSONObject jObj) {
		return fdao.selectWExtra(jObj);
	}

	@Override
	public FlatsDTO selectOne(int fNum) {
		return fdao.selectOne(fNum);
	}

	@Override
	public List<FileDTO> selectFiles(int fNum) {
		return fdao.selectFiles(fNum);
	}

	@Override
	public List<FlatsDTO> selectOtherFlats(String where) {
		return fdao.selectOtherFlats(where);
	}

	@Override
	public List<FlatsDTO> getmyFList(String logID) {
		return fdao.getMyFList(logID);
	}

	@Override
	public int delOnePhoto(int pNum) {
		return fdao.delOnePhoto(pNum);
	}

	@Override
	public int delAllPhoto(int fNum) {
		return fdao.delAllPhoto(fNum);
	}

	@Override
	public void updateOneF(FlatsDTO f) {
		fdao.updateOneF(f);
	}

	@Override
	public int doneUpdate(JSONObject dobj) {
		return fdao.doneUpdate(dobj);
	}

	@Override
	public int delOneFlat(int fNum) {
		return fdao.delOneFlat(fNum);
	}

	@Override
	public FileDTO selectOneFile(int pNum) {
		return fdao.selectOneFile(pNum);
	}

	@Override
	public String selectOnlyFile(int fNum) {
		return fdao.selectOnlyFile(fNum);
	}

	@Override
	public int dipsInsert(JSONObject dobj) {
		return fdao.dipsInsert(dobj);
	}

	@Override
	public int dipsDelete(JSONObject dobj) {
		return fdao.dipsDelete(dobj);
	}

	@Override
	public int selectOneDip(FlatsDTO fdto) {
		return fdao.selectOneDip(fdto);
	}

	@Override
	public int totalDips(int fNum) {
		return fdao.totalDips(fNum);
	}

	@Override
	public int dipsPCount(String logID) {
		return fdao.dipsPCount(logID);
	}

	@Override
	public List<FlatsDTO> getDipsList(PageNumber pn) {
		return fdao.getDipsList(pn);
	}

	@Override
	public List<FlatsDTO> flatsNearMe(FlatsDTO f) {
		return fdao.flatsNearMe(f);
	}
}
