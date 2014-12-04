$(document).ready(function(){
     var w_val;
     var h_val;
     var del_type;
     var var_id;
     var var_url;
     var del_message;

     w_val = $('#delete_obj_link').attr('this_obj_w');
     h_val = $('#delete_obj_link').attr('this_obj_h');
     del_type = $('#delete_obj_link').attr('this_obj_type');
     var_id = $('#delete_obj_link').attr('this_obj_id');
     del_message = $('#delete_obj_link').attr('this_obj_message');

     $( "#dialog_delete_obj" ).dialog({
          autoOpen: false,
          width: w_val,
          height: h_val,
          buttons: [
               {
                    text: "Delete",
                    click: function() {
                         $('#dialog_delete_obj').html("<img src=\"/assets/3.gif\" alt=\"Page Loading\">");
                         var_url = '/'+del_type+'/'+var_id+'/delobj';
                         $.ajax({
                              url: var_url,
                              type: 'get',
                              dataType: 'json',
                              success: function(data) {
                                   if(data.hasOwnProperty('created')) {
                                        var this_status = data['success'];
                                        if (this_status == 'yes') {
                                             var redirect_url = data['redirect'];
                                             $('#dialog_delete_obj').html("<h1>Object Deleted</h1>");
                                             window.location.href = redirect_url;
                                        }  else {
                                             $('#dialog_delete_obj').html("<h1>Error Deleting Object</h1>");
                                        }
                                   } else {
                                        $('#dialog_delete_obj').html("<h1>Error Deleting Object</h1>");
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


     $( "#delete_obj_link" ).click(function() {

          $('#dialog_delete_obj').prop('title', 'Delete Object');
          $('#dialog_delete_obj').html("<table border=\"0\"><tr><td align=\"left\">"+del_message+"</td></tr></table>");
          $("#dialog_delete_obj").dialog( "open" );

     });

});