<%@page import="com.dashboard.limousine.limoconfirmed.*" %>
<% ClsLimoConfirmedDAO dao=new ClsLimoConfirmedDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<style type="text/css">
	.ReservationClass{
		background-color:#FFEBEB;	
	}
	.JobAssignedClass{
		background-color:#e8d4b4;
	}
	.DriverAcceptedClass{
		background-color:#e8d4b4;
	}
	.ChangeinTimeClass{
		background-color:#c06c84;
	}
	.WaitingforguestClass{
		background-color:#F6F874;
	}
	.TripStartedClass{
		background-color:#B5E3AE;
	}
	.TripEndedClass{
		background-color:#296620;
		color:#fff;
	}
	.NoshowClass{
		background-color:#AEAF9D;
	}
	.cancelClass{
		background-color:#DBA67B;
	}
    .redClass
    {
        background-color: #EC7063;   
    }
    
    .blueClass
    {
        background-color: #42cef4;
    }
    .yellowClass
    {
        background-color: #FFFFD1;
    }
     .greyClass
    {
        background-color: #BDC3C7;
    }
    .NoVendorAmtClass{
    	background-color:#E88375;
    }
</style>
<script type="text/javascript">
var data,dataexcel;                   
	data='<%=dao.gridData(branch,id,fromdate,todate)%>';
