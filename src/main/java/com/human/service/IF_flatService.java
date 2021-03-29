package com.human.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import com.human.DTO.FileDTO;
import com.human.DTO.FlatsDTO;
import com.human.util.PageNumber;

public interface IF_flatService {

	public void saveFile(FileDTO file);

	public void insertF(FlatsDTO f);

	public List<Map<String, String>> selectAll();

	public List<FlatsDTO> selectCluster(List<Integer> flatIDArr);

	public List<FlatsDTO> selectInBounds(JSONObject bounds);

	public List<FlatsDTO> selectWExtra(JSONObject jObj);

	public FlatsDTO selectOne(int fNum);

	public List<FileDTO> selectFiles(int fNum);

	public List<FlatsDTO> selectOtherFlats(String where);

	public List<FlatsDTO> getmyFList(String logID);

	public int delOnePhoto(int pNum);

	public int delAllPhoto(int fNum);

	public void updateOneF(FlatsDTO f);

	public int doneUpdate(JSONObject dobj);

	public int delOneFlat(int fNum);

	public FileDTO selectOneFile(int pNum);

	public String selectOnlyFile(int fNum);

	public int dipsInsert(JSONObject dobj);

	public int dipsDelete(JSONObject dobj);

	public int selectOneDip(FlatsDTO fdto);

	public int totalDips(int fNum);

	public int dipsPCount(String logID);

	public List<FlatsDTO> getDipsList(PageNumber pn);

	public List<FlatsDTO> flatsNearMe(FlatsDTO f);

}
