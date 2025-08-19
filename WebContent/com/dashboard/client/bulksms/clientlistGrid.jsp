<% String contextPath=request.getContextPath();%>
<%@page import="com.dashboard.client.bulksms.ClsBulkSMSDAO"%>
<%ClsBulkSMSDAO DAO= new ClsBulkSMSDAO(); %>
<%   String catid = request.getParameter("catid")==null?"":request.getParameter("catid").trim();
     String salid = request.getParameter("salid")==null?"":request.getParameter("salid").trim();
     String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>
<style type="text/css">
  .AClass
  {
      background-color: #FBEFF5;
  }
  .BClass    
  {
      background-color: #E0F8F1;
  }
  .CClass
  {
     background-color: #f3fab9;
  }
    .DClass
  {
     background-color: #ff9696 ;  
  }
</style>
<script type="text/javascript">
        var data;      
        $(document).ready(function () {    	      
           
        	 var temp='<%=branchval%>';
             
     	  	 if(temp!='NA'){ 
           	     data='<%=DAO.clientGridLoading(branchval,catid,salid,check)%>';              
          	 } 
                          
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{ name: 'category', type: 'string' },
		                    { name: 'cldocno', type: 'number' },
		                    { name: 'refname', type: 'string' },
		                    { name: 'per_mob', type: 'string' },
		                    { name: 'sal_name', type: 'string' },
		                    { name: 'mail1', type: 'string' },
     								
                 ],
                 localdata: data,
                                        
            };
            var cellclassname = function (row, column, value, data) {
       		 if (data.per_mob=="0" || data.per_mob=="") {                
                  return "DClass";
              }   
            };    
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {    
	                    alert(error);    
	                    }
		            });
            
            $("#jqxclientGrid").jqxGrid(
            {
            	width: '99.5%',
                height: 550,  
                source: dataAdapter,
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'checkbox',
                editable: false,
                enabletooltips: true, 
                showfilterrow:true,    
                
                columns: [	
							{ text: 'Client Code',  datafield: 'cldocno', width: '8%',cellclassname:cellclassname },
							{ text: 'Name',  datafield: 'refname',cellclassname:cellclassname},
							{ text: 'Category',  datafield: 'category', width: '10%',cellclassname:cellclassname },   
							{ text: 'Salesman',  datafield: 'sal_name', width: '16%',cellclassname:cellclassname },   
							{ text: 'Mobile',  datafield: 'per_mob', width: '14%',cellclassname:cellclassname },
							{ text: 'Email Id',  datafield: 'mail1', width: '14%',cellclassname:cellclassname },        
	              ]
            });
                
            $("#overlay, #PleaseWait").hide(); 
});       
</script>
<div id="jqxclientGrid"></div>    