$(document).ready(function () {    
        var source =
           {
           datatype: "json",
           datafields: [
                    	{name : 'datval',type:'int'},
                     	{name : 'rowno',type:'string'},
                     	{name : 'remarks',type:'string'}, 
                      	{name : 'fname',type:'string'},  
                      	{name : 'fno',type:'string'},
                      	{name : 'status',type:'string'},
                       	{name : 'docno' , type: 'string' },
                       	{name : 'tdocno',type:'int'},
                       	{name : 'job',type:'string'},       
                       	{name : 'client' , type:'string'},
                       	{name : 'cldocno',type:'string'},
                       	{name : 'guestno',type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'pickupdate',type:'date'},
                       	{name : 'pickuptime',type:'date'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'brand',type:'string'},
                       	{name : 'model',type:'string'},
                       	{name : 'nos',type:'string'},
                       	{name : 'groupname',type:'string'},
                       	{name : 'tarifdocno',type:'number'},
                       	{name : 'tarifdetaildocno',type:'number'},
                       	{name : 'guestdetails',type:'string'},
                       	{name : 'drivername',type:'string'},
                       	{name : 'bookremarks',type:'string'},
                       	{name : 'regdetails',type:'string'},
                       	{name : 'pax',type:'string'},
                       	{name : 'otherdetails',type:'string'},
                       	{name : 'triptype',type:'string'},
                       	{name : 'refno',type:'string'},
                       	{name : 'assigntype',type:'string'},
                       	{name : 'vendoramount',type:'number'},
                       	{name : 'vendordiscount',type:'number'},
                       	{name : 'vendornetamount',type:'number'},
                       	{name : 'bstatus',type:'number'},
                       	{name : 'invoicevalue',type:'number'},
                       	{name : 'purchasevalue',type:'number'},
     				   ],
					localdata:data,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        
			var cellclassname = function (row, column, value, data) {
          		if (data.datval==1) {                     
        		    //   		return "redClass";
          		};
          		if(data.status=="Reservation"){
        	  		//return "ReservationClass";
          		}
          		else if(data.status=="Job Assigned"){
        	  		//return "JobAssignedClass";
          		}
				else if(data.status=="Driver Accepted"){
        	  		return "DriverAcceptedClass";
          		}
				else if(data.status=="Change in Time"){
					return "ChangeinTimeClass";
				}
				else if(data.status=="Waiting for guest"){
					return "WaitingforguestClass";
				}
				else if(data.status=="Trip Started"){
					return "TripStartedClass";  
				}
				else if(data.status=="Trip Ended"){
					return "TripEndedClass";  
				}
				else if(data.status=="No show"){
					return "NoshowClass"; 
				}
				else if(data.status=="Cancel"){
					return "cancelClass";
				}
				if(data.assigntype=='3' && parseFloat(data.vendornetamount)==0.0){
					return "NoVendorAmtClass";
				}
          
       };
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jqxbookGrid").jqxGrid(
            {
               width: '100%',
               height: 520,
               source: dataAdapter,
               columnsresize: true,
               editable:false,  
               enabletooltips:true, 
               sortable:true,
               showfilterrow:true,
               filterable:true,       
               selectionmode: 'checkbox',                         
               columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},  
							{ text: 'Pickup date',datafield:'pickupdate',width:'5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Pickup time',datafield:'pickuptime',width:'4%',cellsformat:'HH:mm',cellclassname:cellclassname},
							{ text: 'Ref No',datafield:'refno',width:'3%',cellclassname:cellclassname},
							{ text: 'Other Details',datafield:'otherdetails',width:'10%',cellclassname:cellclassname},
							{ text: 'Fleet Name',datafield:'fname',width:'8%',cellclassname:cellclassname},
							{ text: 'No',datafield:'fno',width:'8%',cellclassname:cellclassname,hidden:true},   
							{ text: 'Fleet',datafield:'regdetails',width:'8%',cellclassname:cellclassname}, 
							{ text: 'Driver/Vendor',datafield:'drivername',width:'8%',cellclassname:cellclassname},  
							{ text: 'PAX',datafield:'pax',width:'2%',cellclassname:cellclassname},
							{ text: 'Assign Type',datafield:'assigntype',width:'2%',cellclassname:cellclassname,hidden:true},
							{ text: 'Booking Remarks',datafield:'bookremarks',width:'8%',cellclassname:cellclassname},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'8%',cellclassname:cellclassname},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'8%',cellclassname:cellclassname},
							{ text: 'Guest',datafield:'guest',width:'8%',cellclassname:cellclassname},
							{ text: 'Client',  datafield: 'client',width:'12%',cellclassname:cellclassname},
							{ text: 'Trip Type',  datafield: 'triptype',width:'6%',cellclassname:cellclassname},
							{ text: 'DateVal', datafield: 'datval',width:'4%',hidden:true},
                            { text: 'Row No', datafield: 'rowno',width:'4%',hidden:true},
							{ text: 'Doc No', datafield: 'docno',width:'4%',cellclassname:cellclassname},                  
							{ text: 'Detail Docno',datafield:'tdocno',width:'4%',hidden:true},
							{ text: 'Job Name',datafield:'job',width:'4.5%',cellclassname:cellclassname},
							{ text: 'Client ID',datafield:'cldocno',width:'4%',hidden:true},
							{ text: 'Guest ID',datafield:'guestno',width:'4%',hidden:true},
							{ text: 'Type',datafield:'type',width:'5%',cellclassname:cellclassname},
							{ text: 'Status',datafield:'status',width:'8%',cellclassname:cellclassname},   
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%',cellclassname:cellclassname,hidden:true},
							{ text: 'Brand',datafield:'brand',width:'8%',cellclassname:cellclassname,hidden:true},
							{ text: 'Model',datafield:'model',width:'8%',cellclassname:cellclassname,hidden:true},
							{ text: 'Nos',datafield:'nos',width:'3%',cellclassname:cellclassname},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%',cellclassname:cellclassname},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%',cellclassname:cellclassname},
							{ text: 'Remarks',datafield:'remarks',width:'15%',cellclassname:cellclassname},
							{ text: 'Tarif Doc No',datafield:'tarifdocno',width:'15%',cellclassname:cellclassname,hidden:true},
							{ text: 'Tarif Detail Doc No',datafield:'tarifdetaildocno',width:'15%',cellclassname:cellclassname,hidden:true},
							{ text: 'Group',datafield:'groupname',width:'4%',cellclassname:cellclassname},
							{ text: 'Vendor Amount',datafield:'vendoramount',width:'8%',cellclassname:cellclassname,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Vendor Discount',datafield:'vendordiscount',width:'4%',cellclassname:cellclassname,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Vendor Net',datafield:'vendornetamount',width:'4%',cellclassname:cellclassname,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Purchase Value',datafield:'purchasevalue',width:'4%',cellclassname:cellclassname,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Invoice Value',datafield:'invoicevalue',width:'4%',cellclassname:cellclassname,cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'BStatus',datafield:'bstatus',width:'4%',cellclassname:cellclassname,hidden:true},
         	              ]   
            });  
    	    $("#overlay, #PleaseWait").hide();    
/*    	    $('#jqxbookGrid').jqxGrid('autoresizecolumns'); */
            $("#jqxbookGrid").on("celldoubleclick", function (event)      
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = args.visibleindex;
            		    // right click.
            		    var rightClick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    // column index.
            		    var columnIndex = args.columnindex;
            		    // column data field.
            		    var dataField = args.datafield;
            		    // cell value
            		    var value = args.value;      
            		    document.getElementById("txtrowno").value=$('#jqxbookGrid').jqxGrid('getcellvalue',rowBoundIndex,'rowno');
            		    document.getElementById("txtdocno").value=$('#jqxbookGrid').jqxGrid('getcellvalue',rowBoundIndex,'tdocno');
            		    document.getElementById("bdocno").value=$('#jqxbookGrid').jqxGrid('getcellvalue',rowBoundIndex,'docno');
            		    $('.comments-container').html('');          
            		});                          
            });    
 </script>
<div id="jqxbookGrid"></div>