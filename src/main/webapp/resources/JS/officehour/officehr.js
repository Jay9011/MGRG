var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(document).ready(function($)
{
	//ajax row data
	var ajax_data;
	
	// ajax를 보내기전에 header세팅해주기
	$.ajaxSetup({
        beforeSend: function(xhr) {
        	xhr.setRequestHeader(header, token);
        }
    });
	
	loadPage(ajax_data);
	
	//--->save single field data > start
	$(document).on('focusout', '.row_data', function(event) 
	{
		event.preventDefault();

		if($(this).attr('edit_type') == 'button')
		{
			return false; 
		}

		var row_id = $(this).closest('tr').attr('row_id'); 
		
		var row_div = $(this)				
		.removeClass('bg-white') //add bg css
		.css('padding','')

		var col_name = row_div.attr('col_name'); 
		var col_val = row_div.html(); 

		var arr = {};
		arr[col_name] = col_val;

		//use the "arr"	object for your ajax call
		$.extend(arr, {row_id:row_id});

		//out put to show
		$('.post_msg').html( '<pre class="bg-success">'+JSON.stringify(arr, null, 2) +'</pre>');
		
	})	
	//--->save single field data > end

 
	
	
	//--->button > edit > start	
	$(document).on('click', '.btn_edit', function(event) 
	{
		
		var leave = $('.end').text();
		
		event.preventDefault();
		var tbl_row = $(this).closest('tr');
		var row_id = tbl_row.attr('row_id');
		var tbl_row_edit = tbl_row.find('.row_data');
		
		tbl_row.find('.btn_save').show();
		tbl_row.find('.btn_cancel').show();

		//hide edit button
		tbl_row.find('.btn_edit').hide(); 
		
		//make the whole row editable
		tbl_row.find('.row_data')
		.attr('contenteditable', 'true')
		.addClass('bg-white')
		.css('padding','3px')
		
		tbl_row_edit.focus(function(){
			$(this).addClass('bg-white').css('padding', '3px');
		});

		//--->add the original entry > start
		tbl_row.find('.row_data').each(function(index, val) 
		{  
			//this will help in case user decided to click on cancel button
			$(this).attr('original_entry', $(this).html());
		}); 		
		//--->add the original entry > end

	});
	//--->button > edit > end


	//--->button > cancel > start	
	$(document).on('click', '.btn_cancel', function(event) 
	{
		event.preventDefault();

		var tbl_row = $(this).closest('tr');

		//hide save and cacel buttons
		tbl_row.find('.btn_save').hide();
		tbl_row.find('.btn_cancel').hide();

		//show edit button
		tbl_row.find('.btn_edit').show();

		//make the whole row editable
		tbl_row.find('.row_data')
		.attr('edit_type', 'click')
		.removeClass('bg-white')
		.css('padding','') 

		tbl_row.find('.row_data').each(function(index, val) 
		{   
			$(this).html( $(this).attr('original_entry') ).attr('contenteditable', 'false'); 
		});  
	});
	//--->button > cancel > end

	
	// TODO
	//--->save whole row entery > start	
	$(document).on('click', '.btn_save', function(event) 
	{
		event.preventDefault();
		var tbl_row = $(this).closest('tr');

		var row_id = tbl_row.attr('row_id');

		
		//hide save and cacel buttons
		tbl_row.find('.btn_save').hide();
		tbl_row.find('.btn_cancel').hide();

		//show edit button
		tbl_row.find('.btn_edit').show();


		//make the whole row editable
		tbl_row.find('.row_data')
		.attr('contenteditable', 'false')
		.removeClass('bg-white')
		.css('padding','')

		//--->get row data > start
		var arr = {}; 
		var timeArr = [];
		var param ;
		tbl_row.find('.row_data').each(function(index, val) 
		{   
			var col_name = $(this).attr('col_name');  
			var col_val  =  $(this).text();
			arr[index] = col_val;
			var e_uid = $(this).closest('tr').find('.e_uid').val();
			var start = $(this).closest('tr').find('.start').text();
			var end = $(this).closest('tr').find('.end').text();
			alert(start);
			/*alert(e_uid);
			alert(col_name);
			alert(index);
			alert(arr[index]);
			
			alert(col_val);*/
			
			arr = {
				uid : e_uid,
				start : start,
				end : arr[1]
			}
		
		/*	alert(arr[0]);
			alert(col_val);
			alert(typeof(col_val));*/
		});
		
		
		//--->get row data > end
		
		$.ajax({
			url : "/hrm/offhr/update",
			type : "GET",
			cache : false,
			data : arr,
			success : function(data, status){
				if(status == "success"){
					alert('수정 성공');
				}
			}
			
		});

		//use the "arr"	object for your ajax call
		$.extend(arr, {row_id:row_id});

		//out put to show
		$('.post_msg').html( '<pre class="bg-success">'+JSON.stringify(arr, null, 2) +'</pre>')
		 

	});
	//--->save whole row entery > end
	
}); 


