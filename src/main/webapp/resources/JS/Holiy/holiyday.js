/**
 * 
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var start;
var del;
var up;
var indate ;
var date = new Date();
var year = date.getFullYear();
var month = date.getMonth()+1
var day = date.getDate();
var day1 = new Date().setDate(date.getDate() + 1);
if(month < 10){
    month = "0"+month;
}
if(day < 10){
    day = "0"+day;
}

var today = year+""+month+""+day;
today = parseInt(today);

var today1 = new Date();
today1.setDate(today1.getDate() + 1);
var today1Year = today1.getFullYear();
var today1Month = today1.getMonth()+1
var today1Day = today1.getDate();
if(today1Month < 10){
	today1Month = "0" + today1Month;
}
if(today1Day < 10){
	today1Day = "0" + today1Day;
}
today1 = today1Year + "-" + today1Month + "-" + today1Day;

$(function() {
	
	loadtable();
	
	$('#datetimepicker1').datetimepicker({
		format : 'YYYY-MM-DD',
		useCurrent : false,
		minDate : today1,
		daysOfWeekDisabled : [ 0, 6 ]
	});
	$('#datetimepicker2').datetimepicker({
		format : 'YYYY-MM-DD',
		useCurrent : false,
		minDate : today1,
		daysOfWeekDisabled : [ 0, 6 ]
	});
	$("#datetimepicker1").on("change.datetimepicker", function(e) {
		if(new Date(e.date) < new Date($('#datetimepicker2').find("input").val())){
			$('#datetimepicker2').datetimepicker('minDate', e.date);
			$('#datetimepicker2').datetimepicker('date', e.date);
			maxDateSetting(e);
		} else {
			maxDateSetting(e);
			$('#datetimepicker2').datetimepicker('minDate', e.date);
			$('#datetimepicker2').datetimepicker('date', e.date);
		}

	});
	
	$('#addHoliday').on('click', function(){
		addHoliday();
	});
	
	setSelectOptionDepartment();
	setSelectOptionPosition();
	selectedOption()
	
	$('#s_department').change(function(){
		selectedOption();
	});
	$('#s_position').change(function(){
		selectedOption();
	});
	$('#s_staff').change(function(){
		initDateSetting();
	});
	
	
});

function initDateSetting(){
	maxDateSetting();
	$('#datetimepicker1').datetimepicker('maxDate', false);
}

function maxDateSetting(e){
	var leftHoliday = $('#s_staff').find('option:selected').data('sub');
	var selectedDay;
	var tempDay;
	var maxDay;
	var addWeekend = 0;
	if(e != null) {
		selectedDay = new Date(e.date);
	} else {
		selectedDay = new Date();
	}
	tempDay = new Date(selectedDay);
	maxDay = new Date(selectedDay);
	maxDay.setDate(maxDay.getDate() + leftHoliday - 1);
	for(var i = 0; tempDay <= maxDay; i++){
		var DayOfWeek = tempDay.getDay();
		if(DayOfWeek == 0 || DayOfWeek == 6){
			addWeekend++;
			maxDay.setDate(maxDay.getDate() + 1);
		}
		tempDay.setDate(tempDay.getDate() + 1);
	}
	$('#datetimepicker2').datetimepicker('maxDate', maxDay);
}

function addHoliday(){
	var startDay = $('div.form-group input[name=startTime]').val();
	var endDay = $('div.form-group input[name=endTime]').val();
	var emp_uid = $('#s_staff').val();
	
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
		url : path + '/holiy/addHoliday',
		type : 'POST',
		cache : false,
		data : {
			startDay : startDay,
			endDay : endDay,
			emp_uid : emp_uid
		},
		success : function(data, status){
			$('body').loadingModal('hide');
			if(status == 'success'){
				if(data.status == "OK"){
					$('#holiday').DataTable().ajax.reload().columns.adjust();
					selectedOption();
					initDateSetting();
				} else if(data.status == "FAIL") {
					Swal.fire({
						  icon: 'error',
						  title: '일정 추가를 실패했습니다.',
						  text: data.message
						});
				}
			} else {
				
			}
		} 
	});
}

function loadtable() {
//alert(today);
	$('#holiday').DataTable({
		ajax : {
			url : path + "/holiy/Hlist.hol",
			dataSrc : function(data) {
					
				fulldata = data.data;
				
				return data.data;
			}},
			columns : [
				{data : "name"},
				{data : "department"},
				{data : "position"},
				{data : "startTime"},
				{data : "endTime"},
				{data: 'phonenum'
				,'render' : function (data, type, full, meta){
					if(data == 0 || data == null) {
						return '없음';
					} else {
						let telNum = '' + data;
						let formatNum = '';

						if(telNum.length == 8){
							formatNum = telNum.replace(/(\d{4})(\d{4})/, '$1-$2');
						} else if(telNum.length == 10){
							formatNum = telNum.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
							formatNum = '0' + formatNum;
						} else {
							if(telNum.indexOf('2') == 0){
								formatNum = telNum.replace(/(\d{1})(\d{4})(\d{4})/, '$1-$2-$3');
								formatNum = '0' + formatNum;
							} else {
								formatNum = telNum.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
								formatNum = '0' + formatNum;
							}
						}

						return formatNum;
					}
					if(data == 0 || data == null) return '없음';
					else return '0' + data;
				}},
				{
					data : "uid",
					"render" : function(data, type, full, meta) {
			if(today ==  parseInt(full.startTime.replace(/-/gi,"")) || today >= parseInt(full.startTime.replace(/-/gi,""))){
					return ''
				}else{
					return '<button type="button" class="btn delBtn Hdel" value="'+ full.startTime + '" onclick="return Hdel('+ full.uid+', \'' + full.name+ '\');">삭제</button>'
					
				}}}
			],
			columnDefs : [
		        
		         {
		        	 targets : 6,
		        	 orderable : false
		         }
		         
		        ],
		        order : [ [ 3, 'desc' ] ], 
		        info : false,
				language : {
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

function  Hdel(uid, name) {// Hdel(name)
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	Swal.fire({
	  title: '휴가 삭제',
	  text: name + "님의 휴가를 삭제하시겠습니까?",
	  icon: 'warning',
	  showCancelButton: true,
	  confirmButtonColor: '#6D80CC',
	  cancelButtonColor: '#F3C458',
	  confirmButtonText: '삭제',
	  cancelButtonText : '취소'
	}).then((result) => {
	  if (result.value) {
		  $.ajax({
			  url : path+ "/holiy/Hdel.hol",
			  type : "POST",
			  data : "uid="+uid,
			  cache : false,
			  success : function(data, status) {
				  if (status == "success") {
					  if (data.status == "OK") {
						  Swal.fire({
							  icon: 'success',
							  title: '휴가 삭제 성공',
							  text: name +  data.message
							})
							// table 수정
							$('#holiday').DataTable().ajax.reload();
					  }else{
						  Swal.fire({
							  icon: 'error',
							  title: '휴가  삭제 실패',
							  text: name + data.message
							})
						return false;
					  }
				  }
			}
		  })
	  }
	})
}



function setSelectOptionDepartment(){
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		url : path + '/holiy/setSelectOptionDepartment',
		type : 'POST',
		cache : false,
		success : function(data, status){
			if(status == 'success'){
				$('#s_department').html('<option value="0" selected="selected">부서 전체</option>');
				for (var i = 0; i < data.length; i++) {
					$('#s_department').append('<option value="' + data[i].dep_uid + '">' + data[i].dep_name + '</option')
				}
			} else {
			}
		} 
	});
}
function setSelectOptionPosition(){
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		url : path + '/holiy/setSelectOptionPosition',
		type : 'POST',
		cache : false,
		success : function(data, status){
			if(status == 'success'){
				$('#s_position').html('<option value="0" selected="selected">직책 전체</option>');
				for (var i = 0; i < data.length; i++) {
					$('#s_position').append('<option value="' + data[i].p_uid + '">' + data[i].p_name + '</option')
				}
			} else {
			}
		} 
	});
}
function selectedOption(){
	let dep_uid = $('#s_department').val();
	let p_uid = $('#s_position').val();
	
	$.ajaxSetup({
		beforeSend: function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});
	
	$.ajax({
		url : path + '/holiy/setSelectOptionStaff',
		type : 'POST',
		cache : false,
		data : {
			dep_uid : dep_uid,
			p_uid : p_uid
		},
		success : function(data, status){
			if(status == 'success'){
				if(data.length > 0) {
					$('#s_staff').html('');
					for (var i = 0; i < data.length; i++) {
						$('#s_staff').append('<option value="' + data[i].uid + '" data-sub="' + data[i].leftHoliday + '">' + data[i].name + ' (' + data[i].leftHoliday + '/' + data[i].total + ')</option>');
						maxDateSetting();
					}
				} else {
					$('#s_staff').html('<option value="0">직원 없음</option>');
				}
			} else {
			}
		} 
	});
}

