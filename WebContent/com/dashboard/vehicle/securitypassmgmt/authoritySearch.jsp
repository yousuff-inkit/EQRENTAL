<%@ page import="com.dashboard.vehicle.securitypassmgmt.*" %>
<%ClsSecurityPassMgmtDAO secdao=new ClsSecurityPassMgmtDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var	authdata;
if(id=="1"){
	authdata='<%=secdao.authoritySearch(id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'doc_no', type: 'string'  },
						{name : 'name', type: 'string'  },
						{name : 'description', type: 'string'  },
						],
				    localdata: authdata,
        
        
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
    
    
    $("#authoritySearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Doc No', datafield: 'doc_no', width: '17%' },
						{ text: 'Name', datafield: 'name', width: '50%'},
						{ text: 'Description', datafield: 'description', width: '33%'},
					]
    
    });
    $('#authoritySearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var boundIndex = args.rowindex;
    		    document.getElementById("hidauthority").value= $('#authoritySearchGrid').jqxGrid('getcellvalue',boundIndex, "doc_no");
    		    document.getElementById("authority").value= $('#authoritySearchGrid').jqxGrid('getcellvalue',boundIndex, "name");
    	        $('#authoritywindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="authoritySearchGrid"></div>