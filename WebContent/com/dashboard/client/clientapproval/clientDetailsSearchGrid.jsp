<%@ page import="com.dashboard.client.clientapproval.ClsClientApprovalDAO" %>
<% ClsClientApprovalDAO DAO=new ClsClientApprovalDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.clientDetailsSearch(clientname, contactNo,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'description', type: 'string'  },
     						{name : 'per_mob', type: 'int'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientDetailsSearchGridId").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Client Name', datafield: 'description', width: '70%' },
							{ text: 'Contact', datafield: 'per_mob', width: '30%' },
						]
            });
            
             $('#clientDetailsSearchGridId').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcldocno").value = $('#clientDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtclientname").value = $('#clientDetailsSearchGridId').jqxGrid('getcellvalue', rowindex1, "description");
          	    
            	$('#clientDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientDetailsSearchGridId"></div>
 