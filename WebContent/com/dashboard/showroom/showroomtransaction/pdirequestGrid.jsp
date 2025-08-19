<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.showroom.showroomtransaction.ClsShowroomTransactionDAO" %>
<%
		ClsShowroomTransactionDAO DAO= new ClsShowroomTransactionDAO();     
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
%>   
<script type="text/javascript">  
  
var quesdata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1; 
             quesdata='<%=DAO.pdirequestGridLoad(session,id)%>';                
            var source =
            {
                datatype: "json",
                datafields: [
                        	{name : 'description', type: 'String'  }, 
                        	{name : 'rowno', type: 'String'  }, 
                 ],
                 localdata: quesdata,  
                
                
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

            
            $("#jqxPDIGrid").jqxGrid(  
            {
                width: '100%',
                height: 155,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'checkbox',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Description', datafield: 'description',editable:false },  
                            { text: 'rowno', datafield: 'rowno',editable:false,width:'5%',hidden:true},   
			     ]
            });
            $("#overlay, #PleaseWait").hide();   
        });
    </script>
    <div id="jqxPDIGrid"></div>     