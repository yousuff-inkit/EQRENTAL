
<%@page import="com.operations.saleofvehicle.vehsalesinvreturn.ClsVehSalesInvReturnDAO"%>
<%String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String salesinvdocno=request.getParameter("salesinvdocno")==null?"":request.getParameter("salesinvdocno");
ClsVehSalesInvReturnDAO disposaldao=new ClsVehSalesInvReturnDAO();
%>
<script type="text/javascript">
      var datafleet= '<%=disposaldao.fleetSearch(branch,salesinvdocno)%>';
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'platecode',type:'string'},
     						{name : 'reg_no',type:'string'},
     						{name : 'chassisno',type:'string'},
     						{name : 'salesprice',type:'number'},
     						{name : 'dep_posted',type:'date'},
     						{name : 'pur_value',type:'number'},
     						{name : 'acc_dep',type:'number'},
     						{name : 'cur_dep',type:'number'},
     						{name : 'netbook',type:'number'},
     						{name : 'net_pl',type:'number'}
     						
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
            $("#fleetSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
			    filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Fleet No',filtertype:'input',columntype:'textbox', datafield: 'fleet_no', width: '20%' },
							{ text: 'Fleet Name',filtertype:'input',columntype:'textbox', datafield: 'flname', width: '35%'},
							{ text: 'Chassis No',filtertype:'input',columntype:'textbox', datafield: 'chassisno', width: '15%'},
							{ text: 'Reg No',filtertype:'input',columntype:'textbox', datafield: 'reg_no', width: '15%'},
							{ text: 'Plate Code',filtertype:'input',columntype:'textbox',datafield:'platecode',width:'15%'},
							{ text: 'Sales Price', datafield: 'salesprice', width: '9.71%',cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Dep Posted', datafield: 'dep_posted', width: '9.71%',cellclassname:'column',editable:false ,cellsformat:'dd.MM.yyyy',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Purchase Value', datafield: 'pur_value', width: '9.71%',cellclassname:'column',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Acc.Dep', datafield: 'acc_dep', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Current Dep',datafield:'cur_dep', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Net Book',datafield:'netbook', width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true},
							{ text: 'Net P /(L)',  datafield:'net_pl',width: '9.71%',cellclassname:'column' ,editable:false,cellsformat:'d2',cellsalign:'right',align:'right',hidden:true}
							
							]
            });
           
           	$('#fleetSearch').on('rowdoubleclick', function (event) {
        		var row2=event.args.rowindex;
           		var row5=document.getElementById("disposalrow").value;
           		var fleetno=$('#fleetSearch').jqxGrid('getcellvalue', row2, "fleet_no");
           		var fleetname=$('#fleetSearch').jqxGrid('getcellvalue', row2, "flname");
           		var reg_no=$('#fleetSearch').jqxGrid('getcellvalue', row2, "reg_no");
           	
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "fleet_no", fleetno);
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "flname", fleetname);
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "reg_no", reg_no);
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "salesprice", $('#fleetSearch').jqxGrid('getcellvalue', row2, "salesprice"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "dep_posted", $('#fleetSearch').jqxGrid('getcellvalue', row2, "dep_posted"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "pur_value", $('#fleetSearch').jqxGrid('getcellvalue', row2, "pur_value"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "acc_dep", $('#fleetSearch').jqxGrid('getcellvalue', row2, "acc_dep"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "cur_dep", $('#fleetSearch').jqxGrid('getcellvalue', row2, "cur_dep"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "netbook", $('#fleetSearch').jqxGrid('getcellvalue', row2, "netbook"));
               	$("#disposalGrid").jqxGrid('setcellvalue', row5, "net_pl", $('#fleetSearch').jqxGrid('getcellvalue', row2, "net_pl"));
               	$("#disposalGrid").jqxGrid('addrow', null, {});
               
               	var fleetno="";
               	var fleetrows=$("#disposalGrid").jqxGrid('getrows');
               	for(var i=0;i<fleetrows.length;i++){
               		var strfleetno=$("#disposalGrid").jqxGrid('getcellvalue',i,'fleet_no');
               		if(strfleetno!="" && strfleetno!="undefined" && strfleetno!=null && typeof(strfleetno)!="undefined"){
               			if(i==0){
	               			fleetno+=strfleetno;
	               		}	
	               		else{
	               			fleetno+=","+strfleetno;
	               		}
               		}
               		
               	}
               	$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("salesinvtrno").value+'&id=2&fleetno='+fleetno);
               	$('#fleetwindow').jqxWindow('close');
               
            }); 
        
        });
    </script>
    <div id="fleetSearch"></div>