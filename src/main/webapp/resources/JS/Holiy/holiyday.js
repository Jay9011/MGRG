/**
 * 
 */
	$(function() {
				$('#datetimepicker1').datetimepicker({
					format : 'YYYY-MM-DD',
					minDate : new Date(),
					daysOfWeekDisabled:[0,6]
				});
				$('#datetimepicker2').datetimepicker({
					format : 'YYYY-MM-DD',
					useCurrent : false,
					minDate : new Date(),
					daysOfWeekDisabled:[0,6]
				});
				$("#datetimepicker1").on("change.datetimepicker", function(e) {
					$('#datetimepicker2').datetimepicker('minDate', e.date);
				});
				$("#datetimepicker2").on("change.datetimepicker", function(e) {
					$('#datetimepicker1').datetimepicker('maxDate', e.date);
				});
			});