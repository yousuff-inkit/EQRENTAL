<%@page import="com.dashboard.analysis.unrealizedrevenue.ClsUnRealizedRevenueDAO" %>
<% ClsUnRealizedRevenueDAO cva=new ClsUnRealizedRevenueDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetNo = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String group = request.getParameter("group")==null?"0":request.getParameter("group").trim();
     String model = request.getParameter("model")==null?"0":request.getParameter("model").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<style type="text/css">
  .opnClass
  {
      color: #298A08;
  }
  .additionClass
  {
      color: #0101DF;
  }
  .deletionClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var temp1='<%=fromDate%>';
	  var temp2='<%=toDate%>';
	  
	  	if(temp!='NA'){ 
	  		data='<%=cva.vehicleAsssetGridLoading(branchval, fromDate, toDate, fleetNo, group, model, check)%>';
	  		<%-- var dataExcelExport='<%=cva.vehicleAsssetExcelExport(branchval, fromDate, toDate, fleetNo, group, model, check)%>'; --%>
	  	}
  	
        $(document).ready(function () {
        	 var frm='<%=fromDate%>';
       	  var too='<%=toDate%>';
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
							{name : 'lano',type:'number'},
     						{name : 'branch',type:'String'},
     						{name : 'reg_no',type:'String'},
     						{name : 'stats',type:'String'},
     						{name : 'indate',type:'date'},
     						{name : 'startdate',type:'date'},
     						{name : 'enddate',type:'date'},
     						{name : 'client',type:'String'},
     						{name : 'catname',type:'String'},
     						{name : 'curyear',type:'String'},
     						{name : 'dur',type:'String'},
     						{name : 'reg_no',type:'String'},
     						{name : 'lagamount',type:'number'},
     						{name : 'opnbal',type:'number'},
     						{name : 'recgnzd',type:'number'},
     						{name : 'totrevnrecgnzd',type:'number'},
     						{name : 'invamt',type:'number'},
     						{name : 'balunrecgnzd',type:'number'}
     						
	                      ],
                          localdata: data,
               
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
            $("#unRealizedRevenueGrid").on("bindingcomplete", function (event) {
            	
            	/* var tmp3=$('#unRealizedRevenueGrid').jqxGrid('getcellvalue', 0, "curyear");
            	$('#unRealizedRevenueGrid').jqxGrid('setcolumnproperty', 'recgnzd', 'text', 'Recognized '+'In '+tmp3+' (Monthly)');
            	$('#unRealizedRevenueGrid').jqxGrid('setcolumnproperty', 'totrevnrecgnzd', 'text', 'Total Revenue Recognized '+tmp3);
            	$('#unRealizedRevenueGrid').jqxGrid('setcolumnproperty', 'invamt', 'text', 'Invoiced Amt '+tmp3+' (Monthly)'); */
            }); 
            $("#unRealizedRevenueGrid").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                
                columns: [
							{ text: 'SN.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'LA No', datafield: 'lano',editable:false, width: '6%'},
							{ text: 'Branch', datafield: 'branch',editable:false, width: '7%'},
							{ text: 'Fleet No', datafield: 'fleet_no',editable:false, width: '6%'},
							{ text: 'Fleet', datafield: 'flname',editable:false, width: '14%'},
							{ text: 'Status', datafield: 'stats',editable:false, width: '14%'},
							{ text: 'Start Date', datafield: 'startdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'In Date', datafield: 'indate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Customer Name', datafield: 'client',editable:false, width: '14%'},
							{ text: 'Category', datafield: 'catname',editable:false, width: '6%'},
							{ text: 'Duration', datafield: 'dur',editable:false, width: '5%'},
							{ text: 'Reg No', datafield: 'reg_no',editable:false, width: '6%'},
							{ text: 'Lease Agreement Amount', datafield: 'lagamount', width: '12%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Opening Balance', datafield: 'opnbal', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Recognized',datafield:'recgnzd', width: '14%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							/* { text: 'Total Revenue Recognized',  datafield:'totrevnrecgnzd',width: '17%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }, */
							{ text: 'Invoiced Amt',  datafield:'invamt',width: '13%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Balance Unrecognized',  datafield:'balunrecgnzd',width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							],
							/* columngroups: 
							  [
							    { text: 'Asset', align: 'center', name: 'Asset',width: '20%' },
							    { text: 'Depreciation', align: 'center', name: 'Depreciation',width: '20%' }
							 
							  ] */
            });
            
            if(temp=='NA'){
                $("#unRealizedRevenueGrid").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			
			
			 /* $('#unRealizedRevenueGrid').on('rowdoubleclick', function (event) {
				    var rowindex=event.args.rowindex;
	                var desc= "Vehicle Asset Register"; 
	                var fleetno=$('#unRealizedRevenueGrid').jqxGrid('getcellvalue', rowindex, "fleet_no");
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					var detName=$('#unRealizedRevenueGrid').jqxGrid('getcellvalue', rowindex, "flname");
					var path="com/dashboard/analysis/vehicleassetregisterreport/vehicleDetailedAssetGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&fleetno='+fleetno+'&fromdate='+temp1+'&todate='+temp2);
	          	    
	              }); */
            
        });

</script>
<div id="unRealizedRevenueGrid"></div>
