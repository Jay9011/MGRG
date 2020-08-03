$(document).ready(function(){
	var emp_uid = $('#empUid').val();
//	alert(emp_uid + " " + typeof(emp_uid));
	var ctx = document.getElementById('myChart');
	
	loadData(emp_uid);
	
	
    var myChart = new Chart(ctx, {
        type : 'doughnut',
        data : {
           labels : [ '출근', '결근', '지각', '조퇴', '휴가',
                 'Orange' ],
           datasets : [ {
              label : '# of Votes',
              data : [ 10, 0, 0, 0, 5, 0 ],
              backgroundColor : [ 'rgba(54, 162, 235, 0.2)',
            	  'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)' ],
              borderColor : [ 'rgba(54, 162, 235, 1)',
            	  'rgba(255, 99, 132, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)' ],
              borderWidth : 1
           } ]
        },
        options : {
           responsive : false,

        }
     });
});

function loadData(uid){
	$.ajax({
		url : "hrm/offhour/chart",
		type : "GET",
		cache : false,
		data : uid,
		success : function(data, status){
			if(status == "success"){
				return data;
			}
		}
	});
}