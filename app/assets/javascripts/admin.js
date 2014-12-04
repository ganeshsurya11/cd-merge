$(document).ready(function(){

 	$(":button.folder_icon").click(function(){
 		var parents_divs = $(this).parents("div");
 		var str_id = $(this).attr("id");
 		$(this).parents("div").each(function(e) {
 			if (e == 0) {
				$(this).children("div").slideToggle();
				var buttonVal = $("#"+str_id).css("background-image");
				var int_index = buttonVal.indexOf("closed_folder")
				var newButtonVal;
				if (int_index > 0) {
					newButtonVal = "open_folder.jpg";
				} else {
					newButtonVal = "closed_folder.jpg";
				}
				newButtonVal = "url(\"/assets/"+newButtonVal+"\")";
				$("#"+str_id).css("background-image", newButtonVal);
 			}
 		});
	});
	
	
	$("#new_work_button").click(function(){
		document.location.href='/works/new';
	});
	
	$(".new_expression_button_image").click(function(){
		var newlocString = "/expressions/"+ $(this).attr("parent") +"/new";
		document.location.href = newlocString;
	});
	
	$(".new_manifestation_button_image").click(function(){
		var newlocString = "/manifestations/"+ $(this).attr("parent") +"/new";
		document.location.href = newlocString;
	});
	
	$(".new_item_button_image").click(function(){
		var newlocString = "/items/"+ $(this).attr("parent") +"/new";
		document.location.href = newlocString;
	});	
	
});
