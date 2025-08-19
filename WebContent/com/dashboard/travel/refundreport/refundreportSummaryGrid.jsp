<%@page import="com.dashboard.travel.refundreport.ClsRefundReportDAO"%>
<%  ClsRefundReportDAO DAO=new ClsRefundReportDAO(); %>       
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String check=request.getParameter("check")==null?"":request.getParameter("check").toString();
 %>                        
<script type="text/javascript">          
var detdata;                   
detdata='<%=DAO.summaryGrid(check) %>';                   
 
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
	            			{name : 'expdate',type:'date'},               
	            			{name : 'adult', type: 'number'},
	            			{name : 'child',type:'number'},
							{name : 'user', type: 'string'},	        
    					],
             localdata: detdata,    
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

        $("#stockSummaryGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    sortable:true,
                    selectionmode: 'singlerow',      
                    altrows:true,
                    columnsresize: true,
                    enabletooltips:true,      
                    editable:false,    
                    //Add row method 
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Tour',datafield: 'tour'}, 
						{ text: 'User',datafield: 'user', width: '15%'},
						{ text: 'Adult',datafield: 'adult', width: '7%'},           
						{ text: 'Child',datafield: 'child', width: '7%'},        
						{ text: 'Expiry Date',datafield: 'expdate', width: '5%',cellsformat:'dd.MM.yyyy'},      
					],         
                });      
		           $("#overlay, #PleaseWait").hide(); 
		           /* $('#stockSummaryGrid').on('rowdoubleclick', function (event) {            
	                   var rowindex2 = event.args.rowindex; 
	                   $('.textpanel p').text($('#stockSummaryGrid').jqxGrid('getcellvalue',rowindex2,'tour')+' - '+$('#stockSummaryGrid').jqxGrid('getcellvalue', rowindex2, "vendor"));
                   });  */      
	});   
</script>
<div id="stockSummaryGrid"></div>