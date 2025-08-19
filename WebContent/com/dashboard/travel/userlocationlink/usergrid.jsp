<%@ page import="com.dashboard.travel.userlocationlink.ClsUserLocationLinkDAO" %>  
<%ClsUserLocationLinkDAO DAO=new ClsUserLocationLinkDAO(); %> 
 <%
 String id = request.getParameter("id")==null?"0":request.getParameter("id"); 

 %>
 <script type="text/javascript">
 var data2;
       data2='<%=DAO.userdata(id)%>';  
        $(document).ready(function () { 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'String'  },
							{name : 'userid', type: 'String'  },
                         	{name : 'uname', type: 'String'  },
                 			{name : 'urole', type: 'String'  },
                 			{name : 'email', type: 'String'  },
                 			
     						 ],  
                          	localdata: data2,
                
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
            $("#jqxusergrid").jqxGrid(
            { 
            	width: '100%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                showfilterrow:true,
                filterable: true,  
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:true,
               
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  }, 
							{ text: 'Doc NO', datafield: 'docno', editable: false,width:'5%',hidden:true },   
							{ text: 'User ID', datafield: 'userid', editable: false }, 
							{ text: 'User Role', datafield: 'urole', editable: false,width:'10%' },  
							{ text: 'User Name', datafield: 'uname', editable: false },     
                            { text: 'Email', datafield: 'email', editable: false },
							
							],        
				
            });
            $("#jqxusergrid").jqxGrid('addrow', null, {}); 
            $('#jqxusergrid').on('rowdoubleclick', function (event) {   
  		        var datafield = event.args.datafield;  
  		        var rowindextemp = event.args.rowindex;
  		        document.getElementById("txtuserdoc").value=$("#jqxusergrid").jqxGrid('getcellvalue', rowindextemp, "docno");
              var pass=$("#jqxusergrid").jqxGrid('getcellvalue', rowindextemp, "docno");
              //alert(pass);
              $("#locdiv").load("locationgrid.jsp?docno="+pass+"&id=1");
              if(pass>0){
               $('#btnupdate').attr('disabled', false);  
              }
              	
                  }); 
            
        });
    </script>
    <div id="jqxusergrid"></div>  
   <input type="hidden" id="rowindex"/> 