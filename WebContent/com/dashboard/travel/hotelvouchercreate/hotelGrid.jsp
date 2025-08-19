 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
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
		   unddata='<%=DAO.loadGrid(docno,branch,session) %>';                                
	  var rendererstring=function (aggregates){
	    	var value=aggregates['sum'];
	    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	    }  
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
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
							{name : 'cldocno' , type: 'string'}, 
							{name : 'vnddocno' , type: 'string'},  
							{name : 'sprice' , type: 'string'},   
							{name : 'deletes' , type: 'string'},     
							{name : 'cpudoc' , type: 'string'},          
				            {name : 'invtrno' , type: 'string'},      
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
						    { text: 'Supplier Conformation No',datafield: 'suppconfno', width: '7%',cellclassname:cellclassname}, 
	    					{ text: 'Customer',datafield: 'customer', width: '13%',cellclassname:cellclassname},
							{ text: 'Supplier',datafield: 'vendor', width: '13%',cellclassname:cellclassname}, 
							{ text: 'Issue Date',datafield: 'issuedate', width: '5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
						    { text: 'Issuing Staff', datafield: 'isstaff', width: '10%',cellclassname:cellclassname},
							{ text: 'Country',datafield: 'country', width: '8%',cellclassname:cellclassname},         
							{ text: 'City',datafield: 'city', width: '8%',cellclassname:cellclassname},
							{ text: 'Hotel',datafield: 'hotel', width: '10%',cellclassname:cellclassname},          
	    					{ text: 'Room Type',datafield: 'roomtype', width: '10%',cellclassname:cellclassname},
							{ text: 'rowno',datafield: 'rowno', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'cldocno',datafield: 'cldocno', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'vnddocno',datafield: 'vnddocno', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'Selling Price',datafield: 'sprice', width: '7%',cellclassname:cellclassname}, 
							{ text: '',datafield: 'deletes',columntype: 'button',filterable: false, width: '5%',cellclassname:cellclassname},
							{ text: 'cpudoc',datafield: 'cpudoc', width: '10%',cellclassname:cellclassname,hidden:true},
							{ text: 'invtrno',datafield: 'invtrno', width: '10%',cellclassname:cellclassname,hidden:true},     
						]                                                             
                });  
                   $("#overlay, #PleaseWait").hide();       
                   $('#TravelGrid').on('celldoubleclick', function (event){                
                   var rowindex2 = event.args.rowindex;    
                   document.getElementById("hidrowno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "rowno");
                   document.getElementById("hidcpudoc").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "cpudoc");                                 
                   document.getElementById("hidinvtrno").value=$('#TravelGrid').jqxGrid('getcellvalue', rowindex2, "invtrno");    
                   document.getElementById("mode").value="VIEW";      
                   document.getElementById("frmhotelvouchercreate").submit();         
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