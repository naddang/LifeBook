function check_ok() {
	if (document.notice_form.user_id.value.length == 0) {
		alert("관리자 아이디를 입력하세요.");
		notice_form.user_id.focus();
		return;
	}
	
	if (document.notice_form.n_title.value.length == 0) {
		alert("글 제목을 입력하세요.");
		notice_form.n_title.focus();
		return;
	}
	
	if (document.notice_form.n_content.value.length == 0) {
		alert("글 내용을 입력하세요.");
		notice_form.n_content.focus();
		return;
	}
	
	document.notice_form.submit();
}
