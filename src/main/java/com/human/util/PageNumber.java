package com.human.util;

public class PageNumber {
	private int page; // 현재 기준 페이지
	private int count; // 총 글수
	private int pageCnt = 10;
	private int groupCnt = 5;

	// 위의 세가지 변수로 아래 변수를 계산 할 수 있다.
	private int start; // 페이지그룹 시작 번호
	private int end; // 페이지그룹 끝 번호
	private int nowPageStart; // 표시될 페이지 시작번호
	private int nowPageEnd; // 표시될 페이지 끝번호
	private int prev = 0;;
	private int next = 0;
	private String memberID = null;

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public Integer getPage() {
		return page;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPage(Integer page) {
		if (page < 1) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public void setCount(Integer count) {
		if (count < 1) {
			return;
		}
		this.count = count;
		calcPage();
	}

	public int getCount() {
		return count;
	}

	public int getStart() {
		return start;
	}

	public int getEnd() {
		return end;
	}

	public int getPrev() {
		return prev;
	}

	public int getNext() {
		return next;
	}

	public int getNowPageStart() {
		return nowPageStart;
	}

	public int getNowPageEnd() {
		return nowPageEnd;
	}

	private void calcPage() {// page 계산
		// 페이지네이션 끝번호 지정, 현재 page가 6미만이면 5까지, 6이상부터는 6~10까지
		int tempEnd = (int) (Math.ceil(page / (float) groupCnt) * groupCnt);

		// 시작 페이지네이션 구하기
		this.start = tempEnd - (groupCnt - 1);

		// 페이지네이션 시작번호가 5보다 클 경우는 이전 버튼이 있음.
		if (start > groupCnt) {
			prev = start - groupCnt;
		}

		// 총 매물 개수가 tempEnd를 끝까지 못채운다면
		if (tempEnd * pageCnt > this.count) {
			this.end = (int) Math.ceil(this.count / (float) pageCnt);
		} else {
			// 아니면 다음 버튼 생성
			this.end = tempEnd;
			next = end + 1;
		}

		// 화면 첫번째 매물 번호
		nowPageStart = (page - 1) * 10 + 1;
		// 화면 마지막 매물 번호
		nowPageEnd = nowPageStart + pageCnt;
		// 마지막 매물 번호가 매물 총 개수보다 많으면
		if (nowPageEnd > this.count) {
			nowPageEnd = this.count;
		}
	}
}