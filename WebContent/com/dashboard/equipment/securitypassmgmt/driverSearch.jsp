<%@ page import="com.dashboard.vehicle.securitypassmgmt.*" %>
<%ClsSecurityPassMgmtDAO secdao=new ClsSecurityPassMgmtDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var	driverdata;
if(id=="1"){
	driverdata='<%=secdao.driverSearch(id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'doc_no', type: 'string'  },
                    	{name : 'type', type: 'string'  },
                    	{name : 'code', type: 'string'  },
                    	{name : 'sal_name', type: 'string'  },
						{name : 'licenseno', type: 'string'  },
						{name : 'licenseexpiry', type: 'date'  },
						],
				    localdata: driverdata,
        
        
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
    
    
    $("#driverSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Doc No', datafield: 'doc_no', width: '6%' },
						{ text: 'Type', datafield: 'type', width: '6%' },
						{ text: 'code', datafield: 'code', width: '10%' },						
						{ text: 'Name', datafield: 'sal_name', width: '50%'},
						{ text: 'License No', datafield: 'licenseno', width: '15%'},
						{text: 'License Expiry', datafield: 'licenseexpiry', width: '10%',cellsformat:'dd.MM.yyyy' },
					]
    
    });
    $('#driverSearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var boundIndex = args.rowindex;
    		    document.getElementById("hiddriver").value= $('#driverSearchGrid').jqxGrid('getcellvalue',boundIndex, "doc_no");
    		    document.getElementById("hiddrivertype").value= $('#driverSearchGrid').jqxGrid('getcellvalue',boundIndex, "type");
    		    document.getElementById("driver").value= $('#driverSearchGrid').jqxGrid('getcellvalue',boundIndex, "sal_name");
    	        $('#driverwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="driverSearchGrid"></div>