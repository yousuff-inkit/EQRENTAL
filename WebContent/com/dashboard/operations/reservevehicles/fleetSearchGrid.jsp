<%@ page import="com.dashboard.operations.reservevehicles.ClsReserveVehicleDAO"%>
<%
ClsReserveVehicleDAO DAO=new ClsReserveVehicleDAO();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String regno = request.getParameter("regno")==null?"":request.getParameter("regno");
String flname = request.getParameter("flname")==null?"":request.getParameter("flname");
String color = request.getParameter("color")==null?"":request.getParameter("color");
String group = request.getParameter("group")==null?"":request.getParameter("group");
String id = request.getParameter("id")==null?"":request.getParameter("id");
String masterrefno= request.getParameter("masterrefno")==null?"":request.getParameter("masterrefno");
%>
<script type="text/javascript">
var id='<%=id%>';
var vehdata=[];
if(id=="1"){
	vehdata='<%=DAO.vehSearch(branch,fleetno,regno,flname,color,group,id,masterrefno)%>';
}
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'color', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'gname', type: 'String'  },
     						{name : 'kmin', type: 'number'  },
     						{name : 'fin', type: 'String'  },
     						{name : 'a_loc', type: 'String'  },
     						{name : 'gid', type: 'String'  },
     						{name : 'platecode',type:'string'}
     				                        	
                          	],
             
                          	localdata: vehdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxfleetsearch").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
                pagermode: 'default',
              
	
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					{ text: 'FLEETNO', datafield: 'fleet_no', width: '13%' },
					{ text: 'REGNO', datafield: 'reg_no', width: '17%' },
					{ text: 'NAME', datafield: 'flname', width: '35%'  },
					{ text: 'COLOR', datafield: 'color', width: '17%' },
					{ text: 'GROUP', datafield: 'gname', width: '18%' },
					{ text: 'Location', datafield: 'a_loc', width: '15%',hidden:true},
					{ text: 'GID', datafield: 'gid', width: '15%',hidden:true},
					{ text: 'KM', datafield: 'kmin', width: '15%',hidden:true},
					{ text: 'fin', datafield: 'fin', width: '15%',hidden:true},
					{ text: 'Plate Code',datafield:'platecode',width:'15%',hidden:true}
					]
            });
            
            $('#jqxfleetsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
              	//checkBrandQty($('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"),$('#hidmasterrefno').val());
            	document.getElementById("fleetno").value=$('#jqxfleetsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            	
                $('#fleetToWindow').jqxWindow('close');
                
            }); 
      
        });
  
  		
    </script>
    <div id="jqxfleetsearch"></div>