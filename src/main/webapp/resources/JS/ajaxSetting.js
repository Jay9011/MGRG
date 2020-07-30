/**
 *  jquery 아래에 있어야합니다~~
 */


$(document).ready(function(){
		var token = $("meta[name='_csrf']").attr("content");
	    var header = $("meta[name='_csrf_header']").attr("content");
	   
       // ajax를 보내기전에 header세팅해주기
       $.ajaxSetup({
          beforeSend : function(xhr) {
             xhr.setRequestHeader(header, token);
          }
       });
		
	});