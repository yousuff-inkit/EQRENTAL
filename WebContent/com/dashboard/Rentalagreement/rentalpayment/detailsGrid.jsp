<%@ page import="com.dashboard.rentalagreement.preauthrental.*" %>
<%ClsPreAuthRentalDAO crad=new ClsPreAuthRentalDAO(); %>

 <%

	String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
  	String status = request.getParameter("status")==null?"":request.getParameter("status").trim();
  	String fleet = request.getParameter("fleet")==null?"":request.getParameter("fleet").trim();
  	String agmtno = request.getParameter("agmtno")==null?"":request.getParameter("agmtno").trim();
  	String clientcat = request.getParameter("clientcat")==null?"":request.getParameter("clientcat").trim();
  	String type = request.getParameter("type")==null?"":request.getParameter("type").trim();
 	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
 %> 
 <script type="text/javascript">
 
var id='<%=id%>';
var shotterm;
if(id=="1")
{ 
	
	shotterm='<%=crad.paymentpreauth(branch,fromdate,todate,cldocno,status,fleet,agmtno,clientcat,type,id)%>';
}
else{
	shotterm;
}
        $(document).ready(function () { 
         
        	
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'String'  },
                 			{name : 'voc_no', type: 'String'  },
     						{name : 'refname', type: 'String'},
     						
     						 {name : 'fleet_no', type: 'String'}, 
     						 {name : 'vehdetails', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'odate', type: 'date'  },
     						{name : 'otime', type: 'String'  },
     						
     						
     						{name : 'ddate', type: 'date'  },
     						{name : 'dtime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'reg_no', type: 'string'  },
     						{name : 'gid', type: 'string'  },
     						{name : 'branchname', type: 'string'  },
     						{name : 'tdocno', type: 'string'  },
     						{name : 'insurexcess', type: 'number'  },                     
    						{name : 'cdwexcess', type: 'number'    },
    						{name : 'scdwexcess', type: 'number'    },
    						{name : 'insex', type: 'number'    },
     						
     						
    						
     						
     						
                          	],
                          	localdata: shotterm,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 305,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                 showfilterrow:true,
                columnsresize:true,
                enabletooltips:true,
                rowsheight:20,
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
                             { text: 'gid', datafield: 'gid', width: '2%',hidden:true },
                             { text: 'VRA NO', datafield: 'doc_no', width: '4%' ,hidden:true },
							{ text: 'RA NO', datafield: 'voc_no', width: '6%' },
							
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%' },
							{ text: 'Fleet Name', datafield: 'vehdetails', width: '13%' },
							{ text: 'Reg NO', datafield: 'reg_no', width: '5%' },
							{ text: 'Client Name', datafield: 'refname', width: '17%' },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%'},
							
							{ text: 'Mob NO', datafield: 'per_mob', width: '9%'},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
							 { text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'Out Time', datafield: 'otime', width: '5%' },
							
							 
							 
							 { text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy'},
								
							 { text: 'DueTime', datafield: 'dtime', width: '5%' },
							 
							 { text: 'tdocno', datafield: 'tdocno', width: '4%',hidden:true},
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
							 { text: 'branchname', datafield: 'branchname', width: '10%' ,hidden:true},
							 
							 
								{ text: 'rdocinsu', datafield: 'insex', width: '10%',cellsformat:'d2' ,hidden:true},
								{ text: 'insurexcess', datafield: 'insurexcess', width: '10%',cellsformat:'d2',hidden:true },
								{ text: 'cdwexcess', datafield: 'cdwexcess', width: '10%',cellsformat:'d2' ,hidden:true },
								{ text: 'scdwexcess TO', datafield: 'scdwexcess', width: '10%' ,cellsformat:'d2',hidden:true},
							 
					]
            });
     
       
            
       
		$("#detailsgrid").on("celldoubleclick", function (event)
				   { 
			 var rowindex2 = event.args.rowindex;
			 
			   $('#jqxgridpayment ').jqxGrid('setcellvalue', 0, "vocno" ,$('#detailsgrid').jqxGrid('getcellvalue', rowindex2, "voc_no"));
			   $('#jqxgridpayment ').jqxGrid('setcellvalue', 0, "rano" ,$('#detailsgrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
			   $('#jqxgridpayment ').jqxGrid('setcellvalue', 0, "brhid" ,$('#detailsgrid').jqxGrid('getcellvalue', rowindex2, "brhid"));
			   
			   var dates=$('#detailsgrid').jqxGrid('getcelltext', rowindex2, "odate");
			 //  alert(dates);
			   
			   $('#jqxgridpayment ').jqxGrid('setcellvalue', 0, "odate" ,dates);
			//   $("#jqxgridpayment").jqxGrid({ disabled: false});
            
			 });
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>