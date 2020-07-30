/**
 * 
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(function() {
	
	loadtable();
	
	
	$('#datetimepicker1').datetimepicker({
		format : 'YYYY-MM-DD',
		minDate : new Date(),
		daysOfWeekDisabled : [ 0, 6 ]
	});
	$('#datetimepicker2').datetimepicker({
		format : 'YYYY-MM-DD',
		useCurrent : false,
		minDate : new Date(),
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
	
	
	
	
	
	
});

function addHoliday(){
	var startDay = $('div.form-group input[name=startTime]').val();
	var endDay = $('div.form-group input[name=endTime]').val();
	
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
			endDay : endDay
		},
		success : function(data, status){
			if(status == 'success'){
			} else {
				
			}
		} 
	});
}
var start;
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
 today = parseInt(today);

function loadtable() {
//alert(today);
	$('#holiday').DataTable({
		ajax : {
			url : path + "/holiy/Hlist.hol",
			dataSrc : 'data'},
			columns : [{
				data : "uid",
				"render" : function(data, type, full, meta) {
					return '<input type="radio" name="uid" value='+ data + '>'}},
				{data : "name"},
				{data : "department"},
				{data : "position"},
				{data : "startTime",
					"render" : function(data, type, full, meta) {
						start = data;
					return '<input type="date" class="datapik" name="startTime" value='+ data + '>'}},
				{data : "endTime",
						render : function(data, type, full, meta){
							return '<input type="date" class="datapik" name="endTime" value='+ data + '>'
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
					return '<button type="button" style="display:none;" name="uid" value='+ full.startTime + ' disabled>삭제</button>'
								
							}else{
								return '<button type="button"  class="btn btncol"  id="Hdel" value='+ full.startTime + '>삭제</button>'
							}}}
			],
			columnDefs : [
		         {
		        	 targets : 0,
		        	 orderable : false
		         },
		         {
		        	 targets : 7,
		        	 orderable : false
		         }
		         
		        ],
		        order : [ [ 4, 'desc' ] ], 
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