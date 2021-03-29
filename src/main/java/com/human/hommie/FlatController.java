package com.human.hommie;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.human.DTO.FileDTO;
import com.human.DTO.FlatsDTO;
import com.human.DTO.MemberDTO;
import com.human.service.IF_flatService;
import com.human.service.IF_memberService;
import com.human.util.FileDataUtil;
import com.human.util.PageNumber;

@Controller
public class FlatController {
	@Inject
	private FileDataUtil filedatautil;
	@Inject
	private IF_flatService fservice;
	@Inject
	private IF_memberService mservice;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) throws Exception {

		return "redirect:home";
	}

	// 홈
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model m, HttpServletRequest h) throws Exception {
		// 세션에서 아이디 갖고오기
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		m.addAttribute("logID", logID);
		return "home";
	}

	// 방 내놓기 화면으로 이동
	@RequestMapping(value = "/uploadFlat", method = RequestMethod.GET)
	public String uploadFlat(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");
		m.addAttribute("logID", logID);

		return "flats/uploadFlat";
	}

	// 방 내놓기 제출
	@RequestMapping(value = "/submit_uploadF", method = RequestMethod.POST)
	public String submitUploadF(FlatsDTO f, MultipartHttpServletRequest mts) throws Exception {
		fservice.insertF(f); // 여기서 useGeneratedKey 사용해 DB 삽입 동시에 f객체의 ID 설정

		List<MultipartFile> files = mts.getFiles("file");
		if (files.size() > 0 && files.get(0).getOriginalFilename().equals("")) {
			System.out.println("첨부파일이 없네요...");
		} else {
			for (int i = 0; i < files.size(); i++) {
				String[] fs = filedatautil.fileUpload(files.get(i));
				FileDTO file = new FileDTO();
				file.setFlatID(f.getFlatID());
				file.setFileName(fs[0]);
				fservice.saveFile(file);
			}
		}
		return "redirect:myFlats";
	}

	// 내 방 관리 화면으로 이동
	@RequestMapping(value = "/myFlats", method = RequestMethod.GET)
	public String myFlats(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");
		m.addAttribute("logID", logID);
		if (logID != null) {
			m.addAttribute("myFList", fservice.getmyFList(logID));
		}
		return "flats/myFlats";
	}

	// 방 상세보기
	@RequestMapping(value = "/viewF", method = RequestMethod.GET)
	public String viewF(Model m, HttpServletRequest h, @RequestParam("flatID") int fNum) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");
		FlatsDTO fdto = fservice.selectOne(fNum);
		String[] location = fdto.getRoadAdrs().split(" ");
		String where = location[0] + " " + location[1];

		m.addAttribute("logID", logID);
		m.addAttribute("fdto", fdto);
		m.addAttribute("pList", fservice.selectFiles(fNum));
		m.addAttribute("where", where);
		m.addAttribute("otherList", fservice.selectOtherFlats(where));
		// 해당 사용자가 찜했는지 확인하기 위해 ID를 매물 DTO객체에 넣어줌
		if (logID != null) {
			FlatsDTO f = new FlatsDTO();
			f.setFlatID(fNum);
			f.setMemberID(logID);
			m.addAttribute("myDip", fservice.selectOneDip(f));
		}
		m.addAttribute("totalDips", fservice.totalDips(fNum));
		return "flats/viewF";
	}

	// 마커 클릭이벤트
	// 클릭 마커 정보 가져오고 최근 본 방 목록에 넣기
	@ResponseBody
	@RequestMapping(value = "/markerInfo", method = RequestMethod.POST)
	public FlatsDTO markerInfo(@RequestBody int fNum) throws Exception {
		FlatsDTO f = fservice.selectOne(fNum);
		f.setFileName(fservice.selectOnlyFile(fNum));
		return f;
	}

	// 방 수정하기 화면
	@RequestMapping(value = "/modifyF", method = RequestMethod.GET)
	public String modifyF(Model m, HttpServletRequest h, @RequestParam("flatID") int fNum) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		m.addAttribute("logID", logID);
		m.addAttribute("fdto", fservice.selectOne(fNum));
		return "flats/modifyF";
	}

	// 방수정하기 사진 가져오기 비동기
	@ResponseBody
	@RequestMapping(value = "/myfphotos", method = RequestMethod.POST)
	public List<FileDTO> myfphotos(@RequestBody int fNum) {
		List<FileDTO> fList = fservice.selectFiles(fNum);
		return fList;
	}

	// 방수정하기 사진 삭제 버튼 비동기
	@ResponseBody
	@RequestMapping(value = "/delPhoto", method = RequestMethod.POST)
	public void delPhoto(@RequestBody int pNum) {
		// 기존 파일 삭제
		FileDTO fifi = fservice.selectOneFile(pNum);
		File target = new File(filedatautil.getUploadPath(), fifi.getFileName());
		if (target.exists()) {
			target.delete();
		}
		fservice.delOnePhoto(pNum);
	}

	// 방 수정하기 사진 전체 삭제
	@ResponseBody
	@RequestMapping(value = "/delAllPhoto", method = RequestMethod.POST)
	public int delAllPhoto(@RequestBody int fNum) {
		int suc = 0;
		// 기존 파일들 삭제
		List<FileDTO> f = fservice.selectFiles(fNum);
		for (int i = 0; i < f.size(); i++) {
			File target = new File(filedatautil.getUploadPath(), f.get(i).getFileName());
			if (target.exists()) {
				target.delete();
				fservice.delOnePhoto(f.get(i).getFileID());
			}
		}
		return suc;
	}

	// 방 수정하기 제출
	@RequestMapping(value = "/modifyF_submit", method = RequestMethod.POST)
	public String modifyFSubmit(FlatsDTO f, MultipartHttpServletRequest mts, Model m, HttpServletRequest h)
			throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		List<MultipartFile> files = mts.getFiles("file");
		System.out.println(f.getFlatID());
		if (files.size() > 0 && files.get(0).getOriginalFilename().equals("")) {
			System.out.println("첨부파일이 없서...");
		} else {
			for (int i = 0; i < files.size(); i++) {
				String[] fs = filedatautil.fileUpload(files.get(i));
				FileDTO file = new FileDTO();
				file.setFlatID(f.getFlatID());
				file.setFileName(fs[0]);
				fservice.saveFile(file);
			}
		}
		fservice.updateOneF(f);
		FlatsDTO fdto = fservice.selectOne(f.getFlatID());
		String[] location = fdto.getRoadAdrs().split(" ");
		String where = location[0] + " " + location[1];

		m.addAttribute("logID", logID);
		m.addAttribute("fdto", fdto);
		m.addAttribute("pList", fservice.selectFiles(f.getFlatID()));
		m.addAttribute("where", where);
		m.addAttribute("otherList", fservice.selectOtherFlats(where));
		return "flats/viewF";
	}

	// 방찾기
	@RequestMapping(value = "/findF", method = RequestMethod.GET)
	public String findF(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		if (h.getParameter("schWord") != null) {
			m.addAttribute("schWord", h.getParameter("schWord"));
		}
		m.addAttribute("logID", logID);
		return "flats/findF";
	}

	// 지도 마크 클러스터러 정보 전송
	@ResponseBody
	@RequestMapping(value = "/clusterer", method = RequestMethod.POST)
	public List<Map<String, String>> clusterer() {

		List<Map<String, String>> positions = new ArrayList<>();
		positions = fservice.selectAll();

		// 테스트 출력 - 모든 클러스터러 내 마커의 위치 정보
//		System.out.println(positions);

		return positions;

	}

	// 지도 클러스터러 내부 마커 배열 전송
	@ResponseBody
	@RequestMapping(value = "/clusterInside", method = RequestMethod.POST)
	public List<FlatsDTO> clusterInside(@RequestBody List<Integer> flatIDArr) {
		List<FlatsDTO> fList = fservice.selectCluster(flatIDArr);

		// 테스트 출력 - 선택된 클러스터 내 첫번째 마커의 방 종류
//		System.out.println(fList.get(0).getRoom());

		return fList;
	}

	// 추가 선택 옵션 달라졌을 때
	@ResponseBody
	@RequestMapping(value = "/addExtra", method = RequestMethod.POST)
	public List<FlatsDTO> addExtra(@RequestBody JSONObject jObj) {
		List<FlatsDTO> fList = fservice.selectWExtra(jObj);
		return fList;
	}

	// 거래완료 선택 비동기
	@ResponseBody
	@RequestMapping(value = "/doneUpdate", method = RequestMethod.POST)
	public int doneUpdate(@RequestBody JSONObject dobj) {
		int suc = fservice.doneUpdate(dobj);
		return suc;
	}

	// 매물 삭제하기 비동기
	@ResponseBody
	@RequestMapping(value = "/delOneFlat", method = RequestMethod.POST)
	public int delOneFlat(@RequestBody int fNum) {
		// 기존 파일들 삭제
		List<FileDTO> f = fservice.selectFiles(fNum);
		for (int i = 0; i < f.size(); i++) {
			File target = new File(filedatautil.getUploadPath(), f.get(i).getFileName());
			if (target.exists()) {
				target.delete();
				fservice.delOnePhoto(f.get(i).getFileID());
			}
		}
		int suc = fservice.delOneFlat(fNum);
		return suc;
	}

	// 찜한 목록
	@RequestMapping(value = "/dipsF", method = RequestMethod.GET)
	public String dipsF(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");

		int nowP = 1;
		if (h.getParameter("page") != null) {
			nowP = Integer.valueOf(h.getParameter("page"));
		}
		int pageTotal = fservice.dipsPCount(logID);
		PageNumber pn = new PageNumber();

		pn.setPage(nowP);
		pn.setCount(pageTotal);
		pn.setMemberID(logID);

		m.addAttribute("pageMaker", pn);
		m.addAttribute("dipsList", fservice.getDipsList(pn));
		m.addAttribute("logID", logID);
		return "flats/dipsF";
	}

	// 찜하기 비동기
	@ResponseBody
	@RequestMapping(value = "/dipsChange", method = RequestMethod.POST)
	public int dipsChange(@RequestBody JSONObject dobj) {
		String dips = (String) dobj.get("dips");
		if (dips.equals("Y")) {
			fservice.dipsInsert(dobj);
		} else if (dips.equals("N")) {
			fservice.dipsDelete(dobj);
		}
		String fNumS = (String) dobj.get("fNum");
		int fNum = Integer.parseInt(fNumS);
		int totalDips = fservice.totalDips(fNum);
		return totalDips;
	}

	// 사용자 주변 방 찾기
	@ResponseBody
	@RequestMapping(value = "/flatsNearMe", method = RequestMethod.POST)
	public List<FlatsDTO> flatsNearMe(@RequestBody String whereMe) {
		String[] wm = whereMe.split(" ");
		// 도시이름에서 ~시 빼기
		int leng = wm[1].length();
		if (wm[1].endsWith("시")) {
			wm[1] = wm[1].replace("" + wm[1].charAt(leng - 1), "");
		}

		FlatsDTO f = new FlatsDTO();
		// 검색을 위해 임시로 시는 FlatsDTO 도로명주소에, 구는 지번주소에 넣음
		f.setRoadAdrs(wm[1]);
		f.setJibunAdrs(wm[2]);
		List<FlatsDTO> fList = fservice.flatsNearMe(f);
		return fList;
	}

	// 최근 본 목록 모두보기
	@RequestMapping(value = "/recentViews", method = RequestMethod.GET)
	public String recentViews(Model m, HttpServletRequest h) throws Exception {
		HttpSession session = h.getSession();
		String logID = (String) session.getAttribute("logID");
		m.addAttribute("logID", logID);
		return "flats/recentViews";
	}

	// 방 주인에게 연락하기
	@ResponseBody
	@RequestMapping(value = "/getContacts", method = RequestMethod.POST)
	public MemberDTO getContacts(@RequestBody String sellID) {

		MemberDTO m = mservice.getContacts(sellID);

		return m;
	}
}
