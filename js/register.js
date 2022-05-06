function winopen() {
			var left = Math.ceil((window.screen.width - 400)/2);
			var top = Math.ceil((window.screen.height - 200)/2);
			//새창을 열어서 페이지를 오픈 후, 회원 아이디 정보를 가지고 중복체크
			if (reg_frm.userID.value =="" || reg_frm.userID.value.length < 0) {
				alert("아이디는 반드시 입력해야합니다.")
				reg_frm.userID.focus();
			}else {
				window.open("registerIdCheck.jsp?userID="+reg_frm.userID.value,"", "width="+400+", height="+200+", left="+left+", top="+top );
			}
		}
		
		function findAddr(){
			var width = 500; //팝업창의 너비
			var height = 600; //팝업창의 높이
			var left = (window.screen.width*0.5)-(width*0.5); //잘 구동되는데 /2를 사용하면 밑줄이 그임
			var top = (window.screen.height*0.5)-(height*0.5); //그래서 *0.5를 줬다
			new daum.Postcode({
				width: width,
				height: height,
				oncomplete: function(data) {
					
						console.log(data);
					//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					//도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					//내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다
					var roadAddr = data.roadAddress; //도로명 주소 변수
					var jibunAddr = data.jibunAddress; //지번 주소 변수
					
					//우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postAddr1').value = data.zonecode;
					
					if (roadAddr !== '') {
						document.getElementById('postAddr2').value = roadAddr;
					}else if (jibunAddr !== '') {
						document.getElementById('postAddr2').value = jibunAddr;
					}
				}
			}).open({
				left: left,
				top: top
			});
		}