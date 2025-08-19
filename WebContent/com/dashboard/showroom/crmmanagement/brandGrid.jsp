<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.showroom.crmmanagement.ClsCrmManagementDAO" %>
<%
        ClsCrmManagementDAO DAO= new ClsCrmManagementDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
%>   
<script type="text/javascript">
  
var brddata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
             brddata='<%=DAO.brandGridLoad(session,id)%>'; 
            var source =
            {
                datatype: "json",
                datafields: [
                        	{name : 'brand', type: 'String'  }, 
                        	{name : 'model', type: 'String'  }, 
                        	{name : 'doc_no', type: 'String'  }, 
                 ],
                 localdata: brddata,  
                
                
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

            
            $("#jqxBrandGrid").jqxGrid(  
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: false,
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
                            { text: 'Brand', datafield: 'brand',editable:false,width:'45%'},  
                            { text: 'Model', datafield: 'model',editable:false },   
                            { text: 'doc_no', datafield: 'doc_no',editable:false,width:'5%',hidden:true},   
			     ]
            });
            $("#overlay, #PleaseWait").hide();   
        });
    </script>
    <div id="jqxBrandGrid"></div>     