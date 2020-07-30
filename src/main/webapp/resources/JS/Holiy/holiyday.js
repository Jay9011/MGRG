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
if(month < 10){
    month = "0"+month;
}
if(day < 10){
    day = "0"+day;
}

var today = year+""+month+""+day;
var today1 =  year+"-"+month+"-"+(day+1);
 today = parseInt(today);
$(function() {
	
	loadtable();
	 changeinput();
	
	$('#datetimepicker1').datetimepicker({
		format : 'YYYY-MM-DD',
		minDate : date.setDate(date.getDate() + 1),
		daysOfWeekDisabled : [ 0, 6 ]
	});
	$('#datetimepicker2').datetimepicker({
		format : 'YYYY-MM-DD',
		useCurrent : false,
		minDate : date.setDate(date.getDate() + 1),
		daysOfWeekDisabled : [ 0, 6 ]
	});
	$("#datetimepicker1").on("change.datetimepicker", function(e) {
		$('#datetimepicker2').datetimepicker('minDate', e.date);
	
	});
	$("#datetimepicker2").on("change.datetimepicker", function(e) {
		$('#datetimepicker1').datetimepicker('maxDate', e.date);
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
	
	
});

function addHoliday(){
	var startDay = $('div.form-group input[name=startTime]').val();
	var endDay = $('div.form-group input[name=endTime]').val();
	var emp_uid = $('#s_staff').val();
	
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
			if(status == 'success'){
				if(data.status == "OK"){
					$('#holiday').DataTable().ajax.reload().columns.adjust();
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
				{data : "startTime",
					"render" : function(data, type, full, meta) {
						start = data;
					return '<span class="spanno">'+data+'</span><input type="date" class="datapik" name="startTime" data-uid ="'+ full.uid+'"  min="'+ today1 +'" value='+ data + ' readonly>'}},
					{data : "endTime",
						render : function(data, type, full, meta){
							return '<span class="spanno">'+data+'</span><input type="date" class="datapik" name="endTime" data-uid1 ="'+ full.uid+'" min="'+ full.startTime +'" value='+ data + ' readonly>'
						}},
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
								return '<button type="button" style="display:none;"  value='+ full.startTime + ' disabled>삭제</button>'
							}else{
								return '<button type="button" class="btn btncol Hdel" value="'+ full.startTime + '" onclick="return Hdel('+ full.uid+', \'' + full.name+ '\');">삭제</button><button type="button" class="btn btncol Hup" style="display:none" value="'+ full.startTime + '" onclick="return Hup('+ full.uid+', \'' + full.name+ '\');">수정</button>'
								
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

function changeinput() {
	$('#holiday tbody').on('dblclick', 'tr',function() {
		del = $(this).find('.Hdel');
		up = $(this).find('.Hup');
		if(del.length == 1){
		indate = $(this).find('input[type=date]');
		del.css('display','none');
		up.css('display','block');
		indate.attr("readonly",false);
		}else{
			Swal.fire({
				  icon: 'error',
				  text: "수정하실 수 없는 휴가 입니다."
				})
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



function Hup(uid, name) {
	alert("up"+ uid + " : "+ name +$(this) );
	
	
	del.css('display','block');
	up.css('display','none');
	indate.attr("readonly",true);
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
						$('#s_staff').append('<option value="' + data[i].uid + '">' + data[i].name + ' (' + data[i].leftHoliday + '/' + data[i].total + ')</option>');
					}
				} else {
					$('#s_staff').html('<option value="0">직원 없음</option>');
				}
			} else {
			}
		} 
	});
}

