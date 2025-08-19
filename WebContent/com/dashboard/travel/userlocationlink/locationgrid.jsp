<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.dashboard.travel.userlocationlink.ClsUserLocationLinkDAO" %>
<%
ClsUserLocationLinkDAO cd=new ClsUserLocationLinkDAO();
%>

<% String docno = request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
 <%
 String id = request.getParameter("id")==null?"0":request.getParameter("id"); 

 %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 
        //alert(temp);
      	
         	   driverdata='<%=cd.locationdata(id,docno)%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'docno', type: 'string'  },
   						{name : 'val', type: 'bool'},
   						{name : 'lname', type: 'string'  },
   						{name : 'rowno', type: 'string'  }
   						               ],
               localdata: driverdata,
                                      
          };
          /*   $("#jqxLocation").on("bindingcomplete", function (event) {
          var datafield = event.args.datafield;
           if(datafield=='val'){
        $('#jqxLocation').jqxGrid('setcolumnproperty','val',checked:'true',true);
        }
        });*/
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
        
          $("#jqxLocation").jqxGrid(
          {
              
              						
				
                        width: '100%',
                        height: 300,
                        source: dataAdapter,
             			editable:true,
             			//columnsresize: true,
                		showfilterrow:true,
                		filterable:true,
                		enableAnimations: true,
		                enabletooltips:true,
		                filtermode:'excel',		    
		                sortable:true,
		                selectionmode: 'none',
		                
		               
             			
             			
             			
                        columns: [
        					 { text: '', datafield: 'val',columntype:'checkbox',editable:true,width:'5%'},
        					 { text: 'Doc No', datafield: 'docno',editable: true,width:'10%',hidden:true},
        					 { text: 'Location Name', datafield: 'lname',editable: true},
        					  { text: 'rowno', datafield: 'rowno',editable: true,hidden:true },
        					
        					]
                    });
                      /*$("#jqxLocation").jqxGrid('addrow', null, {}); */
          //Add empty row          
          
            
          
             
     		
      });             
              
      
</script>
<div id="jqxLocation"></div>
