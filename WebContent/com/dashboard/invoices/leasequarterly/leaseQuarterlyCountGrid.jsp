 <%@page import="com.dashboard.invoices.leasequarterly.*"%>
 <%ClsLeaseQuarterlyInvoiceDAO quarterlydao=new ClsLeaseQuarterlyInvoiceDAO();%>
 <%
       	String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
		String date1=request.getParameter("date1")==null?"":request.getParameter("date1");
		String client=request.getParameter("client")==null?"":request.getParameter("client");
		String status=request.getParameter("status")==null?"0":request.getParameter("status");
 %> 
<script type="text/javascript">
	var temp1='<%=branch%>';
	var status1='<%=status%>';
	 var invdata;
	if(temp1!='' && temp1!='a' && status1=="1")
{
		invdata= '<%=quarterlydao.getInvoiceno(date1,branch,client,status)%>'; 
		//alert(invdata);
}
	else{
		invdata;
	}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  }
					
						
						],
				    localdata: invdata,
        
        
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
    
    
    $("#leaseQuarterlyCountGrid").jqxGrid(
    {
        width: '100%',
        height: 170,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'}
						
					
					]
    
    });

    $('#leaseQuarterlyCountGrid').on('rowdoubleclick', function (event) 
    		{ 
    	$("#overlay, #PleaseWait").hide();
    	var rowindex1=event.args.rowindex;
    	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(dateval==1){
    	var desc=$('#leaseQuarterlyCountGrid').jqxGrid("getcellvalue",rowindex1,"desc1");
    	document.getElementById("desc").value=$('#leaseQuarterlyCountGrid').jqxGrid("getcellvalue",rowindex1,"desc1").replace(/ /g, "%20");
    	document.getElementById("btninvoicesave").style.display="block";
    	 var date1= $('#periodupto').jqxDateTimeInput('getText');
    	 var branchvalue=document.getElementById("cmbbranch").value;
		 var client=document.getElementById("hidclient").value;
		 //alert('temp='+null+'&desc1='+desc.replace(/ /g, "%20")+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=2');
    		$('#leasequarterlydiv').load('leaseQuarterlyGrid.jsp?temp='+null+'&desc1='+desc.replace(/ /g, "%20")+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=2');
			}
    		});
});

	
	
</script>
<div id="leaseQuarterlyCountGrid"></div>
<input type="hidden" name="desc" id="desc">