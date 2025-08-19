<%@page import="com.dashboard.travel.ticketvouchercreate.ClsTicketVoucherCreateDAO"%>   
<%  ClsTicketVoucherCreateDAO sd=new ClsTicketVoucherCreateDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>           
<%@page import="javax.servlet.http.HttpSession" %>   
<%                 
    String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
    String branch=request.getParameter("branch")==null || request.getParameter("branch")==""?"0":request.getParameter("branch").toString();   
%>      
 <style type="text/css">  
  .AClass
  {
      background-color: #FBEFF5;
  }
  .BClass
  {
      background-color: #E0F8F1;
  }
  .CClass
  {
     background-color: #f3fab9;
  }
    .DClass
  {
     background-color: #ff9696 ;     
  }
</style>    
<script type="text/javascript">          
var unddata;
var dataexcel;
		   unddata='<%=sd.loadGrid(docno,branch,session) %>';                           
	  var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	    }  
$(document).ready(function(){              
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
				            {name : 'cpudoc' , type: 'string'},          
				            {name : 'invtrno' , type: 'string'},  
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
							{name : 'sprice' , type: 'string'},   
							{name : 'deletes' , type: 'string'},          
             ],                  
             localdata: unddata,    
            
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
        $("#TravelGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlecell',
                  	editable:false,
                    altrows:true,
                    sortable: true,  
                    columnsresize: true,   
                    //Add row method
                    columns: [  
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname:cellclassname, width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						    { text: 'Ticket No',datafield: 'ticketno', width: '5%',cellclassname:cellclassname}, 
	    					{ text: 'Customer',datafield: 'customer',cellclassname:cellclassname, width: '11%'},
							{ text: 'Supplier',datafield: 'vendor', width: '11%',cellclassname:cellclassname}, 
							{ text: 'Customer ID',datafield: 'cldocno', width: '12%',cellclassname:cellclassname,hidden:true},
							{ text: 'Supplier ID',datafield: 'vnddocno', width: '12%',cellclassname:cellclassname,hidden:true}, 
							{ text: 'Booking Date',datafield: 'bookdate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Issue Date',datafield: 'issuedate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Guest',datafield: 'guest', width: '11%',cellclassname:cellclassname},         
							{ text: 'Airline',datafield: 'airline', width: '11%',cellclassname:cellclassname},
							{ text: 'Airline ID',datafield: 'airlineid', width: '11%',cellclassname:cellclassname,hidden:true},   							
							{ text: 'Sector',datafield: 'sector', width: '9%',cellclassname:cellclassname},          
	    					{ text: 'Class',datafield: 'classes', width: '9%',cellclassname:cellclassname},
							{ text: 'rowno',datafield: 'rowno', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'cpudoc',datafield: 'cpudoc', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'invtrno',datafield: 'invtrno', width: '10%',cellclassname:cellclassname,hidden:true},  
							{ text: 'PRN No',datafield: 'prnno', width: '7%',cellclassname:cellclassname}, 
							{ text: 'Selling Price',datafield: 'sprice', width: '7%',cellclassname:cellclassname}, 
							{ text: '',datafield: 'deletes',columntype: 'button',filterable: false, width: '5%',cellclassname:cellclassname},        
						]                                                         
                });  
                 $("#overlay, #PleaseWait").hide();       
                 $('#TravelGrid').on('celldoubleclick', function (event){                         
                 var rowindex2 = event.args.rowindex;    
                 document.getElementById("hidrowno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "rowno");  
                 document.getElementById("hidcpudoc").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "cpudoc");                                 
                 document.getElementById("hidinvtrno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "invtrno");                     
                 document.getElementById("mode").value="VIEW";       
                 document.getElementById("frmticketvouchercreate").submit();
                 }); 
                 $('#TravelGrid').on('cellclick', function (event){       
  		            	var rowindex1=event.args.rowindex;
  		            	var datafield = event.args.datafield;
  		            	var rows1=$('#TravelGrid').jqxGrid('getrows');
  		            	var rowno=$('#TravelGrid').jqxGrid('getcellvalue', rowindex1, "rowno");
  		            	var cpudoc=$('#TravelGrid').jqxGrid('getcellvalue', rowindex1, "cpudoc");
  		            	var invtrno=$('#TravelGrid').jqxGrid('getcellvalue', rowindex1, "invtrno");   
  		            	if(datafield=="deletes"){
  		            	    if(rows1.length>1){
  		            	        if(!parseInt(cpudoc)>0 && !parseInt(invtrno)>0){        
								   fungriddelete(rowno);    		            	    
  		            	        }else{
							        swal({
											type: 'warning',
											title: 'Warning',  
											text: ' You cannot edit the document. Purchase or Travel Invoice already created for the document!!!'         
										});
										return false;           
  		            	        }   
  		            	    }
 		            	}
                });
	});      
</script>
   <div id="TravelGrid"></div>   