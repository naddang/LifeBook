function check_ok() {
	if (document.board_form.faqCategory.value.length == 0) {
		alert("카테고리를 선택해주세요.");
		board_form.faqCategory.focus();
		return;
	}
	
	if (document.board_form.faqTitle.value.length == 0) {
		alert("글 제목을 입력하세요.");
		board_form.faqTitle.focus();
		return;
	}
	
	if (document.board_form.faqContent.value.length == 0) {
		alert("글 내용을 입력하세요.");
		board_form.faqContent.focus();
		return;
	}
	
	document.board_form.submit();
}