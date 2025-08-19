<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.clientrelations.clientprivilege.ClsClientPrivilegeDAO"%>
<%
ClsClientPrivilegeDAO cd=new ClsClientPrivilegeDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var datas;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   datas='<%=cd.getPrivilege()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'per', type: 'string' }
   						
   						               ],
               localdata: datas,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          var list = ['GCC', 'IDP','UAE'];
        
          $("#jqxPrivilege").jqxGrid(
          {
              
              						
				
                        width: '99%',
                        height: 300,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
        					 { text: 'Doc No', datafield: 'doc_no', width: '30%' },
        					 { text: 'Privilege', datafield: 'name' },
        					 { text: 'Percentage', datafield: 'per' },
        					
        					
        					]
                    });
          //Add empty row          
          /* if(temp==0){   
         	   $("#jqxPrivilege").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxPrivilege").jqxGrid('disabled', true);
             } */
             $('#jqxPrivilege').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		                document.getElementById("docno").value= $('#jqxPrivilege').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("privilege").value = $("#jqxPrivilege").jqxGrid('getcellvalue', rowindex1, "name");
     		                document.getElementById("percentage").value = $("#jqxPrivilege").jqxGrid('getcellvalue', rowindex1, "per");
     		                 }); 
     		  

    	
   
});
      
</script>
<div id="jqxPrivilege"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 