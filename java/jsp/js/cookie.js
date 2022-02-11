	/**
	 * 쿠키설정
	 * @params: 쿠키명, 쿠키값, 유효기간
	 */
	SetCookie: function(name, value, expiredays) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	},
	
	/**
	 * 쿠키가져오기
	 * @params: 쿠키명
	 */
	GetCookie: function(name) {
		var nameOfCookie = name + "=";
		var x = 0;
		while ( x <= document.cookie.length ) {
			var y = (x+nameOfCookie.length);
			if ( document.cookie.substring( x, y ) == nameOfCookie ) {
				if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) {
					endOfCookie = document.cookie.length;
				}
				return unescape( document.cookie.substring( y, endOfCookie ) );
			}
			x = document.cookie.indexOf( " ", x ) + 1;
			if ( x == 0 ) break;
		}
		return "";
	},
	
	/**
	 * 쿠키삭제
	 * @params: 쿠키명
	 */
	DeleteCookie: function(name) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = name + "= " + "; expires=" + expireDate.toGMTString();
	}
		
	//조회수 증가
	function fn_readCntUp(){
		if(HHCommon.GetCookie("PUBLIC_CNT_<c:out value='${resultVO.unqId}'/>") == "" ){
			HHCommon.SetCookie("PUBLIC_CNT_<c:out value='${resultVO.unqId}'/>", "REC", 1);
			
			$.ajax({
				url : '/readCntUp.do',
				type : 'POST',
				data : {unqId : $("#unqId").val() }, 
				success : function(){
				},
				error		: function(xhr){
					alert(xhr.status + "," + xhr.statusTest);
				}
			});
		}
	}
