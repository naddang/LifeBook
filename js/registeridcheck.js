		function result() {
			opener.document.reg_frm.userID.value = document.chk_frm.userID.value;
			
			opener.document.reg_frm.userID.readOnly=true;
			
			window.close();
		}