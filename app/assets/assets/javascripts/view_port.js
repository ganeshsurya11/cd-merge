
$(document).ready(function(){

     var this_parent;
     var this_page;
     var this_first_page;
     var this_last_page;

     $("#gotopage").change(function(){
          this_parent = $('#gotopage').attr('parent');
          this_first_page = $('#gotopage').attr('edfirst');
          this_last_page = $('#gotopage').attr('edlast');
          this_page = $('#gotopage').val();
          if ($.isNumeric(this_page) && (parseFloat(this_page) >= parseFloat(this_first_page)) && (parseFloat(this_page) <= parseFloat(this_last_page))) {
               var url = "/viewport/" + this_parent + "/page/" +  this_page;
               window.location.href = url;
          } else {
               alert("The page number you entered is either not valid or out of range.  Please try again.");
          }

     });


});

function openDonne(tziviFile){
     // var loc = "http://csdl.tamu.edu:8080/tzivi/displayPage.html";
     //loopt=loopt+1;
     //if (loopt>1){
     //     tileWin.close();
     //}
     tileWin = window.open(tziviFile,'tileWin','scrollbars=yes,menubar=no,height=830,width=675,left=50,top=50,resizable=yes,toolbar=no,location=no,status=no');
     tileWin.document.close();
     tileWin.focus();
}