<%@ page import="com.dashboard.vehicle.securitypassmgmt.*" %>
<%ClsSecurityPassMgmtDAO secdao=new ClsSecurityPassMgmtDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var	fleetdata;
if(id=="1"){
	fleetdata='<%=secdao.fleetSearch(id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name: 'code_name',type: 'string'},
						],
				    localdata: fleetdata,
        
        
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
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Fleet', datafield: 'fleet_no', width: '17%' },
						{ text: 'Name', datafield: 'flname', width: '50%'},
						{ text: 'Reg No', datafield: 'reg_no', width: '17%'},
						{text: 'Plate Code', datafield: 'code_name', width: '16%' },
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var boundIndex = args.rowindex;
    		    document.getElementById("hidvehicle").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "fleet_no");
    		    document.getElementById("vehicle").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "flname");
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>