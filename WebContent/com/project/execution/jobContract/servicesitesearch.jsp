<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 int type=request.getParameter("type")==null?0:Integer.parseInt(request.getParameter("type").trim());
 %>

 <script type="text/javascript">
 
 var serviceType;

 var rowIndex='<%=rowIndex%>';
 var type='<%=type%>';
   <%-- serviceType='<%=DAO.serviceSite(session)%>'; --%>
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        	serviceType=getSte();	 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

							{name : 'docno', type: 'String'  },
							{name : 'site', type: 'String'  },
     						
     						
                          	],
                          	localdata: serviceType,
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
            $("#jqxsitesearch").jqxGrid(
            {
                width: '95%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '21%' },
					{ text: 'Service Site', datafield: 'site', width: '75%' }
					
					 
					
					]
            });
    		            
				           $('#jqxsitesearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 		/* $('#siteGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
				               			$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "siteid",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				               			$("#siteGrid").jqxGrid('addrow', null, {}); */
				              	if(type==1){
			            	 		document.getElementById("srvsite").value=$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site");
			                        document.getElementById("siteid").value=$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "docno");
			               			//$("#serviceGrid").jqxGrid('addrow', null, {});
			              	}
			              	if(type==2){
			              		$('#servserGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
			                	$('#servserGrid').jqxGrid('setcellvalue', rowIndex, "siteid",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
			              	}
				                $('#siteinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

        function addArea(){
        	
        	var formname='Service Settings';
        	var formcode='SERS';
        	var lblname='Service Area Settings';
        	var lbldrp='area';
        	var detName='Service Settings';
        	
        	 var url=document.URL;
		     var reurl=url.split("com");
		     var path1='com/controlcentre/settings/ServiceSettings/serviceSettings.jsp';
        	var path= path1+"?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"&mode=A";
			  
			   top.addTab( detName,reurl[0]+""+path);
        	
        	<%-- window.open("<%=contextPath%>/com/controlcentre/settings/ServiceSettings/serviceSettings.jsp?formname="+formname+"&formcode="+formcode+"&lblname="+lblname+"&lbldrp="+lbldrp+"","Service Settings","menubar=0,resizable=1,width=1000,height=580 ,top=100, left=260"); --%>
      
        }
        function getSte(){
        	
       	 var rows1 = $("#siteGrid").jqxGrid('getrows');
       	 var jasond = '{"theTeam":[]}';
       	 for(var i=0 ; i < rows1.length ; i++){
					
       		 if(typeof(rows1[i].site) != "undefined" && typeof(rows1[i].site) != "NaN" && rows1[i].site != ""){
				  
       		 var obj = JSON.parse(jasond);
       		 obj['theTeam'].push({"site":rows1[i].site,"docno":i+1});
       		 jasond = JSON.stringify(obj);
				 
       		 }
						}	 
			 
       	return jasond;
       }
       
   
                       
    </script>
    <!-- <div style="text-align:right;padding-right:25px;padding-bottom:5px;"><input type="button" name="btnnewarea" id="btnnewarea" value="Add" onclick="addArea()";  class="myButton"></div> -->
    <div id="jqxsitesearch"></div>
    
    </body>
</html>