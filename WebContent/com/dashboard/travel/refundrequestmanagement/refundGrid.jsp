<%@page import="com.dashboard.travel.refundrequestmanagement.ClsRefundRequestManagementDAO"%>
<%  ClsRefundRequestManagementDAO sd=new ClsRefundRequestManagementDAO(); %>     
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString();
 	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
 %>                        
<script type="text/javascript">          
var pdata,dataexcel;         
 pdata='<%=sd.detailGrid(session,check,todate,brhid) %>';       
 var rendererstring=function (aggregates){  
 	var value=aggregates['sum'];  
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){       
          var source =
        {      
            datatype: "json",           
            datafields: [  
	                 	    {name : 'docno',  type:'string'},       
	                        {name : 'vocno',  type:'string'},             
							{name : 'refname',type:'string'},     
							{name : 'remarks',type:'string'},             
							{name : 'branch', type:'string'},     
							{name : 'user',   type:'string'}, 
	                        {name : 'amount', type:'number'},      
	                      	{name : 'date',   type:'date'},
	                      	{name : 'refno',   type:'string'},
	                      	{name : 'reftype',   type:'string'},           
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

        $("#jqxrefundGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 250,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,   
                    selectionmode: 'singlerow',        
                    altrows:true,
                    columnsresize: true,
                    enabletooltips:true,      
                    //Add row method   
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'Branch',datafield: 'branch', width: '9%'}, 
						{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '5%'},  
						{ text: 'Request No',datafield: 'vocno', width: '7%'},  
					    { text: 'Ref Type',datafield: 'reftype', width: '7%'},  
						{ text: 'Ref No',datafield: 'refno', width: '7%'},
						{ text: 'doc_no',datafield: 'docno', width: '7%',hidden:true},   
						{ text: 'Customer',datafield: 'refname'},   
						{ text: 'User',datafield: 'user', width: '12%'},
						{ text: 'Amount',datafield: 'amount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},    
    					{ text: 'Remarks',datafield: 'remarks', width: '30%'},                    
                   ]       
                });      
		           $("#overlay, #PleaseWait").hide(); 
		           $('#jqxrefundGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex2 = event.args.rowindex; 
	                   document.getElementById('rrdocno').value=$('#jqxrefundGrid').jqxGrid('getcellvalue',rowindex2,'docno');
	                   document.getElementById('reftype').value=$('#jqxrefundGrid').jqxGrid('getcellvalue',rowindex2,'reftype');
	                   var rrdocno=$('#jqxrefundGrid').jqxGrid('getcellvalue',rowindex2,'docno');
	                   var reftype=$('#jqxrefundGrid').jqxGrid('getcellvalue',rowindex2,'reftype');
                       $('#rrsubdiv').load('refundSubGrid.jsp?check=1'+'&docno='+rrdocno+'&reftype='+encodeURIComponent(reftype));            
                   });    
	});
</script>
<div id="jqxrefundGrid"></div>