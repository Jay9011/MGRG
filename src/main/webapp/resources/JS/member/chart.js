$(document).ready(
		function() {
			chartReset();

		});

function chartReset(){
	var uid = $('#empUid').val();
	var ctx = document.getElementById('myChart');
	var arr_data = [];
	var absent ;
	var off;
	var earlyOff;
	var late;
	var holiday;

	$.ajaxSetup({
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		}
	});

	$.ajax({
		url : "chart?uid=" + uid,
		type : "GET",
		cache : false,
		success : function(data, status) {
			if (status == "success") {
				absent = data.chartData[0].absent;
				off = data.chartData[0].off;
				earlyOff = data.chartData[0].earlyOff;
				late = data.chartData[0].late;
				holiday = data.chartData[0].holiday;
				
				new Chart(ctx, {
					type : 'doughnut',
					data : {
						labels : [ '출근', '결근', '지각', '조퇴', '휴가' ],
						datasets : [ {
							label : '# of Votes',
							data : [off, absent, late, earlyOff, holiday],
							backgroundColor : [ 'rgba(54, 162, 235, 0.2)',
									'rgba(255, 99, 132, 0.2)',
									'rgba(255, 206, 86, 0.2)',
									'rgba(75, 192, 192, 0.2)',
									'rgba(153, 102, 255, 0.2)'],
							borderColor : [ 'rgba(54, 162, 235, 1)',
									'rgba(255, 99, 132, 1)',
									'rgba(255, 206, 86, 1)',
									'rgba(75, 192, 192, 1)',
									'rgba(153, 102, 255, 1)'],
							borderWidth : 1
						} ]
					},
					options : {
						responsive : false,

					}
				});
			}
		}
	});
}