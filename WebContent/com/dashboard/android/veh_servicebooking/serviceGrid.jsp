 <%@ page import="com.dashboard.android.veh_servicebooking.ClsVehicleServiceDAO" %>
<% ClsVehicleServiceDAO cvsd=new ClsVehicleServiceDAO(); %>
 
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
	ssss='<%=cvsd.serviceSearch()%>';
	
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
						{name : 'mobile_no', type: 'string'  },
						{name : 'vehicle_no', type: 'string'  },
						{name : 'service', type: 'string'  },
						/*  {name : 'rname', type: 'string'  }, */
						{name : 'email', type: 'string'  },
						/* {name : 'rmobile', type: 'string'  }, */ 
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
    
    
    $("#vehServiceGrid").jqxGrid(
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
						{ text: 'Doc No', datafield: 'doc_no',width: '10%' },
						{ text: 'Name', datafield: 'name',width: '15%' },
						{ text: 'Mobile Number', datafield: 'mobile_no', width: '15%'},
						{ text: 'Vehicle No', datafield: 'vehicle_no',width: '15%' },
						{ text: 'Service Type', datafield: 'service',width: '15%' },
						/* { text: 'User', datafield: 'rname',width: '13%', }, */
						{ text: 'Email-Id', datafield: 'email',width: '15%', },
						/* { text: 'Cus_MobileNo', datafield: 'rmobile',width: '13%', }, */
						{ text: 'Date', datafield: 'cdate',width: '15%', },
						
							]
    
    });
    
    

    $('#vehServiceGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#vehServiceGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		 


		document.getElementById("sdocno").value= doc;



	}); 
    
    	  

});

	
	
</script>
<div id="vehServiceGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">