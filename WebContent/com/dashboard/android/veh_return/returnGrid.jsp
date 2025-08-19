 <%@ page import="com.dashboard.android.veh_return.ClsVehicleReturnDAO" %>
<% ClsVehicleReturnDAO cvrd=new ClsVehicleReturnDAO(); %>
 
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
	ssss='<%=cvrd.returnSearch()%>';
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
						{name : 'rtn_date', type: 'string'  },
						{name : 'rtn_time', type: 'string'  },
						{name : 'place', type: 'string'  },
						{name : 'rname', type: 'string'  },
						{name : 'remail', type: 'string'  },
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
    
    
    $("#vehReturnGrid").jqxGrid(
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
						{ text: 'Doc No', datafield: 'doc_no',width: '5%' },
						{ text: 'Name', datafield: 'name',width: '10%' },
						{ text: 'Mobile Number', datafield: 'mobile_no', width: '10%'},
						{ text: 'Vehicle Number', datafield: 'vehicle_no',width: '8%' },
						{ text: 'Return Date', datafield: 'rtn_date',width: '8%' },
						{ text: 'Return Time', datafield: 'rtn_time',width: '10%' },
						{ text: 'Place', datafield: 'place', width: '10%'},
						
						{ text: 'Cus_User', datafield: 'rname',width: '10%', },
						{ text: 'Cus_Email-Id', datafield: 'remail',width: '10%', },
						{ text: 'Cus_MobileNo', datafield: 'rmobile',width: '10%', },
						{ text: 'Date', datafield: 'cdate',width: '9%', },
						
							]
    
    });
    
    

    $('#vehReturnGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#vehReturnGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		 


		document.getElementById("sdocno").value= doc;



	}); 
    
    	  

});

	
	
</script>
<div id="vehReturnGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">