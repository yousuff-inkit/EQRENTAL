<%@page import="com.dashboard.trafficfine.trafficstatus.ClsTrafficdetailsDAO" %>
<%ClsTrafficdetailsDAO ctd=new ClsTrafficdetailsDAO(); %>


 <%
           	String test = request.getParameter("test")==null?"NA":request.getParameter("test").trim();
	String fromdate = request.getParameter("from")==null?"0":request.getParameter("from").trim();
  	String todate = request.getParameter("to")==null?"0":request.getParameter("to").trim();
  	String ticketno = request.getParameter("ticketno")==null?"":request.getParameter("ticketno").trim();
  	String regno = request.getParameter("regno")==null?"":request.getParameter("regno").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=test%>';
	 var vehdatas;
	 var bb;
	if(temp1!='NA')
{
		vehdatas= '<%=ctd.subDetails(fromdate,todate,ticketno,regno)%>';
		
		bb=0;
}
	else{
		vehdatas;
		 bb=1;
	}
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 
						{name : 'status', type: 'string'  },
						{name : 'value', type: 'string'  },
						{name : 'relodestatus', type: 'string'  }
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#vehdetails").jqxGrid(
    {
        width: '90%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columns: [
                  { text: 'Status', datafield: 'status', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
                  { text: 'Value', datafield: 'value', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                  { text: 'relodestatus', datafield: 'relodestatus', width: '30%',hidden:true},
						//relodestatus
				]
    });
    if(bb==1)
	{
    	$("#vehdetails").jqxGrid('addrow', null, {});
	}
    $('#vehdetails').on('rowdoubleclick', function (event) 
    		{ 
    		    var boundIndex = args.rowindex;
    		    $("#overlay, #PleaseWait").show();
    		    var relodestatus = $('#vehdetails').jqxGrid('getcelltext',boundIndex, "relodestatus");
    		    $("#fleetdiv").load("detailsgrid.jsp?relodestatus="+relodestatus+"&froms="+'<%=fromdate%>'+"&tos="+'<%=todate%>'+"&ticketno="+'<%=ticketno%>'+"&regno="+'<%=regno%>');
    		});
});

	
	
</script>
<div id="vehdetails"></div>