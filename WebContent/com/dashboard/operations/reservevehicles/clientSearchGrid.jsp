<%@page import="com.dashboard.operations.reservevehicles.ClsReserveVehicleDAO" %>
<% ClsReserveVehicleDAO DAO=new ClsReserveVehicleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 String mob="";
 %>
<script type="text/javascript">
        
        var data4;
        var chk=<%=chk%>
        if(chk==1){
        	
        	data4= '<%=DAO.getClientDetails(chk,clname,mob)%>';
        }
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'   },
     						{name : 'refname', type: 'string'   },
     						{name : 'per_mob', type: 'string'   }
                        ],
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
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
                          
							{ text: 'Doc No',  datafield: 'cldocno', hidden: true, width: '10%' },
							{ text: 'Client', datafield: 'refname', width: '75%' },
							{ text: 'Mob No', datafield: 'per_mob', width: '20%' },
						]
            });
            
             $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("cldocno").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("client").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "refname"); 
                
            	$('#clientToWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientSearchGridID"></div>
 