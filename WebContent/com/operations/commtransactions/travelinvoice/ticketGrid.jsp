<%@page import="com.operations.commtransactions.travelinvoice.ClsTravelInvoiceDAO"%>
<% ClsTravelInvoiceDAO DAO= new ClsTravelInvoiceDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>           
<%@page import="javax.servlet.http.HttpSession" %>   
<%                 
    String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").toString();
    String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();   
    String branch=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();
%>      
<script type="text/javascript">            
var tdata;
		   tdata='<%=DAO.loadTicketGrid(branch,rdocno,id,session) %>';          
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
                    height: 150,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlerow',  
                  	editable:false,
                    altrows:true,
                    sortable: true,  
                    columnsresize: true,   
                    //Add row method
                    columns: [  
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname:cellclassname, width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						    { text: 'Doc No',datafield: 'voc_no', width: '5%',cellclassname:cellclassname},  
						    { text: 'Ticket No',datafield: 'ticketno', width: '5%',cellclassname:cellclassname}, 
	    					{ text: 'Customer',datafield: 'customer',cellclassname:cellclassname},
							{ text: 'Supplier',datafield: 'vendor', width: '15%',cellclassname:cellclassname}, 
							{ text: 'Customer ID',datafield: 'cldocno', width: '6%',cellclassname:cellclassname,hidden:true},
							{ text: 'Supplier ID',datafield: 'vnddocno', width: '6%',cellclassname:cellclassname,hidden:true}, 
							{ text: 'Booking Date',datafield: 'bookdate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Issue Date',datafield: 'issuedate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Guest',datafield: 'guest', width: '8%',cellclassname:cellclassname},         
							{ text: 'Airline',datafield: 'airline', width: '8%',cellclassname:cellclassname},
							{ text: 'Airline ID',datafield: 'airlineid', width: '14%',cellclassname:cellclassname,hidden:true},   							
							{ text: 'Sector',datafield: 'sector', width: '10%',cellclassname:cellclassname,hidden:true},          
	    					{ text: 'Class',datafield: 'classes', width: '10%',cellclassname:cellclassname,hidden:true},
	    					{ text: 'GDS', datafield: 'gds', width: '10%',hidden:true,cellclassname:cellclassname}, 
	    					{ text: 'Booking Staff', datafield: 'bstaff', width: '8%',cellclassname:cellclassname},
							{ text: 'Ticketing Staff', datafield: 'tstaff', width: '8%',cellclassname:cellclassname},
							{ text: 'Booking Staff ID', datafield: 'bstaffid', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'Ticketing Staff ID', datafield: 'tstaffid', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'Issue Type', datafield: 'issuetype', width: '8%',cellclassname:cellclassname,hidden:true},     
							{ text: 'Type', datafield: 'type', width: '8%',cellsalign: 'right', align:'right',hidden:true},  
							{ text: 'Ticket Type',datafield: 'tickettype', width: '8%',cellclassname:cellclassname,hidden:true},
							{ text: 'rowno',datafield: 'rowno', width: '7%',cellclassname:cellclassname,hidden:true},
							{ text: 'PRN No',datafield: 'prnno', width: '5%',cellclassname:cellclassname},
							{ text: 'Supplier Total',datafield: 'suptotal', width: '7%',cellclassname:cellclassname,hidden:true},  
							{ text: 'Service Fee',datafield: 'servfee', width: '7%',cellclassname:cellclassname,hidden:true},
							{ text: 'Payback Amount',datafield: 'paybackamt', width: '7%',cellclassname:cellclassname,hidden:true},
							{ text: 'SPrice',datafield: 'sprice', width: '7%',cellclassname:cellclassname,cellsalign:'right',align:'right'}, 
						    { text: 'invtrno',datafield: 'invtrno', width: '6%',cellclassname:cellclassname,hidden:true},
							{ text: 'cpudoc',datafield: 'cpudoc', width: '6%',cellclassname:cellclassname,hidden:true},     
						]                                                         
                });  
                   $("#overlay, #PleaseWait").hide();               
	});      
</script>
<div id="jqxTicketGrid"></div>