/**
 *  사용자 페이지
 */
var nowView = undefined;
$(document).ready(function() {
	
	Holiyday();
	 $('#viewcom').on('click', function() {
			$('#comShow').toggle('slow').toggleClass('act');
		});
		
	// 더보기 버튼 누르기
	$('#viewnotice').click(function() {
		$('#viewmodal').modal('show'); 
	});
	dataTable();
	showView();
	
	 $('#calendar').evoCalendar({
         sidebarToggler:true,
         sidebarDisplayDefault:false,
         eventListToggler:false,
          eventDisplayDefault:false,
          language:'ko'
     });
	 dateTime();
});
function dataTable() {
	$('#notitable').DataTable({
		order : [[2, 'desc']],
		info : false,
		language : {
			search : '검색 : ',
			lengthMenu : '_MENU_씩 보기',
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

function showView() {
	$('.tale tbody').on('click', 'td span.noticea', function() {
		$.ajax({
			url : path+"/login/view.mem?uid="+ $(this).attr('data-uid'),
			type : "GET",
			cache : false,
			success : function(data, status) {
				if(status == "success"){
					if(data.status =="OK"){
						nowView = data.data[0];
						loadView();
						$('#uviewModal').modal('show');
					}else{
						alert("VIEW 실패");
					}
				}
			}
		});
	});
}
function loadView() {
	
	$('#uviewModal #staticBackdropLabel').text(nowView.subject);
	$('#uviewModal .modal-body #cont').html(nowView.content);
	$('#uviewModal  .modal-body #reg').text(nowView.regdate);
}

// 휴가 데이터 가져오기
function Holiyday() {
	$('#viewcom').on('click', function() {
		alert("됨당");
		$.ajax({
			url : path + "/login/cal.mem?empuid="+$(this).attr('data-emp'),
			type : "GET",
			cache : false,
			success : function(data, status) {
				if(data.status == "OK"){
					data.data;
				}else{
					alert("CAl 실패");
				}
			}
		
		});
	});
}

function dateTime() {
	 $("#calendar").evoCalendar('addCalendarEvent', [
		
		 {
	     date:"2020-07-14",
	     type:"holiday",
	     everyYear:false
	     },
	     {
	     date:"2020-07-16",
	     type:"absence",
	     everyYear:false
	     },
	     ]);
}



