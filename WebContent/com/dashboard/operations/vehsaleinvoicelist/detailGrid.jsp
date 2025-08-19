<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%@page import="com.dashboard.operations.vehsaleinvoicelist.ClsVehSaleInvoiceListDAO"%>
<%ClsVehSaleInvoiceListDAO DAO= new ClsVehSaleInvoiceListDAO(); %>
<%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();

%>
<script type="text/javascript">

var temp='<%=check%>';
//alert("details = "+temp);
if(temp!='0'){ 
	var datafleet='<%=DAO.detail(branchval, fromDate, toDate,check)%>';
	<%-- var detailexceldata='<%=DAO.detailexcel(branchval, fromDate, toDate)%>'; --%>

	} 
var rendererstring=function (aggregates){
 	var value=aggregates['sum'];
 	if(value=="undefined" || typeof(value)=="undefined"){
 		value=0;
 	}
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}

        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
  							{name : 'voc_no' , type: 'String' },
							{name : 'doc_no' , type: 'String' },
							{name : 'date',type:'date'},
							{name : 'client', type: 'String'  },
                          	{name : 'fleet_no' , type: 'String' },
                          	{name : 'brand', type: 'String'  },
                          	{name : 'flname', type: 'String'  },
     						{name : 'reg_no',type:'string'},
     						{name : 'salesprice',type:'number'},
     						{name : 'dep_posted',type:'date'},
     						{name : 'pur_value',type:'number'},
     						{name : 'acc_dep',type:'number'},
     						{name : 'cur_dep',type:'number'},
     						{name : 'netbook',type:'number'},
     						{name : 'net_pl',type:'number'},
     						{name : 'yom',type:'string'},
     						{name : 'model',type:'string'},
     						{name : 'chno',type:'string'},
     						{name : 'brhid',type:'string'}

     						
     					
                 ],
                localdata: datafleet,
                //url: url,
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
            $("#detailGrid").jqxGrid(
            {
            	 width: '98%',
                 height: 550,
                 source: dataAdapter,
                 rowsheight:25,
                 filtermode:'excel',
                 filterable: true,
                 sortable: false,
                 selectionmode: 'singlerow',
                 editable: false,
                 enabletooltips:true,
                 showfilterrow:true,
             	showaggregates:true,
                 showstatusbar:true,                //Add row method
                      
                columns: [
					{ text: 'Doc No', datafield: 'voc_no',editable:false, width: '5%'},
					{ text: 'Doc No', datafield: 'doc_no',editable:false, width: '5%',hidden:true},
					{ text: 'Date', datafield: 'date',editable:false, width: '7%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Branch',  datafield: 'brhid',   width: '10%'  },

					{ text: 'Client', datafield: 'client',editable:false, width: '14%'},
								{ text: 'Fleet', datafield: 'fleet_no',editable:false, width: '5%'},
							
								/*{ text: 'Brand', datafield: 'brand',editable:false, width: '10%'},*/
								{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '12%'},
							{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '8%'},
							{ text: 'YoM', datafield: 'yom',editable:false, width: '4%'},
							{ text: 'Model', datafield: 'model',editable:false, width: '4%'},
							{ text: 'Chassis No', datafield: 'chno',editable:false, width: '12%'},
							{ text: 'Sales Price', datafield: 'salesprice', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Dep Posted', datafield: 'dep_posted', width: '8%',editable:false ,cellsformat:'dd.MM.yyyy',cellsalign:'right',align:'right'},
							{ text: 'Purchase Value', datafield: 'pur_value', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Acc.Dep', datafield: 'acc_dep', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Current Dep',datafield:'cur_dep', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Net Book',datafield:'netbook', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net P /(L)',  datafield:'net_pl',width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring}
							
							]
            });
            if(temp=='NA'){
                $("#detailGrid").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
           
           
        });
    </script>
    <div id="detailGrid"></div>
