<%@page import="com.dashboard.travel.refundrequestmanagement.ClsRefundRequestManagementDAO"%>
<%  ClsRefundRequestManagementDAO sd=new ClsRefundRequestManagementDAO(); %>      
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>           
 <%       
    String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();            
 	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
 	String reftype=request.getParameter("reftype")==null || request.getParameter("reftype")==""?"0":request.getParameter("reftype").toString();
 %>                        
<script type="text/javascript">             
 var sdata,sdataexcel,reftypes; 
 reftypes='<%= reftype %>';           
 sdata='<%=sd.subGrid(session,check,docno,reftype) %>';      
 var rendererstring=function (aggregates){         
 	var value=aggregates['sum'];  
 	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
 }
$(document).ready(function(){       
          var source =
        {      
            datatype: "json",           
            datafields: [   
                            {name : 'refrowno',  type:'string'},                 
                            {name : 'taxacno',  type:'string'},  
            				{name : 'accdocno',  type:'string'},        
                            {name : 'rowno',  type:'string'},  
	                 	    {name : 'dtype',  type:'string'},         
	                        {name : 'vendor',  type:'string'},             
							{name : 'remarks',type:'string'},  
							{name : 'srvalue',type:'number'},     
							{name : 'sinclusive', type:'bool'},     
							{name : 'svalue',   type:'number'}, 
	                        {name : 'svat', type:'number'},      
	                      	{name : 'stotal',   type:'number'},    					
						    {name : 'prvalue',type:'number'},     
							{name : 'pinclusive', type:'bool'},     
							{name : 'pvalue',   type:'number'}, 
	                        {name : 'pvat', type:'number'},      
	                      	{name : 'ptotal',   type:'number'},
						    {name : 'pstock',   type:'bool'},    
						    {name : 'ctrno',  type:'string'}, 
						    {name : 'dtrno',  type:'string'},
						    {name : 'expdate',  type:'date'},
						    //{name : 'sprice',   type:'number'},  
						    //{name : 'stdtotal',   type:'number'},           
    					],      
             localdata: sdata,
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };

        
		$("#jqxrefundSubGrid").on('bindingcomplete', function (event) {  
 					   if(reftypes=="Travel Desk"){  
                       		$("#jqxrefundSubGrid").jqxGrid('showcolumn', 'pstock');
                       		$("#jqxrefundSubGrid").jqxGrid('showcolumn', 'expdate');
                       		//$("#jqxrefundSubGrid").jqxGrid('showcolumn', 'stdtotal');
                       		//$("#jqxrefundSubGrid").jqxGrid('showcolumn', 'sprice');
                       }else{
                       		$("#jqxrefundSubGrid").jqxGrid('hidecolumn', 'pstock');	
                       		$("#jqxrefundSubGrid").jqxGrid('hidecolumn', 'expdate');	
                       		//$("#jqxrefundSubGrid").jqxGrid('hidecolumn', 'stdtotal');
                       		//$("#jqxrefundSubGrid").jqxGrid('hidecolumn', 'sprice');
                       }
		});
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#jqxrefundSubGrid").jqxGrid(                
                {
                	width: '100%',
                    height: 250,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,   
                    selectionmode: 'singlecell',           
                    altrows:true,
                    columnsresize: true,
                    enabletooltips:true, 
                    editable:true,     
                    //Add row method             
                    columns: [     
                             
						{ text: 'SrNo.',datafield: '',columntype:'number',editable:false, width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						{ text: 'refrowno',datafield: 'refrowno', width: '7%',editable:false,hidden:true},     
						{ text: 'ctrno',datafield: 'ctrno', width: '7%',editable:false,hidden:true},        
						{ text: 'dtrno',datafield: 'dtrno', width: '7%',editable:false,hidden:true}, 
						{ text: 'taxacno',datafield: 'taxacno', width: '7%',editable:false,hidden:true},  
						{ text: 'rowno',datafield: 'rowno', width: '7%',editable:false,hidden:true}, 
						{ text: 'accdocno',datafield: 'accdocno', width: '7%',editable:false,hidden:true},        
						{ text: 'Doc Type',datafield: 'dtype', width: '7%',editable:false},       
						{ text: 'Vendor',datafield: 'vendor', width: '14%',editable:false},  
						{ text: 'remarks',datafield: 'remarks', editable:false},
						//{ text: 'Selling Price',datafield: 'sprice', width: '5%', editable:false, columngroup: 'srv',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Refund Value',datafield: 'srvalue', width: '5%', columngroup: 'srv',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Inclusive',datafield: 'sinclusive',columntype:'checkbox', width: '5%', columngroup: 'srv'},    
    					{ text: 'Value',datafield: 'svalue', width: '5%', columngroup: 'srv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false}, 
    					{ text: 'Vat',datafield: 'svat', width: '5%', columngroup: 'srv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false}, 
    					{ text: 'Total',datafield: 'stotal', width: '5%', columngroup: 'srv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false}, 
    					//{ text: 'Std Cost',datafield: 'stdtotal', width: '5%', editable:false, columngroup: 'prv',cellsformat:'d2',cellsalign:'right',align:'right'},
    					{ text: 'Refund Value',datafield: 'prvalue', width: '5%', columngroup: 'prv',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Inclusive',datafield: 'pinclusive',columntype:'checkbox', width: '5%', columngroup: 'prv'},    
    					{ text: 'Value',datafield: 'pvalue', width: '5%', columngroup: 'prv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false}, 
    					{ text: 'Vat',datafield: 'pvat', width: '5%', columngroup: 'prv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false}, 
    					{ text: 'Total',datafield: 'ptotal', width: '5%', columngroup: 'prv',cellsformat:'d2',cellsalign:'right',align:'right', editable:false},   
    					{ text: 'Stock',datafield: 'pstock',columntype:'checkbox', width: '5%', columngroup: 'prv'}, 
    					{ text: 'Exp.Date', datafield: 'expdate', width: '5%',cellsformat:'dd.MM.yyyy', columngroup: 'prv', columntype: 'datetimeinput' , createeditor: function (row, cellvalue, editor, celltext, cellwidth, cellheight) {
   						 editor.jqxDateTimeInput({ showCalendarButton: false});
   			           }},     
                   ],  
                   columngroups: [   
							{ text: 'Sale return value', align: 'center', name: 'srv' },    
							{ text: 'Purchase return value', align: 'center', name: 'prv' }    
						]              
                });      
		           $("#overlay, #PleaseWait").hide(); 
		           $('#jqxrefundSubGrid').on('cellvaluechanged', function (event) {                                                                  
				         var datafield = event.args.datafield;
				         var rowindextemp = event.args.rowindex;
				         var total=0.0,vatamt=0.0,netamt=0.0; 
				     	 var srvalue=$('#jqxrefundSubGrid').jqxGrid('getcellvalue', rowindextemp, "srvalue");  
				     	 var sinclusive=$('#jqxrefundSubGrid').jqxGrid('getcellvalue', rowindextemp, "sinclusive");  
				     	 var prvalue=$('#jqxrefundSubGrid').jqxGrid('getcellvalue', rowindextemp, "prvalue"); 
				     	 var pinclusive=$('#jqxrefundSubGrid').jqxGrid('getcellvalue', rowindextemp, "pinclusive"); 
				     	 var dtype=$('#jqxrefundSubGrid').jqxGrid('getcellvalue', rowindextemp, "dtype");   
				       	 if(datafield=="prvalue" || datafield=="pinclusive"){
				       	    if(typeof(prvalue) != "undefined" && typeof(prvalue) != "NaN" && prvalue != ""  && prvalue != "0" && prvalue!='0.00'){          
				       	       if(pinclusive){
				       	    	   if(dtype=="Air Ticket"){    
				       	    		    vatamt=0.0;  
				       	    	    }else{
				       	    	    	vatamt=parseFloat(prvalue)-((parseFloat(prvalue)/105)*100); 				       	    	    	
				       	    	    }
				       	            total=parseFloat(prvalue)-vatamt;
				       	            netamt=parseFloat(prvalue);
				       	       }else{
				       	    	if(dtype=="Air Ticket"){  
			       	    		    vatamt=0.0;  
			       	    	    }else{
			       	    	    	vatamt=(parseFloat(prvalue)*5)/100;   				       	    	    	
			       	    	    }
				       	             
				       	           total=parseFloat(prvalue);
				       	           netamt=parseFloat(prvalue)+vatamt;      
				       	       }
				       	    }else{
				       	       total=0.0;
				       	       vatamt=0.0;
				       	       netamt=0.0;  
				       	    }                                    
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "pvalue",total);  
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "pvat",vatamt); 
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "ptotal",netamt);              
				       	 }
				       	  if(datafield=="srvalue" || datafield=="sinclusive"){
				       	    if(typeof(srvalue) != "undefined" && typeof(srvalue) != "NaN" && srvalue != ""  && srvalue != "0" && srvalue!='0.00'){          
				       	       if(sinclusive){
				       	    	if(dtype=="Air Ticket"){  
			       	    		    vatamt=0.0;  
			       	    	    }else{
				       	            vatamt=parseFloat(srvalue)-((parseFloat(srvalue)/105)*100);  
			       	    	    }
				       	            total=parseFloat(srvalue)-vatamt;
				       	            netamt=parseFloat(srvalue);
				       	       }else{
				       	    	if(dtype=="Air Ticket"){  
			       	    		    vatamt=0.0;  
			       	    	    }else{
				       	           vatamt=(parseFloat(srvalue)*5)/100;  
			       	    	    }
				       	           total=parseFloat(srvalue);
				       	           netamt=parseFloat(srvalue)+vatamt;      
				       	       }
				       	    }else{
				       	       total=0.0;
				       	       vatamt=0.0;
				       	       netamt=0.0;  
				       	    }                                    
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "svalue",total);  
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "svat",vatamt); 
				       	    $('#jqxrefundSubGrid').jqxGrid('setcellvalue', rowindextemp, "stotal",netamt);              
				       	 }
			          });    
	});
</script>
<div id="jqxrefundSubGrid"></div>  