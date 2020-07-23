/**
 * 
 */

var viewItem = undefined; // 가장 최근에 view 한 글 데이터
$(document).ready(function() {
	
	boardRord();
	$('#sidebarCollapse').on('click', function() {
		$('#sidebar').toggleClass('active');
		
	
	});

	// 게시판 목록 1페이지 로딩
	// 글 작성 버튼 누르면 팝업
	$('#btnWrite').click(function() {
		setPopup('write');
		$('#dlg_write').show();
	});

	// 모달 대화상자에서 클로즈 버튼 누르면 닫기
	$('.modal .close').click(function() {
		// $('#dlg_write').hide();
		$(this).parents(".modal").hide();
	});

	// 글 작성 submit 처리(db저장, action은 없으나)
	$("#frmWrite").submit(function() {
		
		$(this).parents(".modal").hide(); // 저장 처리를하면
		return chkWrite(); // 페이지 리로딩이 발생되면 안된다. but 리쿼스트는 할거기 때문에 fun 이용
	});

	// 글 삭제 버튼 누르면
	$('#btnDel').click(function() {
		return chkDelete();
	});

	// 글 읽기(view) 대화 상자에서 삭제버튼 누르면 해당 글(uid) 삭제 진행
	$('#viewDelete').click(function() {
		var uid = viewItem.uid;
		if (deleteUid(uid)) {// 해당글 삭제
			$(this).parents(".modal").hide(); // 삭제 성동하면 대화상자 닫기

		}
	});

	// 글 읽기(view) 대화 상자에서 수정버튼 누르면 해당 글 수정
	$('#viewUpdate').click(function() {
		setPopup("update");
	});

	// 글 수정 완료 버튼 누르면
	$('#updateOk').click(function() {
		chkUpdate();
	});
});

function boardRord() {
	$('#tlc').DataTable().destroy();
	var n_uid;
	$('#tlc').DataTable({
		ajax : {
			url : '/hrm/notice/list.ajax',
			dataSrc : 'data'
		},
		columns : [{
					data : "uid",
					"render" : function(data, type, full, meta) {
						n_uid = data;
						return '<input type="checkbox" name="uid" value='+ data + '>'}},
					{data : "subject",
					"render" : function(data, type, full, meta) {
						return '<span class="subject" data-uid='+ n_uid+ '>'+ data+ '</span>'}},
					{data : "regdate"}, 
					{data : "department"},
					{data : "position"}],
		columnDefs : [ {
			targets : 0,
			orderable : false
		} ],
		order : [ [ 1, 'asc' ] ],
		language : {
			info : '총 공지사항  _TOTAL_ 개',
			infoFiltered : '(검색된 공지사항 _MAX_개)',
			lengthMenu : '_MENU_씩 보기',
			search : '검색 : ',
			infoEmpty : '검색된 공지사항  0 개',
			zeroRecords : '검색 된 공지사항이 없습니다.',
			paginate : {
				first : '<<',
				last : '>>',
				previous : '<',
				next : '>'
			}
		}
	});
}

function changePageRows() {
	window.pageRows = $("#rows").val();
	loadPage(window.page);
}// end changePageRows()

// 새글 등록 처리
function chkWrite() {
	
	CKEDITOR.instances.editor.updateElement(); //ckeditor 에서 쓴글을 가져올때 사용 
	var data = $('#frmWrite').serialize();
	
	// alert(data + "--" + typeof data); // 확인용

	// ajax request
	$.ajax({
		url : 'writeOk.ajax',
		type : "POST",
		cache : false,
		data : data, // post 로 ajax request 하는 경우 parameter 담기
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					alert("INSERT 성공" + data.count + "개:" + data.status);
					boardRord();
				} else {
					alert("INSERT 실패" + data.status + " : " + data.message);
				}
			}
		}
	});

	$('#frmWrite')[0].reset();

	return false; 
}// end chkWrite()

// check 된 uid 의 게시글들만 삭제
// .each() 그 각각에 대해서 함수를 진행햐라
function chkDelete() {
	var uids = [] // 빈 배열 준비
	$('#list tbody input[name=uid]').each(function() {
		// $(this) 는 checkbox
		if ($(this).is(":checked")) { // jQuery 에서 check 여부 확인 방법
			uids.push($(this).val()); // 배열에 uid 값 추가
		}
	});

	// alert(uids);
	if (uids.length == 0) {
		alert("삭제할 글을 체크해 주세여");
	} else {
		if (!confirm(uids.length + "개의 글을 삭제하시겠습니까?"))
			return false; // 취소를 누르면 체크된 상태로 취소

		var data = $('#frmList').serialize();
		// uid=1010&uid=1111

		$.ajax({
			url : 'deleteOk.ajax',
			type : "POST",
			data : data,
			cache : false,
			success : function(data, status) {
				if (status == "success") {
					if (data.status == "OK") {
						alert("DELETE 성공 " + data.count + "개");
						boardRord();
					} else {
						alert("DELETE 실패 " + data.message);
					}
				}
			}
		});

	}

}// end chkDelete()

