 <%@ page import="com.dashboard.android.veh_complaint.ClsVehicleComplaintDAO" %>
<% ClsVehicleComplaintDAO cvcd=new ClsVehicleComplaintDAO(); %>
 
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
	ssss='<%=cvcd.complaintSearch()%>';
}

 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						{name : 'doc_no', type: 'string'  },
						{name : 'name', type: 'string'  },
						{name : 'mobile', type: 'string'  },
						{name : 'vehicle_no', type: 'string'  },
						{name : 'complaint', type: 'string'  },
						/* {name : 'rname', type: 'string'  },
						{name : 'remail', type: 'string'  },
						{name : 'rmobile', type: 'string'  }, */
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
    
    
    $("#vehComplaintGrid").jqxGrid(
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
						{ text: 'Doc No', datafield: 'doc_no',width: '8%' },
						{ text: 'Name', datafield: 'name',width: '12%' },
						{ text: 'Mobile Number', datafield: 'mobile', width: '15%'},
						{ text: 'Vehicle Number', datafield: 'vehicle_no',width: '15%' },
						{ text: 'Complaint', datafield: 'complaint', width: '40%'},
						
						/* { text: 'Cus_User', datafield: 'rname',width: '8%', },
						{ text: 'Cus_Email-Id', datafield: 'remail',width: '10%', },
						{ text: 'Cus_MobileNo', datafield: 'rmobile',width: '10%', }, */
						{ text: 'Date', datafield: 'cdate',width: '10%', },
						
							]
    
    });
    
    

    $('#vehComplaintGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#vehComplaintGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		 


		document.getElementById("sdocno").value= doc;



	}); 
    
    	  

});

	
	
</script>
<div id="vehComplaintGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">