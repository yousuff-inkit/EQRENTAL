
<%@page import="com.dashboard.invoices.bulkinvoice.*" %>
 <%
 ClsBulkInvoiceDAO rentaldao=new ClsBulkInvoiceDAO();
String id = request.getParameter("id")==null?"":request.getParameter("id");
%> 

 <script type="text/javascript">
 
 var projectdata=[];

  var id='<%=id%>';
  if(id=="1"){ 
	  projectdata='<%=rentaldao.getProject(id)%>';  
  }
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  }, 
     						{name : 'project_name', type: 'String'  }
     						
                          	],
                          	localdata:projectdata,
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
            $("#projectSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	filterable:true,
            	showfilterrow:true,
            
     					
                columns: [
					{ text: 'PROJECT NO', datafield: 'doc_no', width: '30%' },
					{ text: 'NAME', datafield: 'project_name', width: '70%' }					]
            });
    		
            $('#projectSearchGrid').on('rowdoubleclick', function (event) 
			{ 
				var rowindex1=event.args.rowindex;
				document.getElementById("project").value=$('#projectSearchGrid').jqxGrid('getcellvalue', rowindex1, "project_name"); 
				document.getElementById("hidproject").value=$('#projectSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
				$('#projectwindow').jqxWindow('close');
			}); 	 
		}); 
				       
                       
    </script>
    <div id="projectSearchGrid"></div>
    
    </body>
</html>