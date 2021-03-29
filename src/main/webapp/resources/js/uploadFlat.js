//월세/전세
function onChk(v, w) {
	document.getElementById(w).style.display = "";
	if (v == "M") {
		document.getElementById("depo").placeholder = "보증금";
		document.getElementById("mon").placeholder = "월세(관리비 포함)";
	} else {
		document.getElementById("depo").placeholder = "전세금";
		document.getElementById("mon").placeholder = "한 달 관리비";
	}
}


// 입주 날짜
function todayD() {
	var today = $.datepicker.formatDate('yy-mm-dd', new Date());
	$("#selMoveD").html(today);
	$("#moveDate").val(today);
}

$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#moveDate2").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true,
		changeYear: true,
		minDate: 0,
		onSelect: function(d) {
			$("#selMoveD").html(d);
			$("#moveDate").val(d);
		}
	});
});

//첨부파일 관리
function addFile() {
	$("#input_imgs").click();
}
// input file 이미지 미리보기 함수
var sel_files = [];
$(document).ready(function() {
	$("#input_imgs").on("change", handleImgFileSelect);
});
function handleImgFileSelect(e) {
	sel_files = [];
	$("#imgimg").empty();
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	var index = 0;
	filesArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_files.push(f);
		var reader = new FileReader();
		reader.onload = function(e) {
			var html = "<div id=\"img_id_" +
				index + "\" class=\"cropping\"><a class=\"dark-img\" href=\"javascript:void(0);\" onclick=\"deleteImageAction("
				+ index + ")\"><i class=\"fa fa-window-close imgDel\" aria-hidden=\"true\"></i><img id=\"crop_img\" src=\"" +
				e.target.result + "\" data-file='" + f.name + "' class='selProductFile' title='클릭해서 삭제하기'></a></div>";
			$("#imgimg").append(html);
			index++;
		}
		reader.readAsDataURL(f);
	});

	var fNum = $("#fIDHidden").val();
	if (fNum != null) {
		$.ajax({
			url: "delAllPhoto",
			data: fNum,
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			type: "POST",
			success: function(data) {
				$("#howManyP").val(0);
			},
			error: function(request, status, error) {
				console.log("AJAX_ERROR");
			}
		});
	}
}
//특정 이미지만 삭제하기
function deleteImageAction(index) {
	console.log("index : " + index);
	sel_files.splice(index, 1);

	var img_id = "#img_id_" + index;
	$(img_id).remove();
	console.log(sel_files);
}

//유효성 검사
function submitChk() {
	var al = $("#msgAl");

	// 매물종류 라디오
	if ($(':radio[name="room"]:checked').length < 1) {
		$("#flatType1").focus();
		$("#msgAl").html("매물 종류를 선택하세요!");
		$("#myAlert").show();
		return false;
	}
	// 거래종류 라디오
	if ($(':radio[name="rentType"]:checked').length < 1) {
		$("#deal1").focus();
		$("#msgAl").html("거래 종류를 선택하고 금액을 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//금액 입력했나요
	if (!$("#depo").val() || !$("#mon").val()) {
		$("#deal1").focus();
		$("#msgAl").html("금액을 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//금액 숫자인가요
	if (isNaN($("#depo").val()) || isNaN($("#mon").val())) {
		$("#deal1").focus();
		$("#msgAl").html("금액에는 숫자만 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//주소 입력했나요
	if (document.getElementById("showAdrs").innerHTML == "") {
		$("#adrsSch").focus();
		$("#msgAl").html("주소를 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//상세주소 입력했나요
	if (!$("#detailedAdr").val()) {
		$("#detailedAdr").focus();
		$("#msgAl").html("상세주소를 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//평수랑 층수 입력했나요
	if (!$("#pyeong").val() || !$("#floor").val()) {
		$("#pyeong").focus();
		$("#msgAl").html("매물의 평수와 층수를 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//평수 층수 숫자인가요
	if (isNaN($("#pyeong").val()) || isNaN($("#floor").val())) {
		$("#pyeong").focus();
		$("#msgAl").html("평수와 층수는 숫자만 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	//입주가능일 입력했나요
	if (document.getElementById("selMoveD").innerHTML == "") {
		$("#moveDate1").focus();
		$("#msgAl").html("입주가능일을 입력하세요!");
		$("#myAlert").show();
		return false;
	}
	$("#moveDate").val(document.getElementById("selMoveD").innerHTML);
	//상세 설명 제목 입력했나요
	if (!$("#detTitle").val()) {
		$("#detTitle").focus();
		$("#msgAl").html("상세설명의 제목을 입력하세요!");
		$("#myAlert").show();
		return false;
	}

	//상세 설명 입력했나요
	if (!$("#detail").val()) {
		$("#detail").focus();
		$("#msgAl").html("상세설명을 입력하세요!");
		$("#myAlert").show();
		return false;
	}

	var fiCnt = $("#howManyP").val();
	//사진 세 장 이상 등록했나요
	/*alert(sel_files.length);
	alert(fiCnt);*/
	if (fiCnt != null) {
		if (sel_files.length + fiCnt < 3) {
			$("#img").focus();
			$("#msgAl").html("사진을 세 장 이상 등록하세요!");
			$("#myAlert").show();
			return false;
		}
	} else {
		if (sel_files.length < 3) {
			$("#img").focus();
			$("#msgAl").html("사진을 세 장 이상 등록하세요!");
			$("#myAlert").show();
			return false;
		}
	}

	//체크박스 체크 했나요
	if (!$("input:checked[id='ok']").is(":checked")) {
		$("#ok").focus();
		$("#msgAl").html("매물관리규정 동의는 필수입니다!");
		$("#myAlert").show();
		return false;
	}
}
function closeAl() {
	$("#myAlert").hide();
}


