<%@page import="com.dashboard.trafficfine.trafficfineclientwise.*" %>
 <%
  ClsTrafficFineClientWiseDAO trafficdao=new ClsTrafficFineClientWiseDAO();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String lcno = request.getParameter("lcno")==null?"0":request.getParameter("lcno");
 String passno = request.getParameter("passno")==null?"0":request.getParameter("passno");
 String nation = request.getParameter("nation")==null?"0":request.getParameter("nation");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
 %> 

 <script type="text/javascript">
 
 var clientsearchdata;
 var id='<%=id%>';
  if(id=="1"){ 
	  clientsearchdata='<%=trafficdao.getClient(branch,clname,mob,lcno,passno,nation,dob,id)%>';  
  }
  else{
	  
  }
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
     						
      					
     						
                          	],
                          	localdata: clientsearchdata,
          
				
                
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
            $("#jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
					{ text: 'NAME', datafield: 'refname', width: '16%' },
					{ text: 'DRIVER NAME', datafield: 'drname', width: '14%' },
					{ text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'MOB', datafield: 'per_mob', width: '9%' },
					{ text: 'TEL', datafield: 'per_tel', width: '8%' },
					{ text: 'LICENCE', datafield: 'dlno', width: '9%' },
					{ text: 'NATION', datafield: 'nation', width: '9%' },
					{ text: 'ADDRESS', datafield: 'address', width: '21%' }
			
					
					 

					
					]
            });
    var rows=$("#jqxclientsearch").jqxGrid('getrows');
    if(rows.length==0){
    	$("#jqxclientsearch").jqxGrid('addrow', null, {});
    }
            
      
				            
				           $('#jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex1=event.args.rowindex;
				            	document.getElementById("client").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname"); 
				            	document.getElementById("cldocno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				              $('#clientwindow').jqxWindow('close');
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxclientsearch"></div>