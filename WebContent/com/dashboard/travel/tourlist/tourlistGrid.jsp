<%@page import="com.dashboard.travel.tourlist.ClsTourListDAO"%>
<%  ClsTourListDAO sd=new ClsTourListDAO(); %>     
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
            			{name : 'doc_no',type:'string'},    
                        {name : 'salesman',type:'string'},             
						{name : 'paymode',type:'string'},     
						{name : 'mobile',type:'string'},             
						{name : 'email',type:'string'},     
						{name : 'refname',type:'string'}, 
                        {name : 'distype',type:'string'},  
                      	{name : 'adultdis', type: 'number'},   
                     	{name : 'childdis', type: 'number'},      
                     	{name : 'time',type:'string'},
                    	{name : 'stdtotal', type: 'number'},
                     	{name : 'total', type: 'number'},
						{name : 'spadult', type: 'number'},
						{name : 'spchild', type: 'number'},     
						{name : 'infant', type: 'number'},     
                        {name : 'adult', type: 'number'},      
                        {name : 'child', type: 'number'}, 
                        {name : 'adultval', type: 'number'},  
                        {name : 'childval', type: 'number'},  
                      	{name : 'tourname', type: 'string'},  
                      	{name : 'remarks', type: 'string'},    
                      	{name : 'date',type:'date'},   
                      	{name : 'vendor', type: 'string'},  
                       	{ name: 'transferid',type: 'string'}, 
    					{ name: 'groupid',type: 'string'},                        
    					{ name: 'transfertype',type: 'string'},
    					{ name: 'qty',type: 'string'},
    					{ name: 'loctype',type: 'string'},
    					{ name: 'rname',type: 'string'},   
    					{ name: 'refno',type: 'string'},
    					{ name: 'plocid',type: 'string'},
    					{ name: 'ploctime',type: 'string'},
    					{ name: 'dlocid',type: 'string'},
    					{ name: 'rtripid',type: 'string'},
    					{ name: 'tvltotal',type: 'number'},    
    					{ name: 'rndplocid',type: 'string'},
    					{ name: 'rndploctime',type: 'string'},
    					{ name: 'rnddlocid',type: 'string'}, 
    					{ name: 'tarifdetaildocno', type: 'string' },
    					{ name: 'estdistance',  type: 'string'},
    					{ name: 'esttime',  type: 'string'},
    					{ name: 'exdistancerate', type: 'string' },
    					{ name: 'extimerate', type: 'string' },
    					{ name: 'tourtransferrate',type: 'string'  },
    					{ name: 'tourtransferratetot', type: 'string' },
    					{ name: 'rttarifdetaildocno',  type: 'string'},        
    					{ name: 'rtestdistance',  type: 'string'},
    					{ name: 'rtesttime', type: 'string' },
    					{ name: 'rtexdistancerate',type: 'string'  },
    					{ name: 'rtextimerate', type: 'string' },
    					{ name: 'tarifdocno', type: 'string' },
    					{ name: 'rttarifdocno', type: 'string' }, 
    					{ name: 'rowno', type: 'string' },       
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
						{ text: 'Doc No',datafield: 'doc_no', width: '5%',editable:false}, 
						{ text: 'rowno',datafield: 'rowno', width: '5%',editable:false,hidden:true},       
						{ text: 'Date',datafield: 'date',cellsformat:'dd.MM.yyyy', width: '5%',editable:false},
						{ text: 'Time',datafield: 'time',cellsformat:'HH:mm:ss', width: '4%',editable:false}, 
						{ text: 'Client',datafield: 'refname', width: '20%',editable:false},
						{ text: 'Mobile',datafield: 'mobile', width: '7%',editable:false},   
						{ text: 'Email',datafield: 'email', width: '12%',editable:false},
						{ text: 'Vendor',datafield: 'vendor', width: '20%',editable:false},    
    					{ text: 'Tour name',datafield: 'tourname', width: '20%',editable:false},             
    					{ text: 'Salesman',datafield: 'salesman', width: '12%',editable:false},
    					{ text: 'Pay Mode',datafield: 'paymode', width: '9%',editable:false},
    					{ text: 'Ref Name',datafield: 'rname', width: '13%',editable:false},
    					{ text: 'Infant',datafield: 'infant', width: '3%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Adult',datafield: 'adult', width: '3%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Child',datafield: 'child', width: '3%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Type',datafield: 'distype', width: '5%',editable:true,columntype:'dropdownlist',
    						createeditor: function (row, column, editor) {      
                            billlist = ["DISCOUNT",  "PAY BACK"];      
    							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });
    						},
    				 	 initeditor: function (row, cellvalue, editor) {
    						var terms = $('#tourGrid').jqxGrid('getcellvalue', row, "distype");
    							editor.jqxDropDownList({ autoDropDownHeight: true, source: billlist });   
                         },  
    		            }, 
    					{ text: 'SP Adult',datafield: 'spadult', width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'SP Child',datafield: 'spchild', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'adultval',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},   
    					{ text: 'Discount(Adult)',datafield: 'adultdis', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Std.Price',datafield: 'childval',cellsformat: 'd2',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Discount(Child)',datafield: 'childdis', width: '6%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Total',datafield: 'total',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'STD Total',datafield: 'stdtotal',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
    					{ text: 'Travel Total',datafield: 'tvltotal',cellsformat: 'd2',width: '6%',cellsalign:'right',align:'right',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
    					{ text: 'Remarks',datafield: 'remarks', width: '18%',editable:false},
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