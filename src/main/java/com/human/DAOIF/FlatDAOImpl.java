package com.human.DAOIF;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.human.DTO.FileDTO;
import com.human.DTO.FlatsDTO;
import com.human.util.PageNumber;

@Repository
public class FlatDAOImpl implements IF_flatDAO {
	private static String mapperQuery = "com.human.DAOIF.IF_flatDAO";

	@Inject
	private SqlSession sqlSession;

	@Override
	public void saveFile(FileDTO file) {
		sqlSession.insert(mapperQuery + ".saveFile", file);
	}

	@Override
	public void insertF(FlatsDTO f) {
		sqlSession.insert(mapperQuery + ".insertF", f);
	}

	@Override
	public List<Map<String, String>> selectAll() {
		return sqlSession.selectList(mapperQuery + ".selectAll");
	}

	@Override
	public List<FlatsDTO> selectCluster(List<Integer> flatIDArr) {
		return sqlSession.selectList(mapperQuery + ".selectCluster", flatIDArr);
	}

	@Override
	public List<FlatsDTO> selectInBounds(JSONObject bounds) {
		return sqlSession.selectList(mapperQuery + ".selectInBounds", bounds);
	}

	@Override
	public List<FlatsDTO> selectWExtra(JSONObject jObj) {
		return sqlSession.selectList(mapperQuery + ".selectWExtra", jObj);
	}

	@Override
	public FlatsDTO selectOne(int fNum) {
		return sqlSession.selectOne(mapperQuery + ".selectOne", fNum);
	}

	@Override
	public List<FileDTO> selectFiles(int fNum) {
		return sqlSession.selectList(mapperQuery + ".selectFiles", fNum);
	}

	@Override
	public List<FlatsDTO> selectOtherFlats(String where) {
		return sqlSession.selectList(mapperQuery + ".selectOtherFlats", where);
	}

	@Override
	public List<FlatsDTO> getMyFList(String logID) {
		return sqlSession.selectList(mapperQuery + ".getMyFList", logID);
	}

	@Override
	public int delOnePhoto(int pNum) {
		return sqlSession.delete(mapperQuery + ".delOnePhoto", pNum);
	}

	@Override
	public int delAllPhoto(int fNum) {
		return sqlSession.delete(mapperQuery + ".delAllPhoto", fNum);
	}

	@Override
	public void updateOneF(FlatsDTO f) {
		sqlSession.update(mapperQuery + ".updateOneF", f);
	}

	@Override
	public int doneUpdate(JSONObject dobj) {
		return sqlSession.update(mapperQuery + ".doneUpdate", dobj);
	}

	@Override
	public int delOneFlat(int fNum) {
		return sqlSession.delete(mapperQuery + ".delOneFlat", fNum);
	}

	@Override
	public FileDTO selectOneFile(int pNum) {
		return sqlSession.selectOne(mapperQuery + ".selectOneFile", pNum);
	}

	@Override
	public String selectOnlyFile(int fNum) {
		return sqlSession.selectOne(mapperQuery + ".selectOnlyFile", fNum);
	}

	@Override
	public int dipsInsert(JSONObject dobj) {
		return sqlSession.insert(mapperQuery + ".dipsInsert", dobj);
	}

	@Override
	public int dipsDelete(JSONObject dobj) {
		return sqlSession.delete(mapperQuery + ".dipsDelete", dobj);
	}

	@Override
	public int selectOneDip(FlatsDTO fdto) {
		return sqlSession.selectOne(mapperQuery + ".selectOneDip", fdto);
	}

	@Override
	public int totalDips(int fNum) {
		return sqlSession.selectOne(mapperQuery + ".totalDips", fNum);
	}

	@Override
	public int dipsPCount(String logID) {
		return sqlSession.selectOne(mapperQuery + ".dipsPCount", logID);
	}

	@Override
	public List<FlatsDTO> getDipsList(PageNumber pn) {
		return sqlSession.selectList(mapperQuery + ".getDipsList", pn);
	}

	@Override
	public List<FlatsDTO> flatsNearMe(FlatsDTO f) {
		return sqlSession.selectList(mapperQuery + ".flatsNearMe", f);
	}
}
