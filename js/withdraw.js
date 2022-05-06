	function linkToOpener(URL) {
		if (window.opener && !window.opener.closed) //부모창이 존재하고 닫혀있지 않을 때
		window.opener.location = URL;               //부모창에서 이동할 주소
		window.close();                             //창닫기
	}
	
	function withdraw_ok(){
		if(reg_frm.userPWD.value.length == 0){
			alert("비밀번호를 써주세요.");
			reg_frm.userPWD.focus();
			return;
		}
		
		if (confirm('정말 탈퇴하시겠습니까?') == true) {
			document.reg_frm.submit();
		} else {
			alert("회원 탈퇴를 취소했습니다.");
			document.location.href="javascript:linkToOpener('mypage.jsp')";
		}
			
	}