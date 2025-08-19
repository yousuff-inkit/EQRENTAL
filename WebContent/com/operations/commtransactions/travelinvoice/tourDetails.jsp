<%@page import="com.operations.commtransactions.travelinvoice.ClsTravelInvoiceDAO"%>
<% ClsTravelInvoiceDAO DAO= new ClsTravelInvoiceDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%
     String rdocno=request.getParameter("rdocno")=="" || request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");
 %>                       
<script type="text/javascript">          
 var pdata;                                           
  pdata='<%=DAO.tourGrid(rdocno,check) %>';         
      
  var rendererstring=function (aggregates){  
	 	var value=aggregates['sum'];
	 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	 }
$(document).ready(function(){  
        var source =
        {
            datatype: "json",           
            datafields: [      
                     	{name : 'time',type:'string'},
                     	{name : 'total', type: 'number'},
                        {name : 'adult', type: 'number'},      
                        {name : 'child', type: 'number'}, 
                      	{name : 'tourname', type: 'string'},  
                      	{name : 'tourid', type: 'string'},
                      	{name : 'remarks', type: 'string'},    
                      	{name : 'date',type:'String'}, 
                    	{name : 'vndid', type: 'string'},
                      	{name : 'vendor', type: 'string'},  
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

        $("#tourGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 150,
                    source: dataAdapter,   
                    showaggregates: true,  
                 	showstatusbar:true,
                    filterable: true,   
                    selectionmode: 'singlecell',      
                    altrows:true,
                    columnsresize: true,
                    enabletooltips:true,  
                    editable: false,    
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '5%',editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Tour name',datafield: 'tourname', width: '22%'},             
    					{ text: 'Tour id',datafield: 'tourid',hidden:true}, 
       					{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '5%'},
						{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss', width: '5%'}, 
    					{ text: 'Vendor',datafield: 'vendor', width: '20%'},                            
    					{ text: 'vnd id',datafield: 'vndid',hidden:true},   
    					{ text: 'Adult',datafield: 'adult', width: '4%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Child',datafield: 'child', width: '4%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Total',datafield: 'total',cellsformat: 'd2',width: '7%',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Remarks',datafield: 'remarks'},                              
    	              ]                                               
                });    
	});
</script>
<div id="tourGrid"></div>