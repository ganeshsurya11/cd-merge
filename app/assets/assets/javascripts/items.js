$(document).ready(function(){

	$( "#dialog" ).dialog({
		autoOpen: false,
		width: 325,
		height: 325,
		buttons: [
			{
				text: "Create",
				click: function() {
					$.ajax({
						url: '/holding_institutions.json',
						type: 'post',
						dataType: 'json',
						data: $('form#new_holding_institution').serialize(),
						success: function(data) {
									//alert("jason: " + JSON.stringify(data));
									if(data.hasOwnProperty('created_at')) {
										$('#dialog').html("<h1>Record Created</h1>");
										location.reload(true);
									} else {
										$('#dialog').html("<h1>Error Created Record</h1>");
									}
								 }
					});
				}
			},
			{
				text: "Cancel",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});

	
	
	$( ".item_holding_select" ).change(function() {
	
		var int_hi = $(this).val()
		if (int_hi && int_hi == 0) {
			$("#loading-div-background").css({ opacity: 0.8 });
			$('#dialog').prop('title', 'Create New Holding Institution');	
			$("#loading-div-background").show(); 
			$.get('/his/new', function(data) {
				$('#dialog').html(data);
				$("#loading-div-background").hide();
				$( "#dialog" ).dialog( "open" );

			});
			 
			 
		}
	});
	
	
});