// 현재 글 목록 list에 대해 이벤트 등록
function addViewEvent() {

	$('#list .subject').click(
			function() {

				// alert($(this).text() + " : " + $(this).attr('data-uid')); //
				// 확인용

				// 읽어오기
				$.ajax({
							url : "view.ajax?uid=" + $(this).attr('data-uid'),
							type : "GET",
							cache : false,
							success : function(data, status) {
								if (status == "success") {
									if (data.status == "OK") {
										// 읽어온 view 데이터를 전역변수에 세팅
										viewItem = data.data[0]; // 0 인이유는
																	// 하나밖에
																	// 없으니깡?.
										// 팝업에 보여주기
										setPopup("view");
										$("#dlg_write").show();

										// 리스트 상의 조회수 증가시키기 ( data 안에 값이 담겨있따
										$(
												"#list [data-viewcnt='"+ viewItem.uid + "']").text(viewItem.viewcnt);

									} else {
										alert("VIEW 실패" + data.message);
									}
								}
							}
						});

			});

}// end addViewEvent()

function setPopup(mode) {

	// 글 작성
	if (mode == 'write') {
		// jquery 객체 집합객체이기 떄문에 반드시 [] 해줘애함 그래야 자바스크립트 함수사용가능
		$('#frmWrite')[0].reset(); // from 안의 기존 내용 reset
		$("#dlg_write .title").text('새 공지 작성');
		$('#dlg_write .btn_group_header').show();
		$('#dlg_write .btn_group_write').show();
		$('#dlg_write .btn_group_view').hide();
		$('#dlg_write .btn_group_update').hide();

		$("#dlg_write input[name='subject']").attr("readonly", false);
		// $("#dlg_write input[name='subject']").css("border", "1px solid
		// #ffd");

		$("#dlg_write textarea[name='content']").attr("readonly", false);
		$("#dlg_write textarea[name='content']")
				.css("border", "1px solid #ffd");
	}

	// 글 읽기
	if (mode == 'view') {
		$('#frmWrite')[0].reset(); // from 안의 기존 내용 reset
		$("#dlg_write .title").text('공지 읽기');
		$('#dlg_write .btn_group_header').show();
		$('#dlg_write .btn_group_write').hide();
		$('#dlg_write .btn_group_view').show();
		$('#dlg_write .btn_group_update').hide();

		// 조회수와 날짜
		$("#dlg_write #viewcnt").text(
				"#" + viewItem.uid + " - 조회수: " + viewItem.viewcnt);
		$("#dlg_write #regdate").text(viewItem.regdate);
		$("#dlg_write input[name='uid']").val(viewItem.uid); // 나중에 삭제/수정을 위해
																// 필요

		$("#dlg_write input[name='subject']").val(viewItem.subject);
		$("#dlg_write input[name='subject']").attr("readonly", true);
		$("#dlg_write input[name='subject']").css("border", "none");

		$("#dlg_write textarea[name='content']").val(viewItem.content);
		$("#dlg_write textarea[name='content']").attr("readonly", true);
		$("#dlg_write textarea[name='content']").css("border", "none");

	}

	// 글 수정
	if (mode == 'update') {
		// $('#frmWrite')[0].reset(); // from 안의 기존 내용 reset 인데 수정은 reset하면
		// 담겨져있던 val이 사라짐
		$("#dlg_write .title").text('공지 수정');
		$('#dlg_write .btn_group_header').show();
		$('#dlg_write .btn_group_write').hide();
		$('#dlg_write .btn_group_view').hide();
		$('#dlg_write .btn_group_update').show();

		$("#dlg_write input[name='subject']").attr("readonly", false);
		$("#dlg_write input[name='subject']").css("border", "1px solid #ffd");

		$("#dlg_write textarea[name='content']").attr("readonly", false);
		$("#dlg_write textarea[name='content']")
				.css("border", "1px solid #ffd");
	}
}// end setPopup()

// 특정 uid 의 글 삭제하기
function deleteUid(uid) {
	if (!confirm(uid + "글을 삭제 하시겠습니까?"))
		return false;

	// POST 방식
	$.ajax({
		url : "deleteOk.ajax",
		type : "POST",
		data : "uid=" + uid,
		cache : false,
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					alert("DELETE 성공" + data.count + "개");
					boardRord();
				} else {
					alert("DELETE 실패" + data.message);
					return false;
				}
			}
		}
	});

	return true;
}// end deleteUid

// 글 수정
function chkUpdate() {

	var data = $("#frmWrite").serialize();

	$.ajax({
		url : "updateOk.ajax",
		type : "POST",
		cache : false,
		data : data,
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					alert("UPDATE 성공" + data.count + "개: " + data.status);
					boardRord();
				} else {
					alert("UPDATE 실패" + data.status + " : " + data.message);
				}
				$("#dlg_write").hide(); // 현재 팝업닫기
			}
		}
	});

}// end chkUpdate()

