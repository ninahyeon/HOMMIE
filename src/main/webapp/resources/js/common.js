// 새 창 열어 이동
function moveToViewF(fNum) {
	newPage = window.open("viewF?flatID=" + fNum);
}

//최근 본 아이템 삭제 기간
var LATELY_VIEW_ITEM_EXPIRATION_DATE = 1;
//최근 본 아이템 최대 저장 개수
var LATELY_VIEW_ITEM_MAX_SAVE_COUNT = 50;


function isNull(obj) {
	if (obj == '' || obj == null || obj == undefined || obj == NaN) {
		return true;
	} else {
		return false;
	}
}

/*로컬 스토리지 저장*/
function setLocalStorage(name, obj) {
	localStorage.setItem(name, obj);
}

/*로컬 스토리지 삭제*/
function removeLocalStorage(name) {
	localStorage.removeItem(name);
}

/*로컬스토리지에서 특정 객체 갖고오기*/
function getItemLocalStorage(name) {
	return localStorage.getItem(name);
}

$(document).ready(function() {
	initLatelyViewItemList();
});


/* 최근 본 상품 관련 로컬 스토리지 공간 확보, 일정 시간 지난 거 빼고 재저장 */
function initLatelyViewItemList() {
	//로컬 스토리지에서 latelyViewItemList로 저장된 정보 있나 확인
	if (isNull(getItemLocalStorage('latelyViewItemList'))) {
		//없으면 공간 생성
		setLocalStorage('latelyViewItemList', null);
		//상품을 표시할 ul에 Nothing 화면 표시
		$("ul#latelyViewItemList_ul").append('<p class="nothingF">최근 본 방이 없습니다.</p>');
	} else {
		//기존 정보 있을 경우
		//저장된 정보 가져오기
		var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
		//실제 저장된 데이터가 있는 경우
		if (latelyViewItemListJson != "null" || isNull(latelyViewItemListJson)) {
			var nowDate = new Date();
			//문자열을 자바스크립트 객체로 변환
			var latelyViewItemList = JSON.parse(latelyViewItemListJson);
			//일정시간 경과된 아이템을 제외하고 다시 넣기 위한 새로운 Array
			var latelyViewItemListNew = new Array();
			//상품 리스트를 돌면서 상품별 저장된 시간이 현재 시간보다 클 경우만
			//다시 latelyViewItemListNew에 추가
			for (var i in latelyViewItemList) {
				var viewTime = new Date(latelyViewItemList[i].viewTime);
				//시간이 경과된 경우를 제외하고 다시 저장.
				if (nowDate.getTime() < viewTime.getTime()) {
					latelyViewItemListNew.push(latelyViewItemList[i]);
				}
			}

			//시간이 모두 경과된 경우 담긴 새로운 배열요소가 없으므로
			//로컬 스토리지를 비워줌.
			if (latelyViewItemListNew.length == 0) {
				setLocalStorage('latelyViewItemList', null);
			} else {
				setLocalStorage('latelyViewItemList', JSON.stringify(latelyViewItemListNew));
			}
		}
		//화면을 그리는 함수 호출
		LatelyViewItemRender();
	}
}

/*로컬 스토리지 저장 후 아이템 상세보기 페이지 이동*/
function moveItemViewPage(viewID, rentType, deposit, rent, detail, flatID, fImagePath) {
	var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
	var viewTime = new Date();
	//최근 본 상품이 없을 경우 무조건 저장
	if (latelyViewItemListJson == "null" || isNull(latelyViewItemListJson)) {
		//새로 저장할 리스트
		var latelyViewItemListNew = new Array();
		var latelyViewItem = {
			"viewID": viewID,
			"rentType": rentType,
			"deposit": deposit,
			"rent": rent,
			"detail": detail,
			"flatID": flatID,
			"fImagePath": fImagePath,
			"viewTime": viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
		}
		latelyViewItemListNew.unshift(latelyViewItem);
		setLocalStorage('latelyViewItemList', JSON.stringify(latelyViewItemListNew));
	} else {
		var latelyViewItemList = JSON.parse(latelyViewItemListJson);
		var isExistsItem = false;	// 이미 본 상품인지 판단할 변수
		breakPoint: for (var i in latelyViewItemList) {
			if (Number(latelyViewItemList[i].flatID) === Number(flatID) && latelyViewItemList[i].viewID === viewID) {
				isExistsItem = true;
				break breakPoint;
			}
		}
		//새로 본 상품만 저장
		if (!isExistsItem) {
			// 최대 갯수 50개 이상일 경우 마지막 거 삭제 후 새로 본 상품을 맨 앞에 저장
			if (latelyViewItemList.length == Number(LATELY_VIEW_ITEM_MAX_SAVE_COUNT)) {
				latelyViewItemList.pop();
			}
			var latelyViewItem = {
				"viewID": viewID,
				"rentType": rentType,
				"deposit": deposit,
				"rent": rent,
				"detail": detail,
				"flatID": flatID,
				"fImagePath": fImagePath,
				"viewTime": viewTime.setDate(viewTime.getDate() + Number(LATELY_VIEW_ITEM_EXPIRATION_DATE))
			}
			latelyViewItemList.unshift(latelyViewItem);
			setLocalStorage('latelyViewItemList', JSON.stringify(latelyViewItemList));
		}
	}
	moveToViewF(flatID);
}

