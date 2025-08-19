<%@page import="com.dashboard.operations.drivertimesheet.*"%>
<%
	ClsDriverTimeSheetDAO DAO= new ClsDriverTimeSheetDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String drivername = request.getParameter("drivername")==null?"0":request.getParameter("drivername");
 String drid = request.getParameter("drid")==null?"0":request.getParameter("drid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");%>

 
<script type="text/javascript">
	   var id='<%=id%>';
	   
	   if(id==1){
       var data2= '<%=DAO.driverDetailsSearch(drid, drivername, contactno)%>'; 
	   }else{
		   data2=[];
	   }
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'string'   },
							{name : 'mobno', type: 'string'  },
							{name : 'dr_id', type: 'int'   },
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverDetailsMultiSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'checkbox',
                
                columns: [
						{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,datafield: '',
						    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
						    cellsrenderer: function (row, column, value) {
						  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						},
						{ text: 'Driver Name', datafield: 'name', width: '60%' },
						{ text: 'Contact', datafield: 'mobno', width: '35%' },
						{ text: 'Doc No',  datafield: 'dr_id', hidden: true, width: '5%' },
						]
            });
            
        });
    </script>
    <div id="driverDetailsMultiSearch"></div>
 