<%@page import="com.dashboard.vehicle.vehicleassetregisterAlfahim.ClsVehicleAssetRegisterAlfahimDAO" %>
<% ClsVehicleAssetRegisterAlfahimDAO cva=new ClsVehicleAssetRegisterAlfahimDAO(); %>
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
     						{name : 'age',type:'int'},
							{name : 'deprper',type:'number'},
     						{name : 'purdate',type:'date'},
     						{name : 'reg_no',type:'String'},
     						{name : 'plate',type:'String'},
     						{name : 'residualvalue',type:'number'},
     						{name : 'startdate',type:'date'},
     						{name : 'enddate',type:'date'},
     						{name : 'contractno',type:'String'},    						
     						{name : 'first_day',type:'String'},
     						{name : 'last_day',type:'String'},
     						{name : 'prev_last_day',type:'String'},
     						{name : 'assetopn',type:'number'},
     						{name : 'assetadd',type:'number'},
     						{name : 'assetdel',type:'number'},
     						{name : 'assettotal',type:'number'},
     						{name : 'depropn',type:'number'},
     						{name : 'depradd',type:'number'},
     						{name : 'deprdel',type:'number'},
     						{name : 'deprtotal',type:'number'},
     						{name : 'nettotal',type:'number'},
     						{name : 'prevyear',type:'number'}
     						/* {name : 'costasat1',type:'number'},
     						{name : 'costasat2',type:'number'},
     						{name : 'deprasat',type:'number'},
     						{name : 'deprdurprd',type:'number'},
     						{name : 'accdepasat',type:'number'},
     						{name : 'nbvasat1',type:'number'},
     						{name : 'nbvasat2',type:'number'} */
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
            $("#vehicleAssetAlfahimGrid").on("bindingcomplete", function (event) {
            	
            	// your code here.
            	//alert("date==="+temp1);
            	var tmp=$('#vehicleAssetAlfahimGrid').jqxGrid('getcellvalue', 0, "first_day"); 
            	var tmp2=$('#vehicleAssetAlfahimGrid').jqxGrid('getcellvalue', 0, "last_day");
            	var tmp3=$('#vehicleAssetAlfahimGrid').jqxGrid('getcellvalue', 0, "prev_last_day");
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'costasat1', 'text', 'Cost As At '+tmp);
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'costasat2', 'text', 'Cost As At '+tmp2);
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'deprasat', 'text', 'Depr As At '+tmp);
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'accdepasat', 'text', 'Acc Dep As At '+tmp2);
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'nbvasat1', 'text', 'NBV As At '+tmp2);
            	$('#vehicleAssetAlfahimGrid').jqxGrid('setcolumnproperty', 'nbvasat2', 'text', 'NBV As At '+tmp3);
            }); 
            $("#vehicleAssetAlfahimGrid").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						      }    
							},
							{ text: 'Fleet', datafield: 'fleet_no',editable:false, width: '6%'},
							{ text: 'Fleet Name', datafield: 'flname',editable:false, width: '14%'},
							{ text: 'Asset id', datafield: 'reg_no',editable:false, width: '6%'},
							{ text: 'Plate', datafield: 'plate',editable:false, width: '4%'},
							{ text: 'Age(M)', datafield: 'age', width: '4%', editable:false,hidden:true},
							{ text: 'Depr(%)', datafield: 'deprper', width: '5%', cellsformat:'d2', editable:false,hidden:true},
							{ text: 'Pur Date', datafield: 'purdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Pur Value', datafield: 'purvalue', width: '7%', editable:false, cellsformat:'d2', cellsalign:'right', align:'right'},
							{ text: 'Residual Value', datafield: 'residualvalue', width: '7%', editable:false, cellsformat:'d2', cellsalign:'right', align:'right'},
							{ text: 'Start Date', datafield: 'startdate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddate', width: '6%',editable:false ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Contract No', datafield: 'contractno', width: '6%', editable:false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Cost As At '+$('#fromdate').val(), datafield: 'assetopn', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Additions', datafield: 'assetadd', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Disposals',datafield:'assetdel', width: '7%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: 'deletionClass' },
							
							{ text: 'Cost As At '+$('#todate').val(), datafield: 'assettotal', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'opnClass' },
							{ text: 'Depr As At '+$('#fromdate').val(), datafield: 'depropn', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'additionClass' },
							{ text: 'Dep During The Period',datafield:'depradd', width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'deletionClass' },
							{ text: 'Acc Dep As At '+$('#todate').val(),  datafield:'deprtotal',width: '11%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'NBV As At '+$('#todate').val(),  datafield:'nettotal',width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'NBV As At '+$('#fromdate').val(),  datafield:'prevyear',width: '10%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }
							],
							/* columngroups: 
							  [
							    { text: 'Asset', align: 'center', name: 'Asset',width: '20%' },
							    { text: 'Depreciation', align: 'center', name: 'Depreciation',width: '20%' }
							 
							  ] */
            });
            
            if(temp=='NA'){
                $("#vehicleAssetAlfahimGrid").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			
			
			 /* $('#vehicleAssetAlfahimGrid').on('rowdoubleclick', function (event) {
				    var rowindex=event.args.rowindex;
	                var desc= "Vehicle Asset Register"; 
	                var fleetno=$('#vehicleAssetAlfahimGrid').jqxGrid('getcellvalue', rowindex, "fleet_no");
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					var detName=$('#vehicleAssetAlfahimGrid').jqxGrid('getcellvalue', rowindex, "flname");
					var path="com/dashboard/analysis/vehicleassetregisterreport/vehicleDetailedAssetGrid.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc+"&branchval="+temp+'&fleetno='+fleetno+'&fromdate='+temp1+'&todate='+temp2);
	          	    
	              }); */
            
        });

</script>
<div id="vehicleAssetAlfahimGrid"></div>
