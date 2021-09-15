Number.prototype.format = function(){
    if(this==0) return 0;
 
    var r = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
 
    while (r.test(n)) n = n.replace(r, '$1' + ',' + '$2');
    return n;
};
// 문자열 타입용 format() 함수
String.prototype.format = function(){
    var n = parseFloat(this);
    if( isNaN(n) ) return "0";
 
    return n.format();
};

//3자리 콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



/* 구매하기 페이지에서 검사 */
function checkPurchase(easyPw, pieceInput, pieceP) {
	document.getElementById('easypwErr').innerText = ''
	if(easyPw != 'success') {
		document.getElementById('easypwErr').innerText = '비밀번호가 일치하지 않습니다.'
		return false;
	}
	if(pieceInput > pieceP) {
		return false;
	}
	return true;
}

/*로그인 페이지*/
//쿠키값 Set
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
    exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키값 Delete
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키값 가져오기
function getCookie(cookie_name) {
    var x, y;
    var val = document.cookie.split(';');
    
    for (var i = 0; i < val.length; i++) {
        x = val[i].substr(0, val[i].indexOf('='));
        y = val[i].substr(val[i].indexOf('=') + 1);
        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
        
        if (x == cookie_name) {
          return unescape(y); // unescape로 디코딩 후 값 리턴
        }
    }
}

/*알림*/
