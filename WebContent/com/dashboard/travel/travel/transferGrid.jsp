 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
                                       
 <%  ClsTravelDAO sd=new ClsTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
 %>                
<script type="text/javascript">          
 var pdata;         
 pdata='<%=sd.transferGrid(rdocno) %>';                                         
$(document).ready(function(){  
        var source =
        {
            datatype: "json",            
            datafields: [
                         {name : 'rowno', type: 'string'}, 
                        {name : 'noofpax', type: 'number'},  
                        {name : 'fromdest', type: 'string'},  
                        {name : 'todest', type: 'string'},  
                      	{name : 'guestname', type: 'string'},      
                      	{name : 'date',type:'string'}, 
                      	{name : 'time',type:'string'}, 
                      	{name : 'vehicle',type:'string'}, 
                      	{name : 'remarks',type:'string'},
             ],
             localdata: pdata,
            
            
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



        $("#transferGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    altrows:true,
                     columnsresize: true,
                     enabletooltips:true,
                     editable:false,
                    //Add row method 
                    columns: [   
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						{ text: 'rowno',datafield: 'rowno', hidden:true},  
    					{ text: 'Guestname',datafield: 'guestname'},
    					{ text: 'From Dest.',datafield: 'fromdest'},  
    					{ text: 'To Dest.',datafield: 'todest',editable:true},
    					{ text: 'Vehicle',datafield: 'vehicle'}, 
    					{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy'},   
    					{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss'},
    					{ text: 'No of Pax',datafield: 'noofpax',align:'right',cellsalign:'right',width:'5%'},
    					{ text: 'Remarks',datafield: 'remarks',width:'23%'},
    	              ]                                         
                }); 
       $("#transferGrid").jqxGrid('addrow', null, {});  
	});
</script>
<div id="transferGrid"></div>