	function id_search() {
		if (findid.userName.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
		
		if (findid.userPhoneNumber.value.length != 11) {
			alert("휴대폰번호를 정확하게 입력해주세요");
			return;
		}
		
		findid.method = "post";
		findid.submit();
	}
	
	function winclose() {
		window.open('','_self').close();
	}