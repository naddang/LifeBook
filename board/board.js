function check_ok() {
	if (document.board_form.userID.value.length == 0) {
		alert("아이디를 입력하세요.");
		board_form.userID.focus();
		return;
	}
	
	if (document.board_form.boardTitle.value.length == 0) {
		alert("글 제목을 입력하세요.");
		board_form.boardTitle.focus();
		return;
	}
	
	if (document.board_form.boardContent.value.length == 0) {
		alert("글 내용을 입력하세요.");
		board_form.boardContent.focus();
		return;
	}
	
	document.board_form.submit();
}



/*
function edit_ok() {
	var url = "commentEdit.jsp?c_number=<%= c_number %>";
	var name = "댓글 수정";
	var option = "width=500, height=300";
	
	window.open(url, name, option);

}
*/