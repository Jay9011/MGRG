var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(document).ready(function(){
	
	loadPage();
	
	let table = $('#staff_list').DataTable();

	table.on('click','input[type=checkbox]',function(e){
		if ($(this).is(":checked")){
			$(this).prop("checked", false);
		} else {
			$(this).prop("checked", true);
		}
	});
	
	$('#staff_list tbody').on('click','tr',function(e){
		let cell = $(e.target).closest('td');
		if(cell.index() > 0){
			let data = table.row(this).data();
			let thisModal = $('#viewStaff');
			setStaffFrom(thisModal, data);
			thisModal.modal('show');
		} else {
			let checkbox = $(this).find('input[type=checkbox]');
			if (checkbox.is(":checked")){
				checkbox.prop("checked", false);
			} else {
				checkbox.prop("checked", true);
			}
		}
	});
	
	$('#btnWrite').on('click', function(){
		$('#writeStaff').modal('show');
	});

	$('.password svg').on('click',function() {
		$('input').toggleClass('active');
		if($('input').hasClass('active')) {
			$(this).html('<path d="M10.79 12.912l-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7.029 7.029 0 0 0 2.79-.588zM5.21 3.088A7.028 7.028 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474L5.21 3.089z"/><path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829l-2.83-2.829zm4.95.708l-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829z"/><path fill-rule="evenodd" d="M13.646 14.354l-12-12 .708-.708 12 12-.708.708z"/>')
			.attr('class', 'bi bi-eye-slash-fill')
			.prev('input').attr('type', 'text');
		}else{
			$(this).html('<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>')
			.attr('class', 'bi bi-eye-fill')
			.prev('input').attr('type', 'password');
		}
	});
	
	// writeStaff 모달이 hide 가 호출 되었을 때,
	$('#writeStaff').on('hidden.bs.modal', function(e){
		initStaffForm($(this));
	});
	
	// viewStaff 모달이 hide 가 호출 되었을 때,
	$('#viewStaff').on('hidden.bs.modal', function(e){
		initStaffForm($(this));
	});
	
	// viewStaff 모달 기본 설정
	initViewStaff();
	
	$('button.addBtn').on('click', function(){
//		$(this).parents('.modal').hide();
		if(validationChk()){
			chkAdd();
		}
	});
	
	$('button.modiBtn').on('click', function(){
		modiOk();
	});
	
	$('button#btnDelete').on('click', function(){
		deleteOk();
	});
	
	$('[data-toggle="tooltip"]').tooltip();
});

function loadPage(){
	$('#staff_list').DataTable({
		order:[[1, 'asc']]
		,language:{
			info:'검색된 사원 수 _TOTAL_ 명',
			infoFiltered:'(총 사원수 _MAX_ 명)',
			lengthMenu:'최대 _MENU_명씩 보기',
			search:'검색 : ',
			infoEmpty:'검색된 사원 수 0 명',
			zeroRecords:'검색 된 사원이 없습니다.',
			paginate:{
				first:'<<',
				last:'>>',
				previous:'<',
				next:'>'
			}
		}
		,scrollX:true
		,autoWidth:true
		,ajax:{
			url: path + '/staff/list',
			dataSrc: 'data'
		}
		,columns:[
			{data: 'uid'
				,'render' :  function ( data, type, full, meta ) {
	                return '<input type="checkbox" name="uid" value='+data+ '>'
	        }},
			{data: 'name'},
			{data: 'position'},
			{data: 'phonenum'
				,'render' : function (data, type, full, meta){
					return numberFormatting(data);
				}},
			{data: 'email'},
			{data: 'leftHoliday'
				,'render' : function(data, type, full, meta){
					return full.leftHoliday + ' / ' + full.total + '<span style="margin-right:15px"></span>';
				}},
			{data: 'birthday'
				,'render' : function (data, type, full, meta){
					return DateToString(data) + '<span style="margin-right:15px"></span>';
				}},
			{data: 'address'}
		]
		,columnDefs:[
			{targets: 0, orderable: false},
			{targets: 1
				,className: 'dt-body-center'},
			{targets: 2
				,className: 'dt-body-center'},
			{targets: 3
				,className: 'dt-body-center'},
			{targets: 4
				,className: 'dt-body-center'},
			{targets: 5
				,className: 'dt-body-right'},
			{targets: 6
				,className: 'dt-body-right'}
		]
		,fixedColumns: {
			leftColumns: 3
		}
	}).columns.adjust();
}

