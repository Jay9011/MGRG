/**
 *  사용자 페이지
 */
var nowView = undefined;
$(document).ready(function() {

	// 더보기 버튼 누르기
	$('#viewnotice').click(function() {
		$('#viewmodal').modal('show');
	});
	showView();
	
});
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


