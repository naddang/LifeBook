function winopenid() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 400)/2);
		//새창을 열어서 페이지를 오픈 후, 아이디 찾기
			window.open("findId.jsp","", "width="+600+", height="+400+", left="+left+", top="+top );
	}
	function winopenpwd() {
		var left = Math.ceil((window.screen.width - 600)/2);
		var top = Math.ceil((window.screen.height - 500)/2);
		//새창을 열어서 페이지를 오픈 후, 패스워드 찾기
			window.open("findPwd.jsp","", "width="+600+", height="+500+", left="+left+", top="+top );
	}
	function pop_close() {
		if(login.userID.value.length == 0){
			alert("ID를 써주세요.");
			login.userID.focus();
			return;
		}
		
		
		if(login.userPWD.value.length == 0){
			alert("패스워드는 반드시 입력해야 합니다.");
			login.userPWD.focus();
			return;
		}
		
		document.login.action="loginOk.jsp";
		document.login.target=opener.window.name;
		document.login.submit();
		window.close();
	}
	pop_close();