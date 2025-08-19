<%@page import="com.dashboard.travel.refundreport.ClsRefundReportDAO"%>
<%  ClsRefundReportDAO DAO=new ClsRefundReportDAO(); %>       
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String check=request.getParameter("check")==null?"":request.getParameter("check").toString();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
 %>                        
<script type="text/javascript">          
var pdata;                   
 pdata='<%=DAO.detailGrid(check,fromdate,todate) %>';
 
 var rendererstring=function (aggregates){    
 	var value=aggregates['sum'];  
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){  
        var source =
        {     
            datatype: "json",           
            datafields: [
                            {name : 'tour',type:'string'},
	            			{name : 'vendor',type:'string'},
	            			{name : 'locname',type:'string'},
	            			{name : 'branch', type: 'string'}, 
	            			{name : 'date',type:'date'}, 
	            			{name : 'expdate',type:'date'},               
	            			{name : 'adult', type: 'number'},
	            			{name : 'child',type:'number'},
	            			{name : 'spadult',type:'number'},
							{name : 'spchild',type:'number'},
							{name : 'user', type: 'string'},	
							{name : 'refstockid', type: 'string'},	
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

        $("#stockDetailGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    sortable:true,
                    selectionmode: 'singlerow',      
                    altrows:true,
                    showaggregates: true,  
                 	showstatusbar:true,
                    columnsresize: true,
                    enabletooltips:true,      
                    editable:false,    
                    //Add row method 
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Ref.Stock ID',datafield: 'refstockid', width: '5%'},    
						{ text: 'Date',datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Tour',datafield: 'tour'}, 
						{ text: 'Vendor',datafield: 'vendor', width: '12%'},
						{ text: 'Branch',datafield: 'branch', width: '10%'}, 
						{ text: 'Location',datafield: 'locname', width: '10%'},           
						{ text: 'User',datafield: 'user', width: '10%'},   
						{ text: 'Adult',datafield: 'adult', width: '7%',columngroup: 'sk'},           
						{ text: 'Child',datafield: 'child', width: '7%',columngroup: 'sk'},    
						{ text: 'Adult',datafield: 'spadult',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'sp'},
						{ text: 'Child',datafield: 'spchild',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'sp'},
						{ text: 'Expiry Date',datafield: 'expdate', width: '5%',cellsformat:'dd.MM.yyyy'},      
					],         
                  columngroups: [                         
									{ text: 'Stock', align: 'center', name: 'sk' },
									{ text: 'Selling Price', align: 'center', name: 'sp' },
								]    
                });      
		           $("#overlay, #PleaseWait").hide(); 
		           /* $('#stockDetailGrid').on('rowdoubleclick', function (event) {            
	                   var rowindex2 = event.args.rowindex; 
	                   $('.textpanel p').text($('#stockDetailGrid').jqxGrid('getcellvalue',rowindex2,'tour')+' - '+$('#stockDetailGrid').jqxGrid('getcellvalue', rowindex2, "vendor"));
                   });  */   
	});   
</script>
<div id="stockDetailGrid"></div>