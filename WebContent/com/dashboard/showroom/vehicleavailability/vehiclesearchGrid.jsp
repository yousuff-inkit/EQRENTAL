<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.showroom.vehicleavailability.ClsVehicleAvailabilityDAO" %>
<%
         ClsVehicleAvailabilityDAO DAO= new ClsVehicleAvailabilityDAO();   
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();  
		 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();  
 %>   
<script type="text/javascript">
  
var vehdata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
              vehdata='<%=DAO.vehicleSearch(session)%>';                 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'flname', type: 'String'  },
                        	{name : 'fleet_no', type: 'String'  },
                        	{name : 'reg_no', type: 'String'  },  
                        	{name : 'doc_no', type: 'number'  },  
                 ],
                 localdata: vehdata,  
                
                
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

            
            $("#jqxVehicleGrid").jqxGrid(  
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlerow',      
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Fleet No', datafield: 'fleet_no',editable:false, width: '25%'},    
                            { text: 'Reg No', datafield: 'reg_no',editable:false, width: '25%'},
                            { text: 'Name', datafield: 'flname',editable:false},   
                            { text: 'doc_no', datafield: 'doc_no',editable:false, width: '5%',hidden:true},  
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxVehicleGrid').on('rowdoubleclick', function (event) {           
           	  var rowindex1=event.args.rowindex;      
           	  document.getElementById("hidvehid").value=$('#jqxVehicleGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           	  document.getElementById("txtvehicle").value=$('#jqxVehicleGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+" - "+$('#jqxVehicleGrid').jqxGrid('getcellvalue', rowindex1, "flname");  
          });
        });
    </script>
    <div id="jqxVehicleGrid"></div>          