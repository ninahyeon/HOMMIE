

// 최소 한 개는 선택해야댐!
function moreThanOne(chk, category) {
	var cat = document.getElementsByName(category);
	var cnt = 0;
	for (var i = 0; i < cat.length; i++) {
		if (cat[i].checked) {
			cnt++;
		}
	}
	if (!cnt) {
		document.getElementById(chk).checked = true;
	}
	addExtraOpt();
}

//   필터 초기화
function refreshOpt() {
	if (confirm("정말 필터를 초기화 하시겠습니까?")) {
		document.getElementById("one").checked = true;
		document.getElementById("two").checked = true;
		document.getElementById("three").checked = true;
		document.getElementById("monthly").checked = true;
		document.getElementById("reserve").checked = true;
		document.getElementById("depositMin").value = "";
		document.getElementById("depositMax").value = "";
		document.getElementById("rentMin").value = "";
		document.getElementById("rentMax").value = "";
		document.getElementById("internet").checked = false;
		document.getElementById("furniture").checked = false;
		document.getElementById("pet").checked = false;
		document.getElementById("park").checked = false;
		addExtraOpt();
	}
}


/*
// 좌측 목록
function addClassAll(el, cls) {
	for (var i = 0; i < el.length; ++i) {
		if (!el[i].className.match('(?:^|\\s)' + cls + '(?!\\S)')) { el[i].className += ' ' + cls; } // if input element (.mask) does not have a class of cls (filter-mask-active) (REGEX to find a match btn other classes (or no other classes btn)).. if not there.... add the class
	}
}
function delClassAll(el, cls) {
	for (var i = 0; i < el.length; ++i) {
		el[i].className = el[i].className.replace(new RegExp('(?:^|\\s)' + cls + '(?!\\S)'), '');
	}
}
function contentFilter(filterID, filterType) {
	var id = filterID;
	document.querySelector(id + ' .filter-categories').onclick = function(evt) {
		var elem = evt.target || evt.srcElement, // .target --> get the element that triggered the event
			wrap = document.querySelectorAll(id +  ' .filter-wrap'), // card container
			items = document.querySelectorAll(id + ' .filter-item'), // card
			inputs = document.querySelectorAll(id  + ' .filter-input'),
			filters = [],
			noitem = document.querySelectorAll(id  + ' .filter-no-item'),
			mask = document.querySelectorAll(id + ' .filter-mask'), // hide cards (covers filter wrap... when filter-mask-active (defined in CSS))
			type = filterType;
		addClassAll(mask, 'filter-mask-active'); // mask all cards, animated in CSS
		setTimeout(function() { delClassAll(mask, 'filter-mask-active'); }, 1000); // create some delay (animation) when unveiling cards
		if (elem.className.match('(?:^|\\s)filter-all(?!\\S)')) { //  if filter-all checkbox clicked...
			for (var i = 1; i < inputs.length; ++i) { // loop through inputs but ignore [0] (skip 1st input in loop) - filter-all
				inputs[i].checked = false; // uncheck all  inputs (excl. filter all)
			}
			delClassAll(items, 'selected'); // remove selected class from all items
			delClassAll(wrap, 'filtered-' + type);
			delClassAll(noitem, 'filter-no-item-active'); // make sure no-filter item message does not show (display: none)
		} else { // ----> another filter is checked.... -------------> WHEN A FILTER OTHER THAN ALL IS CHECKED <----------------------
			inputs[0].checked = false; // uncheck #filter-all
			for (var i = 1; i < inputs.length; ++i) { // loop through inputs but ignore [0] - #filter-all
				if (inputs[i].checked) { filters.push(inputs[i].id); } // add checked inputs to filters array
			}
			delClassAll(items, 'selected'); // remove selected from all items (will display:none;)
			addClassAll(wrap, 'filtered-' + type);

			for (var i = 0; i < filters.length; ++i) { // LOOOPING THROUGH FILTER array
				// if there was at least one checked input (other than all...)  run the addClassAll function adds selected class to filter-items that match checked (checkbox) class
				if (filters.length > 0) { addClassAll(document.querySelectorAll(id + ' .filter-item.' + filters.join('.')), 'selected'); } // build css selector from filters array (add selected class to filter items (all except show all))
				document.querySelectorAll(id + ' .selected').length == 0 ? addClasAll(noitem, 'filter-no-item-active') : delClassAll(noi tem, 'filter-no-item-active'); // if no checkboxes (other than all) are checked, display no matches message
			}
			var checkCount = 0;
		for (var i = 0; i < inputs.length; ++i) {
				checkCount += inputs[i].checked ? 1 : 0; // if inputs[i].checked is true --> add 1, else add 0
			}
			if (checkCount == 0) { inputs[0].checked = true; }
			if (inputs[0].checked) {
				delClassAll(wrap, 'filtered-' + type);
				delClassAll(noitem, 'filter-no-item-active');
			}
		}
	}
}

contentFilter('#gridCardsWithFilter', 'inclusive');
 // unique wrapper id, filter type (inclusive/exclusive));*/