var themeObj = {
   searchBgColor: "#7386D5", //검색창 배경색
   queryTextColor: "#FFFFFF" //검색창 글자색
};

function DaumAddr(btn){
	var width = 500; //팝업의 너비
	var height = 600; //팝업의 높이
	new daum.Postcode({
	    oncomplete: function(data) {
	        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	    	var roadAddr = data.roadAddress; // 도로명 주소 변수
	    	var extraRoadAddr = ''; // 참고 항목 변수
	    	// 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $(btn).parents(".addBody").find("#addrZoneCode").val(data.zonecode);
            $(btn).parents(".addBody").find("#addrRoad").val(roadAddr + extraRoadAddr);
	    },
	    theme: themeObj
	}).open({
	    left: (window.screen.width / 2) - (width / 2)
	    ,top: (window.screen.height / 2) - (height / 2)
	    ,popupName: 'postcodePopup' //팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
	});
}

function chkAdd(){
	var timeStampBirthday = $('#writeStaff #staff_birthday').val();
	timeStampBirthday = moment(new Date(timeStampBirthday)).format('YYYY-MM-DD HH:mm:ss');
	var timeStampHiredate = $('#writeStaff #staff_hiredate').val();
	timeStampHiredate = moment(new Date(timeStampHiredate)).format('YYYY-MM-DD HH:mm:ss');
	
	var data = $('#addStaff').serializeArray();
	data = changeSerialize(data, 'birthday', timeStampBirthday);
	data = changeSerialize(data, 'hiredate', timeStampHiredate);
	
	$('body').loadingModal({
		position:'auto',
		text:'',
		color:'#fff',
		opacity:'0.7',
		backgroundColor:'rgb(0,0,0)',
		animation:'cubeGrid'
	});
	
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		url : path + '/staff/addStaff',
		type : 'POST',
		cache : false,
		data : data,
		success : function(data, status){
			$('body').loadingModal('destroy');
			if(status == 'success'){
				$('#staff_list').DataTable().ajax.reload().columns.adjust();
				$('#writeStaff').modal('hide');
				$('#toast #toast_img').html('<img src="' + path + '/resources/Img/smile.svg">');
				$('#toast #toast_message').text(data.message);
				launch_toast();
			} else {
				
			}
		} 
	});
}

function modiOk(){
	var timeStampBirthday = $('#modiStaff #staff_birthday').val();
	timeStampBirthday = moment(new Date(timeStampBirthday)).format('YYYY-MM-DD HH:mm:ss');
	var timeStampHiredate = $('#modiStaff #staff_hiredate').val();
	timeStampHiredate = moment(new Date(timeStampHiredate)).format('YYYY-MM-DD HH:mm:ss');
	
	var data = $('#modiStaff').serializeArray();
	data = changeSerialize(data, 'birthday', timeStampBirthday);
	data = changeSerialize(data, 'hiredate', timeStampHiredate);
	
	$('body').loadingModal({
		position:'auto',
		text:'',
		color:'#fff',
		opacity:'0.7',
		backgroundColor:'rgb(0,0,0)',
		animation:'cubeGrid'
	});
	
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		url : path + '/staff/modiStaff',
		type : 'POST',
		cache : false,
		data : data,
		success : function(data, status){
			$('body').loadingModal('destroy');
			if(status == 'success'){
				switch(data.status){
				case 'Err_Common' :
				case 'Err_Nm' :
				case 'Err_Em' :
				case 'Err_Pn' :
					Swal.fire({
						  icon: 'error',
						  title: '저장 실패',
						  text: data.message
						})
					break;
				case 'OK' :
					$('#staff_list').DataTable().ajax.reload().columns.adjust();
					$('#viewStaff').modal('hide');
					$('#toast #toast_img').html('<img src="' + path + '/resources/Img/smile.svg">');
					$('#toast #toast_message').text(data.message);
					launch_toast();
					break;
				}
			} else {
				
			}
		},
		error : function(xhr, ajaxSettings, thrownError){
			$('body').loadingModal('destroy');
			Swal.fire({
			  icon: 'error',
			  title: '연결 실패',
			  text: '서버에 연결을 실패했습니다. 다시 시도해 주세요.',
			  showCancelButton: false,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인'
			}).then((result) => {
			  if (result.value) {
				  location.reload();
			  }
			});
	   }
	});
}

