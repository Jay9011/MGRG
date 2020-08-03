/**
 * 
 */
var viewItem = undefined; 
var editor;
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var xhr = new XMLHttpRequest(); 

$(document).ready(function() {

	boardRord();

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
		frm = document.forms["frmWrite"];
		var subject = frm["subject"].value.trim();
		var chk = document.getElementById("chk");    
		chk.innerHTML = "";
		if(subject == "" || CKEDITOR.instances.editor.getData() == '' || CKEDITOR.instances.editor.getData().length ==0){
			chk.innerHTML = "제목과 내용은 필수 항목입니다.";
			
			return false;
		}else{
			
			$(this).parents(".modal").hide(); // 저장 처리를하면
			return chkWrite(); // 페이지 리로딩이 발생되면 안된다. but 리쿼스트는 할거기 때문에 fun 이용
		}
		
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
	
	
	 CKEDITOR.on('instanceReady', function(ev) {
		 editor = ev.editor;
	 });
	
	
});

function boardRord() {
	
	
//	$('#tlc').DataTable().destroy();
	var n_uid;
	$('#tlc').DataTable({
		ajax : {
			url : path+'/notice/list.ajax',
			dataSrc : 'data'
				
		},
		scrollX : true,
		autoWidth:true,
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
		order : [ [ 2, 'desc' ] ], // 작성일을 기준으로 오름차순
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
		},
		fixedColumns: {
			leftColumns : 2
		}
	}).columns.adjust();
	addViewEvent();
}


// 새글 등록 처리
function chkWrite() {
	
	CKEDITOR.instances.editor.updateElement(); //ckeditor 에서 쓴글을 가져올때 사용 
	var data = $('#frmWrite').serialize();
	
	// alert(data + "--" + typeof data); // 확인용

	// ajax request
	$.ajax({
		url : path+'/notice/writeOk.ajax',
		type : "POST",
		cache : false,
		data : data, // post 로 ajax request 하는 경우 parameter 담기
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					Swal.fire({
						  icon: 'success',
						  title: '공지 작성 성공',
						  text: data.count + "개의 공지가 작성 되었습니다." 
						})
					boardRord();
				} else {
					Swal.fire({
						  icon: 'error',
						  title: '공지 작성 실패',
						  text:  data.status + " : " + data.message
						})
				}
			}
		}
	});

	$('#frmWrite')[0].reset();

	return false; 
}// end chkWrite()


function chkDelete() {
	$.ajaxSetup({
        beforeSend: function(xhr) {
        	xhr.setRequestHeader(header, token);
        }
    });
	var uids = [] // 빈 배열 준비
	$('#list tbody input[name=uid]').each(function() {
		// $(this) 는 checkbox
		if ($(this).is(":checked")) { // jQuery 에서 check 여부 확인 방법
			uids.push($(this).val()); // 배열에 uid 값 추가
		}
	});

	// alert(uids);
	if (uids.length == 0) {
			Swal.fire({
			  icon: 'error',
			  text: "삭제할 글을 체크해 주세여"
			})
	} else {
		Swal.fire({
			  title: '공지 삭제',
			  text: uids.length + "개의 글을 삭제하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#6D80CC',
			  cancelButtonColor: '#F3C458',
			  confirmButtonText: '삭제',
			cancelButtonText : '취소'
			}).then((result) => {
			  if (result.value) {
		var data = $('#frmList').serialize();
		// uid=1010&uid=1111

		$.ajax({
			url : path+'/notice/delete.ajax',
			type : "POST",
			data : data,
			cache : false,
			success : function(data, status) {
				if (status == "success") {
					if (data.status == "OK") {
						Swal.fire({
							  icon: 'success',
							  title: '공지 삭제 성공',
							  text: data.count + "개의 공지가 삭제 되었습니다." 
							})
						boardRord();
					} else {
						Swal.fire({
							  icon: 'error',
							  title: '공지 삭제 실패',
							  text: ""+ data.message
							})
					}
				}
			}
		});
		  
	  }
	})
	}

}// end chkDelete()

