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
var hdata;
		   hdata='<%=DAO.loadHotelGrid(branch,rdocno,id,session) %>';              
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
            				{name : 'vnddocno' , type: 'string'},   
            				{name : 'cldocno' , type: 'string'}, 
                            {name : 'voc_no' , type: 'string'},    
                            {name : 'rowno' , type: 'string'},    
                            {name : 'suppconfno' , type: 'string'},  
		                 	{name : 'isstaff' , type: 'string'},    
							{name : 'customer' , type: 'string'},
							{name : 'vendor' , type: 'string'},							
							{name : 'issuedate' , type: 'date'},
							{name : 'country', type:'string'},    
							{name : 'city', type:'string'},  
                            {name : 'hotel', type:'string'}, 							
							{name : 'roomtype' , type: 'string'}, 
							{name : 'suptotal' , type: 'number'},
							{name : 'servfee' , type: 'number'},
							{name : 'paybackamt' , type: 'number'},   
							{name : 'sprice' , type: 'number'},     
             ],                  
             localdata: hdata,    
            
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
        $("#jqxHotelGrid").jqxGrid(
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
						    { text: 'Supplier Conformation No',datafield: 'suppconfno', width: '6%',cellclassname:cellclassname}, 
	    					{ text: 'Customer',datafield: 'customer',cellclassname:cellclassname},
							{ text: 'Supplier',datafield: 'vendor', width: '15%',cellclassname:cellclassname}, 
							{ text: 'Customer ID',datafield: 'cldocno', width: '6%',cellclassname:cellclassname,hidden:true},
							{ text: 'Supplier ID',datafield: 'vnddocno', width: '6%',cellclassname:cellclassname,hidden:true}, 
							{ text: 'Issue Date',datafield: 'issuedate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
						    { text: 'Issuing Staff', datafield: 'isstaff', width: '8%',cellclassname:cellclassname},
							{ text: 'Country',datafield: 'country', width: '8%',cellclassname:cellclassname},         
							{ text: 'City',datafield: 'city', width: '8%',cellclassname:cellclassname},
							{ text: 'Hotel',datafield: 'hotel', width: '8%',cellclassname:cellclassname},          
	    					{ text: 'Room Type',datafield: 'roomtype', width: '8%',cellclassname:cellclassname},
							{ text: 'rowno',datafield: 'rowno', width: '7%',cellclassname:cellclassname,hidden:true},
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
<div id="jqxHotelGrid"></div>