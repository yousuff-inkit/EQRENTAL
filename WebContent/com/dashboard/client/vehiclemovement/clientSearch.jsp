<%@ page import="com.dashboard.client.vehiclemovement.ClsVehicleMovDAO" %>
<%   ClsVehicleMovDAO vmdao=new ClsVehicleMovDAO();  %>
<script type="text/javascript">

var	client= '<%=vmdao.clientsearchmove()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'cldocno', type: 'string'  },
						{name : 'refname', type: 'string'  },
						{name : 'clientinfo', type: 'string' }
						],
				    localdata: client,
        
        
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
    
    
    $("#clientsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Doc No', datafield: 'cldocno', width: '20%' },
						{ text: 'Name', datafield: 'refname', width: '80%'},
						{ text: 'Client Info', datafield: 'clientinfo', width: '25%',hidden:true}
					]
    
    });
    $('#clientsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    		
    		    var boundIndex = args.rowindex;
    		    document.getElementById("client").value= $('#clientsearchGrid').jqxGrid('getcellvalue',boundIndex, "refname");
    		    document.getElementById("hidclient").value= $('#clientsearchGrid').jqxGrid('getcellvalue',boundIndex, "cldocno");
    		   // 
    		    var values= $('#clientsearchGrid').jqxGrid('getcellvalue',boundIndex, "clientinfo");
    		
    		    var sum2 = values.toString().replace(/\*/g, '\n');
    		 
    		    document.getElementById("clientinfo").value=sum2;
    		    
    	        $('#clientwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="clientsearchGrid"></div>