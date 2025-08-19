   <%@page import="com.dashboard.vehicle.forsaleremarks.ClsForsaleRemarksDAO"%>  
     <%ClsForsaleRemarksDAO DAO= new ClsForsaleRemarksDAO(); %>  
  
 <%
  	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
  	    %> 
   
<script type="text/javascript">
//alert("fdg;lfp");
<%-- 	var temp1='<%=branchval%>';
	 var leasedata;
	 var bb;
	if(temp1!='NA')
{
		leasedata= '<%=cmd.subDetails(fromdate,todate,branchval) %>';
		
		bb=0;
}
	else{
		leasedata;
		 bb=1;
	} --%>
	
	<%-- /*  */var id='<%=id%>'; --%>
	var temp1='<%=barchval%>';
	// alert("temp1======"+temp1);
	 var leasedata;
	 if(temp1!='NA'){
		 leasedata= '<%=DAO.subDetailss(barchval) %>';
		 bb=0;
	 }
	 else{
		 leasedata=[];
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
               		{name : 'description', type: 'string'  },
						{name : 'count', type: 'string'  },
						{name : 'relodestatus', type: 'string'  }
						
						],
				    localdata: leasedata,
        
        
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
    
    
    $("#statusdetails").jqxGrid(
    {
        width: '92%',
        height: 220,
        source: dataAdapter,
        rowsheight:18,
        /* showaggregates:true, */
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Description', datafield: 'description', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'relodestatus', datafield: 'relodestatus', width: '30%',hidden:true},
					
						//relodestatus
					]
    
    });
    $("#overlaysub, #PleaseWaitsub").hide();
    $('#statusdetails').on('rowdoubleclick', function (event){   
		    var boundIndex = event.args.rowindex;      

		    $("#overlay, #PleaseWait").show();
		    var relodestatus = $('#statusdetails').jqxGrid('getcelltext',boundIndex, "relodestatus");    
		    console.log(relodestatus.replace(/ /g, "%20")+"=="+'<%=barchval%>');
		    $("#fleetdiv").load("forsaleremarksGrid.jsp?relodestatus="+relodestatus.replace(/ /g, "%20")+"&branch="+'<%=barchval%>'+"&id="+1);
   		});  
});

	
	
</script>
<div id="statusdetails"></div>