//최근 본 상품 화면 셋팅
function LatelyViewItemRender() {
	//일단 상품 리스트 비움
	$("ul#latelyViewItemList_ul").empty();

	//최근 본 상품 전체 보기
	$("ul#recentelyViewAll").empty();

	//로컬스토리지에서 latelyViewItemList 값 확인
	if (getItemLocalStorage('latelyViewItemList') != "null" || !isNull(getItemLocalStorage('letelyViewItemList'))) {
		var latelyViewItemList = JSON.parse(getItemLocalStorage('latelyViewItemList'));
		var cnt = 0;	// 홈화면 최근 본 목록과 최근 본 목록 전체보기 구분하기 위한 변수
		//전체 갯수 구해옴
		var length = latelyViewItemList.length;
		for (var i = 0; i < length; i++) {
			if (!isNull(latelyViewItemList[i]) && $("input#nowID").val() == latelyViewItemList[i].viewID) {
				if (cnt <= 4) {
					//상품 그리기
					$("ul#latelyViewItemList_ul").append(
						$("<li>").attr("onclick", "location.href='viewF?flatID=" + latelyViewItemList[i].flatID + "'").append(
							$("<img>").attr({
								"src": latelyViewItemList[i].fImagePath,
								"class": "keyword"
							})
						).append(
							$("<p>").append(latelyViewItemList[i].rentType + " " + latelyViewItemList[i].deposit + "/" + latelyViewItemList[i].rent + "<br>" + latelyViewItemList[i].detail + "</p>")
						)
					);
				}
				cnt++;
				$("ul#recentelyViewAll").append(
					$("<li>").attr("onclick", "location.href='viewF?flatID=" + latelyViewItemList[i].flatID + "'").append(
						$("<img>").attr({
							"src": latelyViewItemList[i].fImagePath,
							"class": "keyword"
						})
					).append(
						$("<p>").append(latelyViewItemList[i].rentType + " " + latelyViewItemList[i].deposit + "/" + latelyViewItemList[i].rent + "<br>" + latelyViewItemList[i].detail + "</p>")
					)
				);
			}
		}
		if (cnt == 0) {
			$("ul#latelyViewItemList_ul").append('<p class="nothingF">최근 본 방이 없습니다.</p>');
			$("ul#recentelyViewAll").append('<p class="nothingF">최근 본 방이 없습니다.</p>');
		} else if (cnt > 5) {
			$("a#seeAll").attr("href", "recentViews").append("모두보기 (" + cnt + ") >");
		}
	} else {
		$("ul#latelyViewItemList_ul").append('<p class="nothingF">최근 본 방이 없습니다.</p>');
		$("ul#recentelyViewAll").append('<p class="nothingF">최근 본 방이 없습니다.</p>');
	}
}

/* 글 삭제 됐을 때 최근 본 목록에서도 삭제 */
function delFlatAfter(fNum) {
	//로컬 스토리지에서 latelyViewItemList로 저장된 정보 있나 확인
	if (!isNull(getItemLocalStorage('latelyViewItemList'))) {
		//기존 정보 있을 경우
		//저장된 정보 가져오기
		var latelyViewItemListJson = getItemLocalStorage('latelyViewItemList');
		//실제 저장된 데이터가 있는 경우
		if (latelyViewItemListJson != "null" || isNull(latelyViewItemListJson)) {
			//문자열을 자바스크립트 객체로 변환
			var latelyViewItemList = JSON.parse(latelyViewItemListJson);
			// 삭제된 아이템 제외하고 다시 넣기 위한 새로운 Array
			var latelyViewItemListNew = new Array();
			//상품 리스트를 돌면서 삭제된 플랫과 ID가 다른 경우만
			//다시 latelyViewItemListNew에 추가
			for (var i in latelyViewItemList) {
				var flatID = latelyViewItemList[i].flatID;
				//ID 다른 경우만 저장
				if (fNum !== flatID) {
					latelyViewItemListNew.push(latelyViewItemList[i]);
				}
			}

			//남길 기록 없을 경우 담긴 새로운 배열요소가 없으므로
			//로컬 스토리지를 비워줌.
			if (latelyViewItemListNew.length == 0) {
				setLocalStorage('latelyViewItemList', null);
			} else {
				setLocalStorage('latelyViewItemList', JSON.stringify(latelyViewItemListNew));
			}
		}
	}
}