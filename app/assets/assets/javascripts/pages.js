$(document).ready(function(){

	$("#loading-div-background").css({ opacity: 0.8 });

	$( "#dialog_two" ).dialog({
		autoOpen: false,
		width: 575,
		height: 850,
		title: "Page Image",
		buttons: [
			{
				text: "Close",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});
	
	$( "#dialog_trans" ).dialog({
		autoOpen: false,
		width: 500,
		height: 235,
		title: "Upload Transcription File"
	});

     $( "#dialog_trans_new" ).dialog({
          autoOpen: false,
          width: 525,
          height: 425,
          title: "Add New Transcription File"
     });

	
	$( "#show_image" ).click(function() {
	
		$("#dialog_two").dialog( "option", "width", 575 );
		$("#dialog_two").dialog( "option", "height", 850 );
		var image_file = $('#image_file').val();
		var html_string = '<html><head><title>Image View</title></head><body><img src="'+image_file+'"></body></html>'
		$("#loading-div-background").show(); 
		$('#dialog_two').html(html_string);
		$("#loading-div-background").hide();
		$('#dialog_two').prop('title', 'Page Image');
		$( "#dialog_two" ).dialog( "open" );
		

	});
	
	$( ".transcription_link" ).click(function() {
			var this_id = $(this).attr('id');
			var arrIdParts = this_id.split("_");
			var id_num = arrIdParts[1];
       	 	var url_string = "/trans/"+id_num+"/fedit";
          	$("#loading-div-background").css({ opacity: 0.8 });
			$("#loading-div-background").show(); 
			$.get(url_string, function(data) {
				$('#dialog_trans_new').html(data);
				$("#loading-div-background").hide();
				$( "#dialog_trans" ).dialog( "open" );
			});
		

	});

     $( ".transcription_new_link" ).click(function() {
          var this_id = $(this).attr('id');
          var arrIdParts = this_id.split("_");
          var id_num = arrIdParts[1];
          var url_string = "/trans/"+id_num+"/newtrans";
          $("#loading-div-background").css({ opacity: 0.8 });
          $("#loading-div-background").show();
          $.get(url_string, function(data) {
               $('#dialog_trans_new').html(data);
               $("#loading-div-background").hide();
               $( "#dialog_trans_new" ).dialog( "open" );
          });
     });


     $( "#transcription_work_id" ).change(function() {

          var urlString = "/trans/"+$(this).val()+"/getexpressions";
          alert(urlString);
          $.getJSON(urlString, function(j){
               var options = '';
               for (var i = 0; i < j.length; i++) {
                    options += '<option value="' + j[i][1] + '">' + j[i][0] + '</option>';
               }
               $('select#transcription_expression_id').html(options);
          });
     });
	
	
	
	
});