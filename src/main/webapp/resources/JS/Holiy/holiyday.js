/**
 * 
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(function() {
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