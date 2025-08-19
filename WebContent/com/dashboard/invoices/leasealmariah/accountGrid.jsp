<%@page import="com.dashboard.invoices.leasealmariah.*"%>
<%ClsLeaseAlmariahInvoiceDAO leasedao=new ClsLeaseAlmariahInvoiceDAO();%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String rentalsum=request.getParameter("rentalsum")==null?"0.0":request.getParameter("rentalsum");
String salikamt=request.getParameter("salikamt")==null?"0.0":request.getParameter("salikamt");
String saliksrvc=request.getParameter("saliksrvc")==null?"0.0":request.getParameter("saliksrvc");
String securitypass=request.getParameter("securitypass")==null?"0.0":request.getParameter("securitypass");
String fuel=request.getParameter("fuel")==null?"0.0":request.getParameter("fuel");
String safetyacc=request.getParameter("safetyacc")==null?"0.0":request.getParameter("safetyacc");
String diw=request.getParameter("diw")==null?"0.0":request.getParameter("diw");
String hpd=request.getParameter("hpd")==null?"0.0":request.getParameter("hpd"); 
String id=request.getParameter("id")==null?"0":request.getParameter("id"); 
 %> 
<script type="text/javascript">
var accountdata;
var id='<%=id%>';
if(id=="1")
{
	accountdata='<%=leasedao.getAccountData(agmtno,id,rentalsum,salikamt,saliksrvc,securitypass,fuel,safetyacc,diw,hpd)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'description', type: 'string'  },
					{name : 'amount', type: 'number'  }
					
					],
				    localdata: accountdata,
        
        
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
    
    
    $("#accountGrid").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'SL#', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '10%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						},
						{ text: 'Description', datafield: 'description', width: '70%' },
						{ text: 'Amount', datafield: 'amount', width: '20%',cellsformat:'d2',align:'right',cellsalign:'right'}
						
					
					]
    
    });
});

	
	
</script>
<div id="accountGrid"></div>