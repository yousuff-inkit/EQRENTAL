<%@page import="com.dashboard.travel.profitmanagement.ClsProfitManagementDAO"%>
<%  ClsProfitManagementDAO sd=new ClsProfitManagementDAO(); %>       
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").toString();
    String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").toString();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
 	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
 %>                        
<script type="text/javascript">          
var pdata,dataexcel;         
 pdata='<%=sd.detailGrid(session,check,fromdate,todate,brhid,locid) %>';
 
 var rendererstring=function (aggregates){    
 	var value=aggregates['sum'];  
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){  
        var source =
        {     
            datatype: "json",           
            datafields: [
                            {name : 'voc_no',type:'string'},
	            			{name : 'doc_no',type:'string'},
	            			{name : 'refname',type:'string'},
	            			{name : 'remarks', type: 'string'}, 
	            			{name : 'date',type:'date'}, 
	            			{name : 'vendor', type: 'string'},
	            			{name : 'doctype',type:'string'},
	            			{name : 'branch',type:'string'},
							{name : 'location',type:'string'},
	            			{name : 'svalue', type: 'number'},			 
							{name : 'svat', type: 'number'},	
							{name : 'netsales', type: 'number'},	
							{name : 'pvalue', type: 'number'},
							{name : 'pvat', type: 'number'},
							{name : 'netpur', type: 'number'},	
							{name : 'marginper', type: 'number'},	
							{name : 'marginval', type: 'number'},             
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
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    filtermode:'excel',
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
                             
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',editable:false,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'Date',datafield: 'date', width: '5%',editable:false,cellsformat:'dd.MM.yyyy'},
						{ text: 'Doc Type',datafield: 'doctype', width: '5%',editable:false}, 
						{ text: 'Doc No',datafield: 'doc_no', width: '5%',editable:false,hidden:true},
						{ text: 'Doc No',datafield: 'voc_no', width: '5%',editable:false}, 
						{ text: 'Branch',datafield: 'branch', width: '5%',editable:false}, 
						{ text: 'Remarks',datafield: 'remarks', width: '20%',editable:false},
						{ text: 'Sales Value',datafield: 'svalue',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'cl'},
						{ text: 'Vat',datafield: 'svat',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'cl'},
						{ text: 'Net Sales',datafield: 'netsales',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'cl'},
						{ text: 'Purchase Value',datafield: 'pvalue',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'pur'},
						{ text: 'Vat',datafield: 'pvat',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'pur'},
						{ text: 'Net Purchase',datafield: 'netpur',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'pur'},
						{ text: 'Margin %',datafield: 'marginper',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'mr'},
						{ text: 'Margin Value',datafield: 'marginval',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,columngroup: 'mr'},
                  		{ text: 'Location',datafield: 'location', width: '9%',editable:false},
						{ text: 'Vendor',datafield: 'vendor', width: '12%',editable:false},
						{ text: 'Client',datafield: 'refname', width: '12%',editable:false},         
                   ],
                   columngroups: [                         
									{ text: 'Purchase', align: 'center', name: 'pur' },        
									{ text: 'Sales', align: 'center', name: 'cl' },
									{ text: 'Margin', align: 'center', name: 'mr' },
									]    
                });      
		           $("#overlay, #PleaseWait").hide(); 
		           $('#tourGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex2 = event.args.rowindex; 
	                   $('.textpanel p').text('Doc No '+$('#tourGrid').jqxGrid('getcellvalue',rowindex2,'doc_no')+' - '+$('#tourGrid').jqxGrid('getcellvalue', rowindex2, "tourname"));
	                   document.getElementById('hidrowno').value=$('#tourGrid').jqxGrid('getcellvalue',rowindex2,'rowno');
                   });    
	});
</script>
<div id="tourGrid"></div>