function check_ok(){
	if(mana_form.userPhoneNum.value.legth==0){
		alert("휴대폰번호를 입력하세요");
		mana_form.userPhoneNum.focus();
		return;
	}
	if(mana_form.userAddr.value.legth==0){
		alert("주소를 입력하세요");
		mana_form.userAddr.focus();
		return;
	}
	mana_form.submit();
}