/**
 * 
 */
function chkchange() {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var form = $('#form')[0];
		// 	alert(form);  확인용

		var formData = new FormData(form); // HTML5
		// 	alert(formData); 확인용

		$.ajaxSetup({
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			}
		});
		$.ajax({
			url : 'uploadAjax',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				//alert(data);
				//서버로 파일을 전송한 다음에 그 파일을 다시 받아온다.?

				//이미지 인경우 썸네일을 보여준다.
				if (checkImageType(data)) {
					str = "<div>"
							+ "<a href='displayFile?fileName="
							+ getImageLink(data)
							+ "'>"
							+ "<img src='displayFile?fileName="
							+ data
							+ "'/>"
							+ "</a>"
							+ "<small data-src='" + data + "'>X</small></div>";
				} else {
					str = "<div>"
							+ "<a href='displayFile?fileName="
							+ data
							+ "'>"
							+ getOriginalName(data)
							+ "</a>"
							+ "<small data-src='" + data + "'>X</small></div>";
				}//else

				$(".uploadedList").append(str);
			},
		});// ajax

		/* 컨트롤러로 부터 전송받은 파일이 이미지 파일인지 확인하는 함수 */
		function checkImageType(fileName) {
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			return fileName.match(pattern);
		}//checkImageType

		//파일 이름 처리 : UUID 가짜 이름 제거
		function getOriginalName(fileName) {
			if (checkImageType(fileName)) {
				return;
			}

			var idx = fileName.indexOf("_") + 1;
			return fileName.substr(idx);

		}//getOriginalName

		//이미지 원본 링크 제공
		function getImageLink(fileName) {

			if (!checkImageType(fileName)) {
				return;
			}//if

			var front = fileName.substr(0, 12);
			var end = fileName.substr(14);

			return front + end;

		}//getImageLink

		//업로드 파일 삭제 처리
		$(".uploadedList").on("click", "small", function(event) {

			var that = $(this);
			// 		alert($(this).attr("data-src"));

			$.ajax({
				url : "deleteFile",
				type : "post",
				data : {
					fileName : $(this).attr("data-src")
				},
				dataType : "text",
				success : function(result) {
					if (result == 'deleted') {
						//alert("deleted");
						that.parent("div").remove();
					}//
				},
			});

		});//uploadedList
	}