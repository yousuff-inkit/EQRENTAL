<%@page import="com.operations.marketing.leasecalculatoralmariah.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String reqdocno=request.getParameter("leasereqdocno")==null?"0":request.getParameter("leasereqdocno");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String srno=request.getParameter("srno")==null?"0":request.getParameter("srno");
String leasemonths=request.getParameter("leasemonths")==null?"0":request.getParameter("leasemonths");
ClsLeaseCalcAlMariahDAO DAO=new ClsLeaseCalcAlMariahDAO();%>
<style>
.focusClass{
	background-color:#5ae1b5;
}
.redClass
{
    background-color: #F35A48;
}
.greenClass
{
    background-color: #5ae1b5;
}
.blueClass
{
    background-color: #489BF3;
}
.driverClass{
	background-color: #FFD1B8;
}
</style>
<script type="text/javascript">
		var id='<%=id%>';
		var ddata;
		var leasemonths='<%=leasemonths%>';
		
		
		if(id==1){
			ddata=<%=DAO.getDetailViewData(id,reqdocno,docno,srno)%>;
		}
		<%-- else if(id==2){
			alert("bfro grid"); --%>
			
			
			
		/* 	alert("after grid" +ddata);
		} 
		else{
			
		} */
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'details', type: 'string'},
     						{name : 'amount', type: 'string'},
     						{name : 'doc_no', type: 'number'},
                        ],
                         localdata: ddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
			
            $("#detailGrid").on("bindingcomplete", function (event) {
            	// your code here.
            	id='<%=id%>';
            	if(id=="1"){
            		var rows=$('#detailGrid').jqxGrid('getrows');
            		for(var i=0;i<rows.length;i++){
            			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="112"){
            				var annualticket=(1200/24)*parseInt(leasemonths);
            				$('#detailGrid').jqxGrid('setcellvalue',i,'amount',annualticket);
            			}
            			
            		}
            		
            	}
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var cellsrenderer = function (row, columnfield, value, defaulthtml, columnproperties) {
            	var detail=$('#detailGrid').jqxGrid('getcellvalue',row, "details");
            	if(detail!="Authority"){
					var res=parseFloat(value).toFixed(window.parent.amtdec.value);
					var res1=(res=='NaN'?"0":res);
					value=res1;
					return '<span style="margin: 4px; float:right;">' + value + '</span>';
            	}
            	else{
            		return '<span style="margin: 4px; float:left;">' + value + '</span>';
            	}
            }
            var cellclassname = function (row, column, value, data) {
                /* if (data.details=="Total Driver Cost") {
                    return "blueClass";
                } else  */
                if (data.details=="Vehicle cost" || data.details=="Down pyt % " || data.details=="Interest %" || data.details=="Authority" || 
                		data.details=="Profit %" || data.details=="Overhead %" || data.details=="Others" || data.details=="Replacement Cost %" 
                		|| data.details=="Sticker & Branding" || data.details=="Car Tracky Monthly Etisalat" || data.details=="GPS" || 
                		data.details=="Parking Fee") {
                    return "greenClass";
                }
                else if(data.details=="Driver salary per month" || data.details=="Training per Month"  || data.details=="Telephone & Sim per month"
                	 || data.details=="Recharge Card per month" || data.details=="Overtime per month"  || data.details=="Allowance per month" 
                	 || data.details=="Insurance Driver Compensation per month" || data.details=="Medical Insurance per month" || 
                	 data.details=="Laundry or Cleaning"  || data.details=="Transportation" || data.details=="Visa Fee" || 
                	 data.details=="Annual Leave"  || data.details=="Annual Ticket" || data.details=="End of Service"  || 
                	 data.details=="Uniform" || data.details=="Food"  || data.details=="Accommodation"  || 
                	 data.details=="Total Driver Cost"  || data.details=="Driver Reliver"){
                	return "driverClass";
                }
            };
            $("#detailGrid").jqxGrid(
            {
                width: '100%',
                height:1030,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                columns: [
							{ text: 'Sr.No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '6%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{text: 'Details',  datafield: 'details', width: '64%',editable: false,cellclassname: cellclassname},	
							{text: 'Amount',  datafield: 'amount',  width: '30%',cellsalign: 'right', align: 'right',cellclassname: cellclassname, cellsrenderer: cellsrenderer,
								cellbeginedit: function (row) {
									var detail=$('#detailGrid').jqxGrid('getcellvalue',row, "details");
									var temp="";
									if(detail=="Driver salary per month" || detail=="Training per Month"  || detail=="Telephone & Sim per month"
					                	 || detail=="Recharge Card per month" || detail=="Overtime per month"  || detail=="Allowance per month" 
					                    	 || detail=="Insurance Driver Compensation per month" || detail=="Medical Insurance per month" || 
					                    	 detail=="Laundry or Cleaning"  || detail=="Transportation" || detail=="Visa Fee" || 
					                    	 detail=="Annual Leave"  || detail=="Annual Ticket" || detail=="End of Service"  || 
					                    	 detail=="Uniform" || detail=="Food"  || detail=="Accommodation"  || 
					                    	 detail=="Total Driver Cost"  || detail=="Driver Reliver"){
										temp=document.getElementById("driver").value;
									}else if(detail=="Salik"){
										temp=document.getElementById("salik").value;
									}else if(detail=="Securiy pass"){
										temp=document.getElementById("securitypass").value;
									}else if(detail=="Fuel cost per litre"){
										temp=document.getElementById("fuel").value;
									}else if(detail=="Spark arrestor" || detail=="Chalwyn valve" || detail=="Seat belts" || detail=="Curtain" || detail=="Reverse Alarm" || detail=="Camara" || detail=="Roll over protection" || detail=="IVMS"){
										temp=document.getElementById("safetyaccess").value;
									}else{
										temp="";
									}
									
								     if (temp=="No")
								    	 {
								    	 return false; 
								    	 }
								  }
								  },
							{text: 'Details',  datafield: 'doc_no',  width: '30%',hidden:true,cellclassname: cellclassname},
						]
            });




		 /* $('#detailGrid').on('cellvaluechanged', function (event) 
            { 
			 var rowBoundIndex = args.rowindex;
			 var datafield = event.args.datafield;
		     if(datafield=="amount")
		        {
		    	 var details=$('#detailGrid').jqxGrid('getcellvalue', rowBoundIndex, "details");
		    	 var amount=$('#detailGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
		    	 if(details!="Authority"){
		    		 if($.isNumeric(amount)==false){
		    			 $.messager.alert('warning','Only Numbers allowed');
		    			// document.getElementById("errormsg").innerText="Only Numbers allowed";
		    			 $('#detailGrid').jqxGrid('setcellvalue', rowBoundIndex, "amount",0);
							return false;
						}
					}
		        }
            });
             */
         $('#detailGrid').on('celldoubleclick', function (event) 
            { 
        	 var rowBoundIndex = args.rowindex;
        	 document.getElementById("rowindex").value = rowBoundIndex;
		     var datafield = event.args.datafield;
		     if(datafield=="amount")
		        {
		    	 var details=$('#detailGrid').jqxGrid('getcellvalue', rowBoundIndex, "details");
		    	 if(details=="Authority"){
		    		 $('#authoritywindow').jqxWindow('open');
		 			 $('#authoritywindow').jqxWindow('focus');
		 			 authoritySearchContent('authoritySearch.jsp');	 
					}
		        }
            }); 
         	   
         $("#detailGrid").on('cellvaluechanged', function (event) 
        		 {
        		     // event arguments.
        		     var args = event.args;
        		     // column data field.
        		     var datafield = event.args.datafield;
        		     // row's bound index.
        		     var rowBoundIndex = args.rowindex;
        		     // new cell value.
        		     var value = args.newvalue;
        		     // old cell value.
        		     var oldvalue = args.oldvalue;
        		     
        		     var docno=$('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');
        		     if(docno=="7" || docno=="100" || docno=="101" || docno=="102" || docno=="104" || docno=="105" || docno=="106" || docno=="107" || docno=="108" || docno=="109" || docno=="110" || docno=="111" || docno=="112" || docno=="113" || docno=="9" || docno=="10" || docno=="11"){
        		    	var rows=$('#detailGrid').jqxGrid('getrows');
                 		var driversalary=0.0,training=0.0,telephone=0.0,recharge=0.0,overtime=0.0,allowance=0.0,compensation=0.0,
                 		medical=0.0,cleaning=0.0,transportation=0.0,visa=0.0,annualleave=0.0,annualticket=0.0,endofservice=0.0,
                 		uniform=0.0,food=0.0,accomodation=0.0,totaldriver=0.0,driverreliver=0.0;
        		    	for(var i=0;i<rows.length;i++){
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="7"){
                				driversalary=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                				endofservice=parseFloat(((driversalary*21)*12)/365);
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="100"){
        		    			training=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="101"){
        		    			telephone=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="102"){
        		    			recharge=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="104"){
        		    			overtime=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="105"){
        		    			allowance=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="106"){
        		    			compensation=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="107"){
                				medical=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="108"){
                				cleaning=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="109"){
                				transportation=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="110"){
                				visa=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="111"){
                				annualleave=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="112"){
                				annualticket=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="113"){
                				/* endofservice=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount')); */
                				$('#detailGrid').jqxGrid('setcellvalue',i,'amount',endofservice);
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="9"){
                				uniform=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="10"){
                				food=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
                			if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="11"){
                				accomodation=parseFloat($('#detailGrid').jqxGrid('getcellvalue',i,'amount'));
                			}
        		    		totaldriver=driversalary+training+telephone+recharge+overtime+allowance+compensation+
                 		medical+cleaning+transportation+visa+annualleave+annualticket+endofservice+
                 		uniform+food+accomodation;
						driverreliver=totaldriver*0.01;
							if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="114"){
                				$('#detailGrid').jqxGrid('setcellvalue',i,'amount',totaldriver);
                			}
							if($('#detailGrid').jqxGrid('getcellvalue',i,'doc_no')=="115"){
                				$('#detailGrid').jqxGrid('setcellvalue',i,'amount',driverreliver);
                			}
                 		}
        		     }
        		 });
         
        });
    </script>
    <div id="detailGrid"></div>
    
