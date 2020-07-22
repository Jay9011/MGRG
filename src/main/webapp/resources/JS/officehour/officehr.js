$(document).ready(function($)
{
	//ajax row data
	var ajax_data =
	[
		{name:"한수빈", position:"사원", currStat:"출근", startTime: "2020-07-21", endTime: "2020-07-21"},
		{name:"임상빈", position:"대리", currStat:"출근", startTime: "2020-07-21", endTime: "2020-07-21"},
		{name:"홍성용", position:"과장", currStat:"출근", startTime: "2020-07-21", endTime: "2020-07-21"},
		{name:"윤종섭", position:"대표", currStat:"출근", startTime: "2020-07-21", endTime: "2020-07-21"},
	]



	var random_id = function  () 
	{
		var id_num = Math.random().toString(9).substr(2,3);
		var id_str = Math.random().toString(36).substr(2);
		
		return id_num + id_str;
	}


	//--->create data table > start
	var tbl = '';
	tbl +='<table class="table table-hover">'

		//--->create table header > start
		tbl +='<thead>';
			tbl +='<tr>';
			tbl +='<th>이름</th>';
			tbl +='<th>직책</th>';
			tbl +='<th>근태현황</th>';
			tbl +='<th>출근 시간</th>';
			tbl +='<th>퇴근 시간</th>';
			tbl +='<th>수정 및 삭제</th>';
			tbl +='</tr>';
		tbl +='</thead>';
		//--->create table header > end

		
		//--->create table body > start
		tbl +='<tbody>';

			//--->create table body rows > start
			$.each(ajax_data, function(index, val) 
			{
				
				var starttime = "<div class='container'><div class='row'><div class='col-sm-6'><div class='form-group'>" + 
									 "<div class='input-group date' id='datetimepicker1'><input type='text' class='form-control' value=" + val['startTime'] + "/>" + 
									 "<span class='input-group-addon'><span class='glyphicon glyphicon-calendar'></span></span></div></div></div>";
				var endtime = "<div class='container'><div class='row'><div class='col-sm-6'><div class='form-group'>" + 
				 "<div class='input-group date' id='datetimepicker1'><input type='text' class='form-control' value=" + val['endTime'] + "/>" + 
				 "<span class='input-group-addon'><span class='glyphicon glyphicon-calendar'></span></span></div></div></div>";
				
				//you can replace with your database row id
				var row_id = random_id();

				//loop through ajax row data
				tbl +='<tr row_id="'+row_id+'">';
					tbl +='<td ><div class="row_data" edit_type="click" col_name="fname">'+val['name']+'</div></td>';
					tbl +='<td ><div class="row_data" edit_type="click" col_name="lname">'+val['position']+'</div></td>';
					tbl +='<td ><div class="row_data" edit_type="click" col_name="email">'+val['currStat']+'</div></td>';
					tbl +='<td >' + starttime + '</td>';
					tbl +='<td >' + endtime + '</td>';

					//--->edit options > start
					tbl +='<td>';
					 
						tbl +='<span class="btn_edit" > <a href="#" class="btn btn-link " row_id="'+row_id+'" > 수정</a> </span>';

						//only show this button if edit button is clicked
						tbl +='<span class="btn_save"> <a href="#" class="btn btn-link"  row_id="'+row_id+'"> 저장</a> | </span>';
						tbl +='<span class="btn_cancel"> <a href="#" class="btn btn-link" row_id="'+row_id+'"> 취소</a> </span>';

					tbl +='</td>';
					//--->edit options > end
					
				tbl +='</tr>';
				
				
			});

			//--->create table body rows > end

		tbl +='</tbody>';
		//--->create table body > end

	tbl +='</table>'	
	//--->create data table > end

	//out put table data
	$(document).find('.tbl_user_data').html(tbl);

	$(document).find('.btn_save').hide();
	$(document).find('.btn_cancel').hide(); 
	
//	datetimepicker();
	datetimepicker2();
	

	//--->make div editable > start
	$(document).on('click', '.row_data', function(event) 
	{
		event.preventDefault(); 

		if($(this).attr('edit_type') == 'button')
		{
			return false; 
		}

		//make div editable
		$(this).closest('div').attr('contenteditable', 'true');
		//add bg css
		$(this).addClass('bg-white').css('padding','5px');

		$(this).focus();
	})	
	//--->make div editable > end


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
		event.preventDefault();
		var tbl_row = $(this).closest('tr');

		var row_id = tbl_row.attr('row_id');

		tbl_row.find('.btn_save').show();
		tbl_row.find('.btn_cancel').show();

		//hide edit button
		tbl_row.find('.btn_edit').hide(); 

		//make the whole row editable
		tbl_row.find('.row_data')
		.attr('contenteditable', 'true')
		.attr('edit_type', 'button')
		.addClass('bg-white')
		.css('padding','3px')

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

		var row_id = tbl_row.attr('row_id');

		//hide save and cacel buttons
		tbl_row.find('.btn_save').hide();
		tbl_row.find('.btn_cancel').hide();

		//show edit button
		tbl_row.find('.btn_edit').show();

		//make the whole row editable
		tbl_row.find('.row_data')
		.attr('edit_type', 'click')
		.removeClass('bg-warning')
		.css('padding','') 

		tbl_row.find('.row_data').each(function(index, val) 
		{   
			$(this).html( $(this).attr('original_entry') ); 
		});  
	});
	//--->button > cancel > end

	
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
		.attr('edit_type', 'click')
		.removeClass('bg-white')
		.css('padding','')

		//--->get row data > start
		var arr = {}; 
		tbl_row.find('.row_data').each(function(index, val) 
		{   
			var col_name = $(this).attr('col_name');  
			var col_val  =  $(this).html();
			arr[col_name] = col_val;
		});
		//--->get row data > end

		//use the "arr"	object for your ajax call
		$.extend(arr, {row_id:row_id});

		//out put to show
		$('.post_msg').html( '<pre class="bg-success">'+JSON.stringify(arr, null, 2) +'</pre>')
		 

	});
	//--->save whole row entery > end


}); 



function datetimepicker2(){
	 $(function () {
         $('#datetimepicker1').datetimepicker({
         });
     });
}