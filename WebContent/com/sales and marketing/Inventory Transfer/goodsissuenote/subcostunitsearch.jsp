<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<%@page import="com.sales.InventoryTransfer.goodsissuenote.ClsGoodsissuenoteDAO"%>
<% ClsGoodsissuenoteDAO searchDAO = new ClsGoodsissuenoteDAO(); %> 

 
 <%

String typedocno=request.getParameter("docno")==null?"0":request.getParameter("docno");
 String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 String refnames=request.getParameter("refnames")==null?"0":request.getParameter("refnames");
 String site=request.getParameter("site")==null?"0":request.getParameter("site");
 String search=request.getParameter("search")==null?"0":request.getParameter("search");
 

%>
 
 

 
 
<script type="text/javascript">



            	
        $(document).ready(function () { 	
        	var costunit;

        	var temps='<%=search%>';

        	if(temps=="yes")
        		{
        		costunit='<%=searchDAO.costunitsearch(session,typedocno,docnoss,refnames,search,site) %>'; 
        		temps="";
        		}
        	else
        		{
        		costunit; 
        		}


 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'tr_no', type: 'int'},   
                             {name : 'doc_no', type: 'int'},  
     		 				{name : 'customer', type: 'string'},
     						 
     			 
     						{name : 'prjname', type: 'string'   },
     						
     						{name : 'cldocno', type: 'string'   },
     						{name : 'site', type: 'string'   },
     						{name : 'siteid', type: 'string'   },
     					 
     				 
     						
     						
     						
     											
                 ],
                 localdata: costunit,
                
                
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

            
            
            $("#costunitsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                         
							{ text: 'DocNo', datafield: 'doc_no', width: '10%', editable: false },	
							{ text: 'Customer', datafield: 'customer', width: '50%' , editable: false},
							{ text: 'Ref Type', datafield: 'prjname', width: '20%', editable: false },
							
				
							{ text: 'cldocno', datafield: 'cldocno', width: '40%', editable: false ,hidden:true },
							{ text: 'site', datafield: 'site', width: '20%', editable: false    },
							{ text: 'siteid', datafield: 'siteid', width: '40%', editable: false ,hidden:true  },
		 
							
							{ text: 'tr_no', datafield: 'tr_no', width: '40%', editable: false,hidden:true  },	
							
							
							
			              ]
            
            
            });
            
            
            $('#costunitsearch').on('rowdoubleclick', function (event) {
         	   
         	   var rowindex1 = event.args.rowindex;      
                document.getElementById("itemdocno").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	   document.getElementById("itemname").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "prjname");
             	   
             	  document.getElementById("clientname").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "customer");
             	 document.getElementById("cldocno").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	 document.getElementById("site").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "site");
             	 document.getElementById("siteid").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "siteid");
             	 
             	 
             	 document.getElementById("costtr_no").value=$('#costunitsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	
             	 
                 $('#searchwindow').jqxWindow('close'); 
             });  
            
               
         
            
            
        
        
      
   
        });
    </script>
    <div id=costunitsearch></div>
 