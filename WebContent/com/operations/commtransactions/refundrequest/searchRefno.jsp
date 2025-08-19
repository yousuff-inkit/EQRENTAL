<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.commtransactions.refundrequest.ClsRefundRequestDAO"%>
<% ClsRefundRequestDAO DAO= new ClsRefundRequestDAO(); %>   
<%
   String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");   
   String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id");
   String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
   String reftype = request.getParameter("reftype")==null || request.getParameter("reftype")==""?"0":request.getParameter("reftype");
%> 
 <script type="text/javascript">          
 var cldata;   
 cldata='<%=DAO.searchRefno(session,clname,reftype,id,brhid)%>';                      
        $(document).ready(function () { 
            var num = 0; 
            var source =   
            {
                datatype: "json",
                datafields: [
     						  {name : 'refname', type: 'String'},
     						  {name : 'docno', type: 'String'}, 
     						  {name : 'vocno', type: 'String'},      
                          	],
                          	localdata: cldata,
                          //	 url: url1,
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
            $("#Jqxrefnosearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns: [
                           { text: 'Doc No', datafield: 'vocno', width: '20%' },
                           { text: 'Doc No', datafield: 'docno', width: '10%',hidden:true },        
					       { text: 'Customer', datafield: 'refname', width: '80%' },   
					]  
            });
		    $('#Jqxrefnosearch').on('rowdoubleclick', function (event){   
				  var rowindex1=event.args.rowindex;
				  document.getElementById("refno").value= $('#Jqxrefnosearch').jqxGrid('getcellvalue', rowindex1, "vocno");
				  document.getElementById("refdocno").value= $('#Jqxrefnosearch').jqxGrid('getcellvalue', rowindex1, "docno");
				  document.getElementById("txtclientname").value=$('#Jqxrefnosearch').jqxGrid('getcellvalue', rowindex1, "refname");
				  var serdocno= $('#Jqxrefnosearch').jqxGrid('getcellvalue', rowindex1, "docno");  
				  if($('#cmbreftype').val()=="T"){  
			             $("#tourdiv").load("tourDetails.jsp?rdocno="+serdocno+"&check="+1+"&refund="+0);   
			      }else if($('#cmbreftype').val()=="A"){
			    		$("#ticketdiv").load("ticketGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+0);  
			      }else if($('#cmbreftype').val()=="V"){  
			             $("#hoteldiv").load("hotelGrid.jsp?rdocno="+serdocno+"&id="+1+"&refund="+0);    
			      }else{}
				  $('#refnosearch').jqxWindow('close');  
			}); 	 
		}); 
    </script>  
    <div id="Jqxrefnosearch"></div>   