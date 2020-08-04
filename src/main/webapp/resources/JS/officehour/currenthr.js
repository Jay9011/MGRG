$(document).ready(function(){
	$('#startDate').datepicker({
		dateFormat : "yy-mm-dd",
		changeMonth : true,
		changeYear : true,
		dayNamesMin : ['월', '화', '수', '목', '금', '토', '일'],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		showMonthAfterYear : true,
		onClose : function(selectedDate){
			$('#endDate').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('#endDate').datepicker({
		dateFormat : "yy-mm-dd",
		changeMonth : true,
		changeYear : true,
		dayNamesMin : ['월', '화', '수', '목', '금', '토', '일'],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		showMonthAfterYear : false,
		onClose : function(selectedDate){
			$('#startDate').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
});
$(document).on('keyup','.upnum', function() {
	$(this).val( $(this).val().replace(/[^0-9]/g, "")
			.replace(/^((19|20)\d{2})(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])([1-9]|[01][0-9]|2[0-3])([0-5][0-9])$/,"$1-$2-$3 $4:$5:$6"));
});
