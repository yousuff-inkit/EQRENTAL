 <%@ page import="com.dashboard.android.veh_booking.ClsVehicleBookDAO" %>
<% ClsVehicleBookDAO cvbd=new ClsVehicleBookDAO(); %>
 
 <%
 	String idd=request.getParameter("id");
 %>
 
 
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">

var id='<%=idd%>';
var ssss;
if(id=="1")
{
	ssss='<%=cvbd.bookSearch()%>';
}

 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						{name : 'doc_no', type: 'string'  },
						{name : 'user_name', type: 'string'  },
						{name : 'mobilenumber', type: 'string'  },
						{name : 'email', type: 'string'  },
						{name : 'plocation', type: 'string'  },
						{name : 'other_pickup', type: 'string'},
						{name : 'delivery', type: 'string'  },
						{name : 'pick_date', type: 'string'  },
						{name : 'pick_time', type: 'string'  },
						{name : 'dlocation', type: 'string'  },
						{name : 'other_dropoff', type: 'string'},
						{name : 'other', type: 'string'  },
						{name : 'return_date', type: 'string'  },
						{name : 'return_time', type: 'string'  },
						{name : 'car', type: 'string'  },
						
						/* {name : 'rname', type: 'string'  },
						{name : 'remail', type: 'string'  }, */
						{name : 'rmobile', type: 'string'  }, 
						{name : 'cdate', type: 'string'  },
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
    
    
    $("#vehBookingGrid").jqxGrid(
    {
        width: '100%',
        height: 515,
        source: dataAdapter,
        //showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Doc No', datafield: 'doc_no',width: '4%' },
						{ text: 'User Name', datafield: 'user_name', width: '7%'},
						{ text: 'Mobile Number', datafield: 'mobilenumber',width: '7%' },
						{ text: 'Email-Id', datafield: 'email',width: '10%' },
						{ text: 'Pickup Location', datafield: 'plocation',width: '8%' },
						{ text: 'Other PickupLocation', datafield: 'other_pickup',width: '10%' },
						{ text: 'Delivery Request', datafield: 'delivery', width: '12%'},
						{ text: 'Pickup Date', datafield: 'pick_date',width: '6%' },
						{ text: 'Pickup Time', datafield: 'pick_time',width: '6%' },
						{ text: 'Drop off Location', datafield: 'dlocation',width: '8%' },
						{ text: 'Other DropoffLocation', datafield: 'other_dropoff',width: '10%' },
						{ text: 'Other Location', datafield: 'other', width: '12%'},
						{ text: 'Return Date', datafield: 'return_date',width: '6%' },
						{ text: 'Return Time', datafield: 'return_time',width: '6%' },
						{ text: 'Car', datafield: 'car',width: '8%' },
						
						
						/* { text: 'Cus_User', datafield: 'rname',width: '6%', },
						{ text: 'Cus_Email-Id', datafield: 'remail',width: '10%', },*/
						{ text: 'Cus_MobileNo', datafield: 'rmobile',width: '8%', }, 
						{ text: 'Date', datafield: 'cdate',width: '6%', },
						
							]
    
    });
    
    

    $('#vehBookingGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#vehBookingGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		 


		document.getElementById("sdocno").value= doc;



	}); 
    
    	  

});

	
	
</script>
<div id="vehBookingGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">