function deleteOk(){
	var uids = []	// 빈 배열 준비
	$("tbody input[name=uid]").each(function(){
		if($(this).is(":checked")){	// JQuery 에서 check 여부 확인방법
			uids.push($(this).val());	// 배열에 uid 값 추가
		}
	});
	
	if(uids.length == 0){
		Swal.fire({
			  icon: 'error',
			  text: "삭제할 직원을 선택해 주세요"
			})
	} else {
		
			Swal.fire({
				  title: '직원 삭제',
				  text: uids.length + "명의 직원 정보를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#6D80CC',
				  cancelButtonColor: '#F3C458',
				  confirmButtonText: '삭제',
				cancelButtonText : '취소'
				}).then((result) => {
				  if (result.value) {
					  $('body').loadingModal({
							position:'auto',
							text:'',
							color:'#fff',
							opacity:'0.7',
							backgroundColor:'rgb(0,0,0)',
							animation:'cubeGrid'
						});
					  
			$.ajaxSetup({
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header, token);
				}
			}); // end ajaxSetup
			
			$.ajax({
				url : path + '/staff/deleteStaff',
				type : 'POST',
				cache : false,
				data : {
					'uids' : uids
				},
				success : function(data, status){
					$('body').loadingModal('destroy');
					if(status == 'success'){
						$('#staff_list').DataTable().ajax.reload();
						$('#toast #toast_img').html('<img src="' + path + '/resources/Img/smile.svg">');
						$('#toast #toast_message').text(data.message);
						launch_toast();
					} else {
						
					}
				} 
			}); // end ajax
				  }
				}) // end Swal
	} // end if(uids.length)
} // end deleteOk()

function initStaffForm(modal){
	modal.find('input[class=editForm]').val('');
	modal.find('#staff_department option:eq(0)').prop('selected', true);
	modal.find('#staff_position option:eq(0)').prop('selected', true);
	modal.find('form span').html('');
}

function initViewStaff(){
	$('#viewStaff #staff_birthday').css('display', 'none');
	$('#viewStaff #staff_hiredate').css('display', 'none');
	$('#viewStaff #staff_salary').css('display', 'none');
	$('#viewStaff #staff_phone').css('display', 'none');
	
	$('#viewStaff span.birthday').on('click', function(e){
		displayOnClickInit($(this));
	});
	$('#viewStaff #staff_birthday').blur(function(e){
		displayBlurInit($(this));
	});
	$('#viewStaff span.hiredate').on('click', function(e){
		displayOnClickInit($(this));
	});
	$('#viewStaff #staff_hiredate').blur(function(e){
		displayBlurInit($(this));
	});
	$('#viewStaff span.salary').on('click', function(e){
		displayOnClickInit($(this));
	});
	$('#viewStaff #staff_salary').blur(function(e){
		displayBlurInit($(this));
	});
	$('#viewStaff span.phonenum').on('click', function(e){
		displayOnClickInit($(this));
	});
	$('#viewStaff #staff_phone').blur(function(e){
		displayBlurInit($(this));
	});
	$('#viewStaff #addrBtn').css('display', 'none');
	$('#viewStaff .addBody').hover(
	function(){
		$(this).find('#addrBtn').css('display', 'block');
		$(this).find('#addrDetail').css('border-bottom', '1px solid #a9adb9');
	}
	,function(){
		$(this).find('#addrBtn').css('display', 'none');
		if(!$(this).find('#addrDetail').is(':focus')){
			$(this).find('#addrDetail').css('border', 'none');
		}
	});
	
	$('#viewStaff .addBody #addrDetail').on('focus', function(){
		$(this).css({
			'border-bottom': '1px solid #a9adb9'
		});
	});

	$('#viewStaff .addBody #addrDetail').on('blur', function(){
		$(this).css({
			'border': 'none'
		});
	});
}

