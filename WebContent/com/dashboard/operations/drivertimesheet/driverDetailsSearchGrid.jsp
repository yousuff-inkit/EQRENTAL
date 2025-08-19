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
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 %>
<script type="text/javascript">
		var id='<%=id%>';
		var data1=[];
		if(id==1){
      	  data1= '<%=DAO.driverDetailsSearch(drid, drivername, contactno)%>';  
		}else{
			data1=[];
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
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
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
            
             $('#driverDetailsSearch').on('rowdoubleclick', function (event) {
                 var rowindex2 = event.args.rowindex;
                 
                 if($('#txtorgridclick').val()=='1') {
                	 document.getElementById("txtdriverdocno").value = $('#driverDetailsSearch').jqxGrid('getcellvalue', rowindex2, "dr_id");
  	            	 document.getElementById("txtdrivername").value = $('#driverDetailsSearch').jqxGrid('getcellvalue', rowindex2, "name");
                 } else if($('#txtorgridclick').val()=='2') {
                	 var rowindex1 =$('#rowindex').val();
                	 $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindex1, "drid" ,$('#driverDetailsSearch').jqxGrid('getcellvalue', rowindex2, "dr_id"));
                     $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindex1, "drname" ,$('#driverDetailsSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                 } 
                 
            	$('#driverDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="driverDetailsSearch"></div>
 