	function pwd_search() {
		if (findpwd.userName.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
		
		if (findpwd.userID.value.length < 1) {
			alert("ID를 입력해주세요");
			return;
		}
		
		if (findpwd.userPhoneNumber.value.length != 11) {
			alert("휴대폰번호를 정확하게 입력해주세요");
			return;
		}
		
		findpwd.method = "post";
		findpwd.submit();
	}
	
	function winclose() {
		window.open('','_self').close();
	}