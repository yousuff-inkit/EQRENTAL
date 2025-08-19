<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%  ClsTravelDAO sd=new ClsTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
<%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
%>                    
<script type="text/javascript">          
var serdata;         
serdata='<%=sd.serviceGrid(rdocno) %>';                                           
 
$(document).ready(function(){  

        var source =
        {                         
            datatype: "json",            
            datafields: [
                          {name : 'rowno', type: 'string'}, 
                          {name : 'servicetype', type: 'string'}, 
                          {name : 'serdocno', type: 'string'},      
                      	  {name : 'remarks', type: 'string'},      
                      	  {name : 'pax',type:'number'}, 
             ],
             localdata: serdata,
            
            
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



        $("#serviceReqGrid").jqxGrid(  
                {
                	width: '100%',      
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,  
                    selectionmode: 'singlecell',
                  	editable:true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method  
                    columns: [            
							{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}   },  
							{ text: 'rowno',datafield: 'rowno', hidden:true},                
    						{ text: 'Service Type',datafield: 'servicetype',editable:false, width: '19%'},  
    						{ text: 'Serdocno',datafield: 'serdocno', hidden:true},         
    						{ text: 'Remarks',datafield: 'remarks'},       
    						{ text: 'Pax',datafield: 'pax', width: '8%',
	    						validation: function (cell, value) {
	                          	if (value >0) {
	                              return { result: true, message: "Enter Numbers Only" };
	                          	}
	                          	return false;
	       						}
	    					}, 
    	              ]                                         
                }); 
                
          //$("#serviceReqGrid").jqxGrid('addrow', null, {});    
	});
</script>
<div id="serviceReqGrid"></div>