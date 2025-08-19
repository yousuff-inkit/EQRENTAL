<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.showroom.vehicleavailability.ClsVehicleAvailabilityDAO" %>
<%
        ClsVehicleAvailabilityDAO DAO= new ClsVehicleAvailabilityDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
%>   
<script type="text/javascript">
  
var vatdata;
var id='<%=id%>';
if(parseInt(id)>0){
	vatdata=[ {
		"reg_no": "47197",
		"fleet_no": "12793",
		"flname": "BMW 750 Li",
		"eng_no": "20941784",
		"ch_no": "WBA7F21107JB005223",
		"brand": "BMW",
		"model": "BMW 750 Li"
	}, {
		"reg_no": "79473",
		"fleet_no": "12793",
		"flname": "BMW X5 3.0",
		"eng_no": "20941784",
		"ch_no": "WBAKR0108E0J01224",
		"brand": "BMW",
		"model": "BMW X5 3.0"
	}, {
		"reg_no": "36919",
		"fleet_no": "12793",
		"flname": "CANTER LB 4.2T S/CAB DRY BOX+TAIL LIFT",
		"eng_no": "4D33P85873",
		"ch_no": "JL7B6G1P3HK004476",
		"brand": "MITSUBISHI",
		"model": "CANTER LWB 4.2 DIESEL"
	}];
}else{
	vatdata;
}
$(document).ready(function () {      	
             var num = 1; 
        		<%--  vatdata='<%=DAO.maintGridLoad(session,id)%>'; --%>            
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'reg_no', type: 'String'  },   
                	{name : 'fleet_no', type: 'String'  }, 
                	{name : 'flname', type: 'String'  }, 
                	{name : 'eng_no', type: 'String'  }, 
                	{name : 'ch_no', type: 'String'  }, 
                	{name : 'brand', type: 'String'  }, 
                	{name : 'model', type: 'String'  },  
                 ],
                 localdata: vatdata,  
                
                
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

            
            $("#jqxVAGrid").jqxGrid(  
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	//showaggregates: true,
             	//showstatusbar:true,
             	//statusbarheight:25,
       
                columns: [
	                	 { text: 'SL#', sortable: false, filterable: false, editable: false,
	                         groupable: false, draggable: false, resizable: false,  
	                         datafield: 'sl', columntype: 'number', width: '4%',
	                         cellsrenderer: function (row, column, value) {
	                             return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                         }  
	                       },	
	                       { text: 'Reg No', datafield: 'reg_no',editable:false,width:'8%'},  
	                       { text: 'Fleet No', datafield: 'fleet_no',editable:false,width:'8%'},  
	                       { text: 'Fleet', datafield: 'flname' ,editable:false},
	                   	   { text: 'Eng No', datafield: 'eng_no', width: '8%' ,editable:false},
	                   	   { text: 'Ch No', datafield: 'ch_no', width: '10%' ,editable:false},
	                   	   { text: 'Brand', datafield: 'brand', width: '15%' ,editable:false},
	                   	   { text: 'Model', datafield: 'model', width: '15%' ,editable:false},     
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxVAGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex;    
             	  document.getElementById("hiddocno").value=$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
             	  document.getElementById("lblname").value=$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+" - "+$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "flname");  
            	  $('.textpanel p').text($('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+' - '+$('#jqxVAGrid').jqxGrid('getcellvalue', rowindex1, "flname"));
             	  $('.comments-container').html('');      
            });
        });
    </script>
    <div id="jqxVAGrid"></div>   