function displayOnClickInit(init){
	init.css('display', 'none');
	init.siblings('input[class^=editForm]').css('display', 'block');
	init.siblings('input[class^=editForm]').focus();
}

function displayBlurInit(init){
	init.siblings('span.showText').text(numberFormatting(init.val()));
	init.siblings('span').css('display', 'block');
	init.css('display', 'none');
}

function setStaffFrom(thisModal, data){
	let form = thisModal.find('form');
	let hiredate = DateToString(data.hiredate);
	let birthday = DateToString(data.birthday);
	form.find('input[name=uid]').val(data.uid);
	form.find('input[name=name]').val(data.name);
	form.find('span.birthday').text(birthday);
	form.find('input[name=birthday]').val(birthday);
	form.find('span.phonenum').text(numberFormatting(data.phonenum));
	form.find('input[name=phonenum]').val(data.phonenum);
	form.find('input[name=email]').val(data.email);
	form.find('input[name=id]').val(data.id);
	form.find('input[name=addrZoneCode]').val(data.addrZoneCode);
	form.find('input[name=addrRoad]').val(data.addrRoad);
	form.find('input[name=addrDetail]').val(data.addrDetail);
	form.find('span.hiredate').text(hiredate);
	form.find('input[name=hiredate]').val(hiredate);
	form.find('span.salary').text(data.salary);
	form.find('input[name=salary]').val(data.salary);
	form.find('#staff_department').val(data.dep_uid).prop("selected", true);;
	form.find('#staff_position').val(data.p_uid).prop("selected", true);;
}

function DateToString(date){
	var originalDate = new Date(date);
	
	var year= originalDate.getFullYear();
	var mon = (originalDate.getMonth()+1)>9 ? ''+(originalDate.getMonth()+1) : '0'+(originalDate.getMonth()+1);
	var day = originalDate.getDate()>9 ? ''+originalDate.getDate() : '0'+originalDate.getDate();
	        
	var StringDate = year + '-' + mon + '-' + day;

	return StringDate;
}

function changeSerialize( values, k, v ) {
	var found = false;
	for (i = 0; i < values.length && !found; i++) {
		if ( values[i].name == k ) { 
			values[i].value = v;
			found = true;
		}
	}
	if (!found) {
		values.push({
			name: k,
			value: v
		});
	}
	return values;
}

function numberFormatting(data){
	let telNum = '' + data;
	
	if(data == 0 || data == null) {
		return '없음';
	} else {
		let formatNum = '';
		if(telNum.indexOf('0') == 0){
			if(telNum.length == 11 || telNum.length == 10 || telNum.length == 9){
				telNum = telNum.substring(1, telNum.length);
			}
		}
		if(telNum.length == 8 && telNum.indexOf('2') != 0){
			formatNum = telNum.replace(/(\d{4})(\d{4})/, '$1-$2');
			return formatNum;
		} else if(telNum.length == 10){
			formatNum = telNum.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
			formatNum = '0' + formatNum;
			return formatNum;
		} else {
			if(telNum.indexOf('2') == 0 && telNum.length == 9){
				formatNum = telNum.replace(/(\d{1})(\d{4})(\d{4})/, '$1-$2-$3');
				formatNum = '0' + formatNum;
				return formatNum;
			} else if(telNum.indexOf('2') == 0 && telNum.length == 8){
				formatNum = telNum.replace(/(\d{1})(\d{3})(\d{4})/, '$1-$2-$3');
				formatNum = '0' + formatNum;
				return formatNum;
			} else {
				formatNum = telNum.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
				formatNum = '0' + formatNum;
				return formatNum;
			}
		}
		return data;
	}
}