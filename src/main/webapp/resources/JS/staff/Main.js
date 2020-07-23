$(document).ready(function(){
	loadPage();
	
	let table = $('#staff_list').DataTable();
	$('#staff_list tbody').on('click','tr',function(e){
		let cell = $(e.target).closest('td');
		if(cell.index() > 0){
			let data = table.row(this).data();
			alert(data.uid + ' 클릭함.');
			$('#viewStaff').modal('show');
		} else {
			
		}
	});

	$('.password svg').on('click',function() {
		$('input').toggleClass('active');
		if($('input').hasClass('active')) {
			$(this).html('<path d="M10.79 12.912l-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7.029 7.029 0 0 0 2.79-.588zM5.21 3.088A7.028 7.028 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474L5.21 3.089z"/><path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829l-2.83-2.829zm4.95.708l-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829z"/><path fill-rule="evenodd" d="M13.646 14.354l-12-12 .708-.708 12 12-.708.708z"/>')
			.attr('class', 'bi bi-eye-slash-fill')
			.prev('input').attr('type', 'text');
		}else{
			$(this).html('<path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z"/><path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z"/>')
			.attr('class', 'bi bi-eye-fill')
			.prev('input').attr('type', 'password');
		}
	});
});

function loadPage(){
	$('#staff_list').DataTable({
		order:[[1, 'asc']]
		,language:{
			info:'검색된 사원 수 _TOTAL_ 명',
			infoFiltered:'(총 사원수 _MAX_ 명)',
			lengthMenu:'최대 _MENU_명씩 보기',
			search:'검색 : ',
			infoEmpty:'검색된 사원 수 0 명',
			zeroRecords:'검색 된 사원이 없습니다.',
			paginate:{
				first:'<<',
				last:'>>',
				previous:'<',
				next:'>'
			}
		}
		,scrollX:true
		,ajax:{
			url: path + '/staff/list.json',
			dataSrc: 'data'
		}
		,columns:[
			{data: 'uid'
				,'render' :  function ( data, type, full, meta ) {
					n_uid = data;
	                return '<input type="checkbox" name="uid" value='+data+ '>'
	        }},
			{data: 'name'},
			{data: 'position'},
			{data: 'phonenum'},
			{data: 'email'},
			{data: 'address'},
			{data: 'birthday'},
			{data: 'leftHoliday'}
		]
		,columnDefs:[
			{targets: 0,
				orderable: false}
		]
	});
}