// ----------------------------------------------------------------


function loadPage(data){
	$.ajax({
		url : "/hrm/offhr/list",
		type : "POST",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				makeTable(data);
			}
		}
		
	});
}


function makeTable(ajax_data){
	//--->create data table > start
	var tbl = '';
	tbl +='<table class="table table-hover">'

		//--->create table header > start
		tbl +='<thead>';
			tbl +='<tr>';
			tbl +='<th>이름</th>';
			tbl +='<th>부서</th>';
			tbl +='<th>직책</th>';
			tbl +='<th>근태현황</th>';
			tbl +='<th>출근 시간</th>';
			tbl +='<th>퇴근 시간</th>';
			tbl +='<th>수정</th>';
			tbl +='</tr>';
		tbl +='</thead>';
		//--->create table header > end

		
		//--->create table body > start
		tbl +='<tbody>';

			//--->create table body rows > start
			$.each(ajax_data.data, function(index, val) 
			{
				//for(i = 0; i < ajax_data.length; i++ ){
					var startTime = "<div class='container'><div class='row'><div class='col-sm-6'><div class='form-group'>" + 
										 "<div class='input-group date' id='datetimepicker"+ (index+1) + "'><input type='text' class='form-control' value=" + val['start'] + "/>" + 
										 "<span class='input-group-addon'><span class='glyphicon glyphicon-calendar'></span></span></div></div></div>";
					var endTime = "<div class='container'><div class='row'><div class='col-sm-6'><div class='form-group'>" + 
					 "<div class='input-group date' id='datetimepicker"+ (index+1) + "'><input type='text' class='form-control' value=" + val['end'] + "/>" + 
					 "<span class='input-group-addon'><span class='glyphicon glyphicon-calendar'></span></span></div></div></div>";

				
				//you can replace with your database row id

				//loop through ajax row data
				tbl +='<tr>';
					tbl +='<td ><div col_name="fname">'+val['name']+'</div><input class="e_uid" type="hidden" value=' + val['uid'] + '></td>';
					tbl +='<td ><div col_name="lname">'+val['dept']+'</div></td>';
					tbl +='<td ><div col_name="email">'+val['posRank']+'</div></td>';
					tbl +='<td ><div class="status" col_name="email">'+val['status']+'</div></td>';
					tbl +='<td ><div class="row_data start" col_name="start" value="' + val['start'] + '">'+val['start']+'</div></td>';
					tbl +='<td ><div class="row_data end" col_name="end">'+val['end']+'</div></td>';
//					tbl +='<td >' + startTime + '</td>';
//					tbl +='<td >' + endTime + '</td>';

					//--->edit options > start
					tbl +='<td>';
						tbl +='<span class="btn_edit" > <input type="button" class="btn btn-primary" value="수정"> </span>';
						//only show this button if edit button is clicked
						tbl +='<span class="btn_save"> <input type="button" class="btn btn-primary" value="저장">&nbsp;</span>';
						tbl +='<span class="btn_cancel"> <input type="button" class="btn btn-primary" value="취소"> </span>';

					tbl +='</td>';
					//--->edit options > end
					
				tbl +='</tr>';
				//}
				
			});

			//--->create table body rows > end

		tbl +='</tbody>';
		//--->create table body > end

	tbl +='</table>'	
	//--->create data table > end
			

	//out put table data
	$(document).find('.tbl_user_data').html(tbl);
	$('div.status:contains("출근")').addClass('bg-success');
	$('div.status:contains("지각")').addClass('bg-warning');
	$('div.status:contains("결근")').addClass('bg-danger');
	$('div.status:contains("퇴근")').addClass('bg-secondary');

	$(document).find('.btn_save').hide();
	$(document).find('.btn_cancel').hide(); 
	
}


