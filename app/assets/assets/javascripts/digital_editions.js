$(document).ready(function(){

     $("#loading-div-background").css({ opacity: 0.8 });

     $( "#dialog_build_tei" ).dialog({
          autoOpen: false,
          width: 325,
          height: 200,
          buttons: [
               {
                    text: "Build TEI",
                    click: function() {
                         $('#dialog_build_tei').html("<img src=\"/assets/3.gif\" alt=\"Page Loading\">");
                         var_id = $('#tei_link').attr('this_id');
                         var_url = '/dotei/'+var_id
                         // alert('Submit URL: '+var_url)
                         $.ajax({
                              url: var_url,
                              type: 'get',
                              dataType: 'json',
                              // data: $('form#new_holding_institution').serialize(),
                              success: function(data) {
                                   //alert("jason: " + JSON.stringify(data));
                                   if(data.hasOwnProperty('created')) {
                                        $('#dialog_build_tei').html("<h1>TEI Created</h1>");
                                        // location.reload(true);
                                   } else {
                                        $('#dialog_build_tei').html("<h1>Error Creating TEI</h1>");
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

     $( "#dialog_build_concordance").dialog({
          autoOpen: false,
          width: 325,
          height: 200,
          buttons: [
               {
                    text: "Build Concordance",
                    click: function() {
                         $('#dialog_build_concordance').html("<img src=\"/assets/3.gif\" alt=\"Page Loading\">");
                         var_id = $('#concordance_link').attr('this_id');
                         var_url = '/doconcord/'+var_id
                         // alert('Submit URL: '+var_url)
                         $.ajax({
                              url: var_url,
                              type: 'get',
                              dataType: 'json',
                              // data: $('form#new_holding_institution').serialize(),
                              success: function(data) {
                                   //alert("jason: " + JSON.stringify(data));
                                   if(data.hasOwnProperty('created')) {
                                        $('#dialog_build_concordance').html("<h1>Concordance Created</h1>");
                                        // location.reload(true);
                                   } else {
                                        $('#dialog_build_concordance').html("<h1>Error Creating Concordance</h1>");
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


     $( ".edition_manifestation_select" ).change(function() {

          var urlString = "/digital_editions/"+$(this).val()+"/getitem";
          $.getJSON(urlString, function(j){
               var options = '';
               for (var i = 0; i < j.length; i++) {
                    options += '<option value="' + j[i][1] + '">' + j[i][0] + '</option>';
               }
               $('select#digital_edition_item_id').html(options);
          });
     });


     $( "#tei_link" ).click(function() {

               $("#loading-div-background").css({ opacity: 0.8 });
               $('#dialog_build_tei').prop('title', 'Build TEI');
               $("#loading-div-background").show();
               $("#loading-div-background").hide();
               $("#dialog_build_tei").dialog( "open" );

     });

     $( "#concordance_link" ).click(function() {

          $("#loading-div-background").css({ opacity: 0.8 });
          $('#dialog_build_concordance').prop('title', 'Build Concordance');
          $("#loading-div-background").show();
          $("#loading-div-background").hide();
          $("#dialog_build_concordance").dialog( "open" );

     });

});