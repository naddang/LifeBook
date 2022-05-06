	function linkToOpener(URL) {
		if (window.opener && !window.opener.closed) //부모창이 존재하고 닫혀있지 않을 때
		window.opener.location = URL;               //부모창에서 이동할 주소
		window.close();                             //창닫기
	}