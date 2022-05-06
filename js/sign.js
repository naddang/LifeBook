function check_ok(){
	
	if(reg_frm.userID.value.length == 0){
		alert("ID를 써주세요.");
		reg_frm.userID.focus();
		return;
	}
	
	
	if(reg_frm.userPWD.value.length == 0){
		alert("패스워드는 반드시 입력해야 합니다.");
		reg_frm.userPWD.focus();
		return;
	}
	
	if(reg_frm.userPWD_check.value != reg_frm.userPWD.value){
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.userPWD_check.focus();
		return;
	}
	
	if(reg_frm.userName.value.length == 0){
		alert("이름을 써주세요.");
		reg_frm.userName.focus();
		return;
	}

	if(reg_frm.user_tel2.value.length == 0){
		alert("전화번호를 써주세요.");
		reg_frm.user_tel2.focus();
		return;
	}
	
	if(isNaN(reg_frm.user_tel2.value)){
		alert("전화번호는 숫자만 입력가능합니다.");
		reg_frm.user_tel2.focus();
		return;
	}
	
	if(reg_frm.user_tel3.value.length == 0){
		alert("전화번호를 써주세요.");
		reg_frm.user_tel3.focus();
		return;
	}
	
	if(isNaN(reg_frm.user_tel3.value)){
		alert("전화번호는 숫자만 입력가능합니다.");
		reg_frm.user_tel3.focus();
		return;
	}
	
	if(reg_frm.postAddr1.value.length == 0){
		alert("우편번호를 써주세요.");
		reg_frm.postAddr1.focus();
		return;
	}
	
	if(reg_frm.postAddr2.value.length == 0){
		alert("도로명 주소를 써주세요.");
		reg_frm.postAddr2.focus();
		return;
	}
	
	if(reg_frm.postAddr3.value.length == 0){
		alert("세부 주소를 써주세요.");
		reg_frm.postAddr3.focus();
		return;
	}
	
	if(isNaN(reg_frm.year.value)){
		alert("년도는 숫자만 입력가능합니다.");
		reg_frm.year.focus();
		return;
	}
	
	if(reg_frm.year.value.length != 4){
		alert("년도는 반드시 4자리를 입력해주세요.");
		reg_from.year.focus();
		return;
	}

	if(isNaN(reg_frm.date.value)){
		alert("일자는 숫자만 입력가능합니다.");
		reg_frm.date.focus();
		return;
	}	
	
	if(reg_frm.date.value.length != 2){
		alert("일자는 반드시 2자리로 입력해주세요.");
		reg_from.date.focus();
		return;
	}

	document.reg_frm.submit();
}


function withdraw_ok(){
	if(reg_frm.userPWD.value.length == 0){
		alert("비밀번호를 써주세요.");
		reg_frm.userPWD.focus();
		return;
	}
		
	document.reg_frm.submit();
}

function modify_check_ok(){
	
	if(reg_frm.ori_user_pwd.value.length == 0){
		alert("기존암호를 입력해주세요.");
		reg_frm.ori_user_pwd.focus();
		return;
	}
	
	if(reg_frm.userPWD.value.length == 0){
		alert("패스워드는 반드시 입력해야 합니다.");
		reg_frm.userPWD.focus();
		return;
	}
	
	if(reg_frm.userPWD_check.value != reg_frm.userPWD.value){
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.userPWD_check.focus();
		return;
	}

	if(reg_frm.user_tel2.value.length == 0){
		alert("전화번호를 써주세요.");
		reg_frm.user_tel2.focus();
		return;
	}
	
	if(isNaN(reg_frm.user_tel2.value)){
		alert("전화번호는 숫자만 입력가능합니다.");
		reg_frm.user_tel2.focus();
		return;
	}
	
	if(reg_frm.user_tel3.value.length == 0){
		alert("전화번호를 써주세요.");
		reg_frm.user_tel3.focus();
		return;
	}
	
	if(isNaN(reg_frm.user_tel3.value)){
		alert("전화번호는 숫자만 입력가능합니다.");
		reg_frm.user_tel3.focus();
		return;
	}
	
	if(reg_frm.postAddr1.value.length == 0){
		alert("우편번호를 써주세요.");
		reg_frm.postAddr1.focus();
		return;
	}
	
	if(reg_frm.postAddr2.value.length == 0){
		alert("도로명 주소를 써주세요.");
		reg_frm.postAddr2.focus();
		return;
	}
	
	if(reg_frm.postAddr3.value.length == 0){
		alert("세부 주소를 써주세요.");
		reg_frm.postAddr3.focus();
		return;
	}
	
	if(isNaN(reg_frm.year.value)){
		alert("년도는 숫자만 입력가능합니다.");
		reg_frm.year.focus();
		return;
	}
	
	if(reg_frm.year.value.length != 4){
		alert("년도는 반드시 4자리를 입력해주세요.");
		reg_from.year.focus();
		return;
	}

	if(isNaN(reg_frm.date.value)){
		alert("일자는 숫자만 입력가능합니다.");
		reg_frm.date.focus();
		return;
	}	
	
	if(reg_frm.date.value.length != 2){
		alert("일자는 반드시 2자리로 입력해주세요.");
		reg_from.date.focus();
		return;
	}

	document.reg_frm.submit();
}