<%@page import="com.dashboard.operations.gateinpasscreate.ClsGateinpassCreateDAO" %>
<% ClsGateinpassCreateDAO DAO=new ClsGateinpassCreateDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.clientData(clientname, check)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'},
     						{name : 'clientname', type: 'string'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '20%' },
							{ text: 'Client', datafield: 'clientname', width: '80%' }
						]
            });
            
             $('#clientGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("cldocno").value = $('#clientGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("clientname").value = $('#clientGridID').jqxGrid('getcellvalue', rowindex1, "clientname");
				
            	$('#clientwindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="clientGridID"></div>