// 현재 글 목록 list에 대해 이벤트 등록
function addViewEvent() {
	$('#tlc tbody').on('click','td span.subject',function(){
				//alert($(this).text() + " : " + $(this).attr('data-uid')); //
				// 확인용

				// 읽어오기
				$.ajax({
							url : path+"/notice/view.ajax?uid=" + $(this).attr('data-uid'),
							type : "GET",
							cache : false,
							success : function(data, status) {
								if (status == "success") {
									if (data.status == "OK") {
										// 읽어온 view 데이터를 전역변수에 세팅
										viewItem = data.data[0]; 
										//alert(viewItem.uid + " : " + viewItem.department+ " : " + viewItem.position + " : " + viewItem.content);
										// 팝업에 보여주기
										setPopup("view");
										$("#dlg_write").show();
									} else {
										Swal.fire({
											  icon: 'error',
											  title: '공지 읽기 실패',
											  text: ""+ data.message
											})
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
		// 부서
		$("#dlg_write input:radio[name='dep_uid']").removeAttr('disabled').css("display", "inline-block");
		$("#dlg_write input:radio[name='dep_uid']").parents("label").css("display", "inline-block");
		
		//직책		
		$("#dlg_write input:radio[name='p_uid']").removeAttr('disabled').css("display", "inline-block");
		$("#dlg_write input:radio[name='p_uid']").parents("label").css("display", "inline-block");
		$("#dlg_write #chk").text("");	
		// 날짜
		$("#dlg_write #reg b").text("");
		$("#dlg_write #regdate").text("");
		
		$("#dlg_write input[name='subject']").attr("readonly", false);
		
		CKEDITOR.instances.editor.setData("");
		editor.setReadOnly(false);
		
		$("#dlg_write textarea[name='content']").attr("readonly", false);
	}

	// 글 읽기
	if (mode == 'view') {

		$('#frmWrite')[0].reset(); // from 안의 기존 내용 reset
		$("#dlg_write .title").text('공지 보기');
		$('#dlg_write .btn_group_header').show();
		$('#dlg_write .btn_group_write').hide();
		$('#dlg_write .btn_group_view').show();
		$('#dlg_write .btn_group_update').hide();
		// 부서
		$("#dlg_write input:radio[name='dep_uid']").attr('disabled', 'true').css("display", "none");
		$("#dlg_write input:radio[name='dep_uid']").parents("label").css("display", "none");
		$("#dlg_write input:radio[name='dep_uid'][value='"+viewItem.department +"']").parents("label").css({"display":"inline-block"});
		$("#dlg_write input:radio[name='dep_uid'][value='"+viewItem.department +"']").prop('checked', true); // 선택하기
		//직책
		//$("#dlg_write input:radio[name='p_uid']").attr('disabled', 'true').parents("label").css("display", "none");
		$("#dlg_write input:radio[name='p_uid']").attr('disabled', 'true').css("display", "none");
		$("#dlg_write input:radio[name='p_uid']").parents("label").css("display", "none");
		$("#dlg_write input:radio[name='p_uid'][value='"+viewItem.position +"']").removeAttr('disabled').parents("label").css("display", "inline-block");
		$("#dlg_write input:radio[name='p_uid'][value='"+viewItem.position +"']").prop('checked', true); // 선택하기
	
		// 날짜
		$("#dlg_write #reg b").text("날짜");
		$("#dlg_write #regdate").text(viewItem.regdate);
		$("#dlg_write input[name='uid']").val(viewItem.uid); // 나중에 삭제/수정을 위해
																// 필요
		$("#dlg_write #chk").text("");	
		$("#dlg_write input[name='subject']").val(viewItem.subject);
		$("#dlg_write input[name='subject']").attr("readonly", true);

		CKEDITOR.instances.editor.setData(viewItem.content);
		editor.setReadOnly();
		$("#dlg_write textarea[name='content']").attr("readonly", true);
		

	}

	// 글 수정
	if (mode == 'update') {
		
		$("#dlg_write .title").text('공지 수정');
		$('#dlg_write .btn_group_header').show();
		$('#dlg_write .btn_group_write').hide();
		$('#dlg_write .btn_group_view').hide();
		$('#dlg_write .btn_group_update').show();
		
		// 부서
		$("#dlg_write input:radio[name='dep_uid']").removeAttr('disabled').css("display", "inline-block");
		$("#dlg_write input:radio[name='dep_uid']").parents("label").css("display", "inline-block");
		
		//직책		
		$("#dlg_write input:radio[name='p_uid']").removeAttr('disabled').css("display", "inline-block");
		$("#dlg_write input:radio[name='p_uid']").parents("label").css("display", "inline-block");
	
		// 날짜
		$("#dlg_write #reg b").text("날짜");
		$("#dlg_write #regdate").text(viewItem.regdate);
		$("#dlg_write input[name='uid']").val(viewItem.uid); // 나중에 삭제/수정을 위해
		
		$("#dlg_write #chk").text("");												// 필요

		$("#dlg_write input[name='subject']").val(viewItem.subject);
		$("#dlg_write input[name='subject']").attr("readonly", false);

		CKEDITOR.instances.editor.setData(viewItem.content);
		editor.setReadOnly(false);
		$("#dlg_write textarea[name='content']").attr("readonly", false);
		
	}
}// end setPopup()

// 특정 uid 의 글 삭제하기
function deleteUid(uid) {
	
	$.ajaxSetup({
        beforeSend: function(xhr) {
        	xhr.setRequestHeader(header, token);
        }
    });
	
	Swal.fire({
		  title: '공지 삭제',
		  text: uid + "번 글을 삭제 하시겠습니까?",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#6D80CC',
		  cancelButtonColor: '#F3C458',
		  confirmButtonText: '삭제',
		cancelButtonText : '취소'
		}).then((result) => {
		  if (result.value) {
		   
	// POST 방식
	$.ajax({
		url : path+"/notice/delete.ajax",
		type : "POST",
		data : "uid=" + uid,
		cache : false,
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					//xhr.setRequestHeader(header, token);
					Swal.fire({
						  icon: 'success',
						  title: '공지 삭제 성공',
						  text: data.count + "개의 공지가 삭제 되었습니다." 
						})
					boardRord();
				} else {
					Swal.fire({
						  icon: 'error',
						  title: '공지 삭제 실패',
						  text: ""+ data.message
						})
					return false;
				}
			}
		}
	});
		  }
		})
	return true;
}// end deleteUid

// 글 수정
function chkUpdate() {
	
	CKEDITOR.instances.editor.updateElement(); //ckeditor 에서 쓴글을 가져올때 사용 
	var data = $("#frmWrite").serialize();

	$.ajax({
		url :path+"/notice/update.ajax",
		type : "POST",
		cache : false,
		data : data,
		success : function(data, status) {
			if (status == "success") {
				if (data.status == "OK") {
					Swal.fire({
						  icon: 'success',
						  title: '공지 수정 성공',
						  text: data.count + "개의 공지가 수정 되었습니다." 
						})
					boardRord();
				} else {
					Swal.fire({
						  icon: 'error',
						  title: '공지 수정 실패',
						  text: ""+ data.message
						})

				}
				$("#dlg_write").hide(); // 현재 팝업닫기
			}
		}
	});

}// end chkUpdate()

function chkSubmit() {
	frm = document.forms["frmWrite"];
	var subject = frm["subject"].value.trim();
	var chk = document.getElementById("chk");    
	chk.innerHTML = "";
	if(subject == ""){
		chk.innerHTML = "제목 쓰라";
		frm["subject"].focus();
		
	}
	alert("하이");
	alert($('#editor').val());
	
	if(CKEDITOR.instances.editor.getData() == '' || CKEDITOR.instances.editor.getData().length ==0){
		chk.innerHTML = "내용 쓰라";
		frm["content"].focus();
		alert("dhormfo");
	}
	
}