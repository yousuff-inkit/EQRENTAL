<%@page import="com.operations.commtransactions.refundrequest.ClsRefundRequestDAO"%>
<% ClsRefundRequestDAO DAO= new ClsRefundRequestDAO(); %>   
<%@page import="javax.servlet.http.HttpServletRequest" %>           
<%@page import="javax.servlet.http.HttpSession" %>   
<%    
    String rrdocno=request.getParameter("rrdocno")==null || request.getParameter("rrdocno")==""?"0":request.getParameter("rrdocno").toString();
    String refund=request.getParameter("refund")==null || request.getParameter("refund")==""?"0":request.getParameter("refund").toString();
    String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").toString();
    String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();   
    String branch=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
%>      
<script type="text/javascript">            
var tdata;
		   tdata='<%=DAO.loadTicketGrid(branch,rdocno,id,session,refund,rrdocno) %>';          
	  var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';  
	    }  
$(document).ready(function(){             
      
    var source =
    {             
            datatype: "json",
            datafields: [ 
                            {name : 'invtrno' , type: 'string'},   
				            {name : 'cpudoc' , type: 'string'}, 
                            {name : 'voc_no' , type: 'string'},  
                            {name : 'rowno' , type: 'string'},    
                            {name : 'classes' , type: 'string'},  
		                 	{name : 'ticketno' , type: 'string'},    
							{name : 'cldocno' , type: 'string'}, 
							{name : 'customer' , type: 'string'},
							{name : 'vendor' , type: 'string'},							
							{name : 'vnddocno' , type: 'string'},   
							{name : 'bookdate' , type: 'date'},
							{name : 'issuedate' , type: 'date'},
							{name : 'guest', type:'string'},    
							{name : 'airlineid', type:'string'},  
                            {name : 'airline', type:'string'}, 							
							{name : 'sector' , type: 'string'},    
							{name : 'class' , type: 'string'}, 
							{name : 'gds' , type: 'string'},  
							{name : 'bstaffid' , type: 'string'},    
							{name : 'tstaffid' , type: 'string'},  
							{name : 'bstaff' , type: 'string'}, 
							{name : 'tstaff' , type: 'string'}, 							
							{name : 'issuetype' , type: 'string'},   
							{name : 'type' , type: 'string'},   
							{name : 'tickettype' , type: 'string'}, 
							{name : 'prnno' , type: 'string'},
							{name : 'suptotal' , type: 'number'},
							{name : 'servfee' , type: 'number'},
							{name : 'paybackamt' , type: 'number'},   
							{name : 'sprice' , type: 'number'},  
							{name : 'chk', type: 'bool'},      
             ],                  
             localdata: tdata,   
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
	    var cellclassname = function (row, column, value, data) {
	    };  
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );
        $("#jqxTicketGrid").jqxGrid(
                {
                	width: '100%',
                    height: 400,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlecell',  
                  	editable:true,
                    altrows:true,
                    sortable: true,  
                    columnsresize: true,   
                    //Add row method
                    columns: [ 
	                        { text: '',datafield: 'chk',columntype:'checkbox'}, 
							{ text: 'Sr. No.',datafield: '',columntype:'number',editable: false,cellclassname:cellclassname, width: '4%',cellsrenderer: function (row, column, value) {
							    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}   },
						    { text: 'Doc No',datafield: 'voc_no', width: '5%',cellclassname:cellclassname,editable: false},  
						    { text: 'Ticket No',datafield: 'ticketno', width: '5%',cellclassname:cellclassname,editable: false}, 
	    					{ text: 'Customer',datafield: 'customer',cellclassname:cellclassname,editable: false, width: '20%'},
							{ text: 'Supplier',datafield: 'vendor', width: '19%',cellclassname:cellclassname,editable: false}, 
							{ text: 'Customer ID',datafield: 'cldocno', width: '6%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'Supplier ID',datafield: 'vnddocno', width: '6%',cellclassname:cellclassname,hidden:true,editable: false}, 
							{ text: 'Booking Date',datafield: 'bookdate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname,editable: false},
							{ text: 'Issue Date',datafield: 'issuedate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname,editable: false},
							{ text: 'Guest',datafield: 'guest', width: '7%',cellclassname:cellclassname,editable: false},         
							{ text: 'Airline',datafield: 'airline', width: '7%',cellclassname:cellclassname,editable: false},
							{ text: 'Airline ID',datafield: 'airlineid', width: '10%',cellclassname:cellclassname,hidden:true,editable: false},   							
							{ text: 'Sector',datafield: 'sector', width: '10%',cellclassname:cellclassname,hidden:true,editable: false},          
	    					{ text: 'Class',datafield: 'classes', width: '10%',cellclassname:cellclassname,hidden:true,editable: false},
	    					{ text: 'GDS', datafield: 'gds', width: '10%',hidden:true,cellclassname:cellclassname,editable: false}, 
	    					{ text: 'Booking Staff', datafield: 'bstaff', width: '7%',cellclassname:cellclassname,editable: false},
							{ text: 'Ticketing Staff', datafield: 'tstaff', width: '7%',cellclassname:cellclassname,editable: false},
							{ text: 'Booking Staff ID', datafield: 'bstaffid', width: '10%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'Ticketing Staff ID', datafield: 'tstaffid', width: '10%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'Issue Type', datafield: 'issuetype', width: '8%',cellclassname:cellclassname,hidden:true,editable: false},     
							{ text: 'Type', datafield: 'type', width: '8%',cellsalign: 'right', align:'right',hidden:true,editable: false},  
							{ text: 'Ticket Type',datafield: 'tickettype', width: '7%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'rowno',datafield: 'rowno', width: '7%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'PRN No',datafield: 'prnno', width: '5%',cellclassname:cellclassname,editable: false,hidden:true},
							{ text: 'Supplier Total',datafield: 'suptotal', width: '7%',cellclassname:cellclassname,hidden:true,editable: false},  
							{ text: 'Service Fee',datafield: 'servfee', width: '7%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'Payback Amount',datafield: 'paybackamt', width: '7%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'SPrice',datafield: 'sprice', width: '7%',cellclassname:cellclassname,cellsalign:'right',align:'right',editable: false}, 
						    { text: 'invtrno',datafield: 'invtrno', width: '6%',cellclassname:cellclassname,hidden:true,editable: false},
							{ text: 'cpudoc',datafield: 'cpudoc', width: '6%',cellclassname:cellclassname,hidden:true,editable: false},     
						]                                                         
                });  
                   $("#overlay, #PleaseWait").hide();               
	});      
</script>
<div id="jqxTicketGrid"></div>