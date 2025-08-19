<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.project.execution.ServiceSale.*" %>



	
<%

ClsServiceSaleDAO viewDAO=new ClsServiceSaleDAO();
 
String dtype1 = request.getParameter("costtype").toString(); 
%> 
       <script type="text/javascript">
  
       var costcode= '<%=viewDAO.searchCostcode(dtype1) %>';
		
  	 
  	 $(document).ready(function () { 	
 
        	
           
           
            var source =
            {
                datatype: "json",  
                datafields: [
                             {name : 'name', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'reg_no', type: 'string'  }
     						
                        ],
            
                 localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 360,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [

							 
                              { text: 'Docno', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Cost Group', datafield: 'name'  },
                              
                              { text: 'Reg NO', datafield: 'reg_no'  },
                           
                              
						
	             
						]
            });
            
               if($('#costcodeSearch').jqxGrid('getcellvalue', 0, "reg_no")=="0")
            	{
            	
            	   $('#costcodeSearch').jqxGrid('hidecolumn', 'reg_no');
            	}
            else
            	{
            	 $('#costcodeSearch').jqxGrid('showcolumn', 'reg_no');
            	
            	}
            
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costcode" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));
              /*   $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "costgroup" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup")); */
                
                
              $('#costcodesearchwndow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 