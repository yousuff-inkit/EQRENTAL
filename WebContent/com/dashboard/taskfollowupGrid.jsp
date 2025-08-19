<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>           
 <script type="text/javascript">
 var data1;    
         data1 ='<%=DAO.loadflwupgrid(docno, id) %>';                       
         $(document).ready(function () {         
      
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'date', type: 'date' },  
     						{name : 'user', type: 'String'},
     						{name : 'asuser', type: 'String'},
     						{name : 'remark', type: 'String'},
     						{name : 'status', type: 'String'},
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#taskfollowupGrid").jqxGrid({ 
            	width: '100%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                enabletooltips:true,
                columnsresize: true,            		  
                columns: [
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy HH:mm'},
							{ text: 'User', datafield: 'user', width: '18%' },
							{ text: 'Assigned To', datafield: 'asuser', width: '18%' },
							{ text: 'Status', datafield: 'status', width: '18%' },
							{ text: 'Remarks', datafield: 'remark', width: '38%'},       
					]
            });
        });
</script>
<div id="taskfollowupGrid"></div>