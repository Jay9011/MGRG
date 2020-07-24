$(document).ready(function(){
	loadPage();
	
	let table = $('#staff_list').DataTable();
	$('#staff_list tbody').on('click','tr',function(e){
		let cell = $(e.target).closest('td');
		if(cell.index() > 0){
			let data = table.row(this).data();
//			alert(data.uid + ' 클릭함.');
			$('#viewStaff').modal('show');
		} else {
			
		}
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
			url: path + '/staff/list.json',
			dataSrc: 'data'
		}
		,columns:[
			{data: 'uid'
				,'render' :  function ( data, type, full, meta ) {
					n_uid = data;
	                return '<input type="checkbox" name="uid" value='+data+ '>'
	        }},
			{data: 'name'},
			{data: 'position'},
			{data: 'phonenum'},
			{data: 'email'},
			{data: 'address'},
			{data: 'birthday'},
			{data: 'leftHoliday'}
		]
		,columnDefs:[
			{targets: 0,
				orderable: false}
		]
	});
}

var themeObj = {
   searchBgColor: "#7386D5", //검색창 배경색
   queryTextColor: "#FFFFFF" //검색창 글자색
};

function DaumAddr(){
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
            document.getElementById("addrZoneCode").value = data.zonecode;
            document.getElementById("addrRoad").value = roadAddr + extraRoadAddr;
	    },
	    theme: themeObj
	}).open({
	    left: (window.screen.width / 2) - (width / 2)
	    ,top: (window.screen.height / 2) - (height / 2)
	    ,popupName: 'postcodePopup' //팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
	});
}