 <%@ page import="com.dashboard.android.veh_booking.ClsVehicleBookDAO" %>
<% ClsVehicleBookDAO cvbd=new ClsVehicleBookDAO(); %>
 



 
 
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">


var ssss;

	ssss='<%=cvbd.userSearch()%>';


 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						{name : 'doc_no', type: 'string'  },
						{name : 'user_name', type: 'string'  },
						
						],
				    localdata: ssss,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#userSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 525,
        source: dataAdapter,
        //showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Doc No', datafield: 'doc_no',width: '10%' ,hidden:'true' },
						{ text: 'User Name', datafield: 'user_name',width: '35%' },
						
							]
    
    });
    
    

    $('#userSearchGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#userSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		
		var uname=$('#userSearchGrid').jqxGrid('getcellvalue', rowindex1, "user_name");

		document.getElementById("usdocno").value= doc;
		document.getElementById("user").value=uname;
		
		$('#userDetailsToWindow').jqxWindow('close');


	}); 
    
    	  

});

	
	
</script>
<div id="userSearchGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">