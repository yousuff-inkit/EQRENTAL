<%@page import="com.dashboard.workshop.vehiclerepairhistory.*" %>
 <% ClsVehicleRepairHistoryDAO DAO=new ClsVehicleRepairHistoryDAO(); %> 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String regno = request.getParameter("regno")==null?"":request.getParameter("regno");
 String flno = request.getParameter("flno")==null?"":request.getParameter("flno");
 String flname = request.getParameter("flname")==null?"":request.getParameter("flname");
 String id = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
		var id='<%=id%>';
		var data3;
		if(id=='1'){
			 data3=<%=DAO.vehicleSearchData(flname,regno,flno, id)%>;			 
		}else{
			data3=[];
		}
		
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'},
							{name : 'regno', type: 'String'},
     						{name : 'fleetno', type: 'string'},
     						{name : 'name', type: 'string'}
                        ],
                		 localdata: data3,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#vehicleSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
                          
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
							{ text: 'Asset id',  datafield: 'regno', width: '15%' },
							{ text: 'Fleet No',  datafield: 'fleetno', width: '15%' },
							{ text: 'Fleet Name', datafield: 'name', width: '65%' },
							{ text: 'docno', datafield: 'doc_no', width: '5%',hidden:true }
						]
            });
            
             $('#vehicleSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("flnames").value =$('#vehicleSearchGrid').jqxGrid('getcellvalue',rowindex1,'name');
             	document.getElementById("fldocno").value =$('#vehicleSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
            	$('#vehicleToWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="vehicleSearchGrid"></div>