$(document).ready(function(){
	loadPage();
	
	let table = $('#staff_list').DataTable();
	$('#staff_list tbody').on('click','tr',function(){
		let data = table.row(this).data();
		alert(data.uid + ' 클릭함.');
		$('#viewStaff').modal('show');
	});

	$('.input-group.date').datepicker({
	    todayBtn: "linked",
	    language: "ko",
	    daysOfWeekHighlighted: "1,2,3,4,5",
	    autoclose: true,
	    todayHighlight: true
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