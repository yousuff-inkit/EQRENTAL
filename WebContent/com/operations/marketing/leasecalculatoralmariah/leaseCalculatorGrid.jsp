<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralmariah.*" %>
<% String contextPath=request.getContextPath();%>
<% ClsLeaseCalcAlMariahDAO DAO=new ClsLeaseCalcAlMariahDAO();%>
<%String srno=request.getParameter("srno")==null?"0":request.getParameter("srno");%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<%String leasemonths=request.getParameter("leasemonths")==null?"0":request.getParameter("leasemonths");%>
<%String kmpermonth=request.getParameter("kmpermonth")==null?"0":request.getParameter("kmpermonth");%>
<%String grpid=request.getParameter("grpid")==null?"0":request.getParameter("grpid");%>
<%String leasereqdoc=request.getParameter("leasereqdoc")==null?"0":request.getParameter("leasereqdoc");%>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");%>
<style>
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
		var calcdata;
		if(id==1){
			 calcdata=<%=DAO.calculate(srno,leasemonths,kmpermonth,id,grpid,leasereqdoc,docno)%>;
		}
		else if(id==2){
			calcdata=<%=DAO.getCalculateView(docno,leasereqdoc,srno,id)%>;
		}
		else{
			
		}
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'details', type: 'string'},
     						{name : 'amount', type: 'number'},
     						{name : 'margin', type: 'number'},
     						{name : 'total',type:'number'},
     						{name : 'detaildocno',type:'number'},
     						{name : 'leasereqdocno',type:'number'},
     						{name : 'rdocno',type:'number'},
     						{name : 'srno',type:'number'},
     						{name : 'flow',type:'string'},
     						{name : 'view',type:'number'},
     						{name : 'msg',type:'string'},
     						{name : 'duration',type:'number'}
     						],
                         localdata: calcdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	
                if(typeof(value) == "undefined"){
                    value=0.00;
                   }
               	
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            }
            
            /* var cellclassname = function (row, column, value, data) {
                if(typeof(data.flow)=="undefined" || data.flow=="" || data.flow=="0"){
                	return ""; 
                }
                else if(data.flow=="1") {
                	//alert(data.amount);
                	return "redClass";
                }
                else if(data.flow=="2"){
                	return "greenClass";
                };
                  }; */
                  
                  var cellclassname = function (row, column, value, data) {
                      if (data.details=="Driver Cost") {
                          return "driverClass";
                      } else if (data.details=="Vehicle Value" || data.details=="Total Cost") {
                          return "greenClass";
                      };
                  };
            var dataAdapter = new $.jqx.dataAdapter(source);
            var rowlength=0;
            var temp1="";
            var amounts=0;
            $("#calculatorGrid").on("bindingcomplete", function (event) { 
            	var rows = $("#calculatorGrid").jqxGrid('getrows');
            	rowlength=rows.length;
            	if($('#calculatorGrid').jqxGrid('getcellvalue', 0, "msg")=="1"){
            		$.messager.alert('message','Cost sheet should be completed');
            	}
            	/* if($('#calculatorGrid').jqxGrid('getcellvalue', 0, "view")==0){
            		for(var i=0; i<rows.length; i++){
                		temp1=$('#calculatorGrid').jqxGrid('getcellvalue', i, "details");
                		amounts=$('#calculatorGrid').jqxGrid('getcellvalue', i, "amount");
                		if(temp1=="Fuel Cost" || temp1=="Salik" || temp1=="Total Cost" || temp1=="Driver Cost" || temp1=="Fuel Cost" || temp1=="Accessories" || temp1=="Security Pass"){
                			$('#calculatorGrid').jqxGrid('setcellvalue', i, "margin",0.00);
                			$('#calculatorGrid').jqxGrid('setcellvalue', i, "total",amounts);
                		}
                	}
            	} */
            	
            });
            
            $("#calculatorGrid").jqxGrid(
            {
                width: '100%',
                height: 1030,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                showstatusbar:false,
                selectionmode: 'singlecell',
                
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{ text: 'Details', datafield: 'details', width: '50%',editable:false,cellclassname:cellclassname},	
							{ text: 'Amount', datafield: 'amount',  width: '15%',cellsalign: 'right', align: 'right', cellsformat:'d2',editable:false,cellclassname:cellclassname},
							{ text: 'Margin', datafield: 'margin',  width: '15%',cellsalign: 'right', align: 'right', cellsformat:'d2',cellclassname:cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#calculatorGrid').jqxGrid('getcellvalue', row, "details");
								     if (temp=="Driver Cost" || temp=="Total Cost" || temp=="Security Pass" || temp=="Accessories")
								    	 {
								    			    	 
								       return true; 
								    	 }
								     else
								    	 {
								    	 return false; 

								    	 }
								  }},
							{ text: 'Total', datafield: 'total',  width: '15%',cellclassname:cellclassname,cellsalign: 'right', align: 'right', cellsformat:'d2',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'detaildocno', datafield: 'detaildocno',  width: '15%',hidden:false},
							{ text: 'leasereqdocno', datafield: 'leasereqdocno',  width: '15%',hidden:true},
							{ text: 'rdocno', datafield: 'rdocno',  width: '15%',hidden:true},
							{ text: 'Duration', datafield: 'duration',  width: '15%',hidden:true},
						]
            });



           
		 $('#calculatorGrid').on('cellvaluechanged', function (event) 
            { 
			 var rowBoundIndex = args.rowindex;
		     var datafield = event.args.datafield;
		      if(datafield=="margin"){
		    	  var amount=$('#calculatorGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
		    	  var margin=$('#calculatorGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
		    	  var duration=$('#calculatorGrid').jqxGrid('getcellvalue', rowBoundIndex, "duration");
		    	  var total=(amount*margin*0.01)+amount;
		    	  $('#calculatorGrid').jqxGrid('setcellvalue',rowBoundIndex, "total",total);
		    	  var detaildoc=$('#calculatorGrid').jqxGrid('getcellvalue', rowBoundIndex, "detaildocno");
		    	  var rows=$('#calculatorGrid').jqxGrid('getrows');
		    	  for(var i=0;i<rows.length;i++){
		    		  if(detaildoc=="37"){
		    			  var detaildocno=$('#calculatorGrid').jqxGrid('getcellvalue', i, "detaildocno");
		    			  if(detaildocno=="118"){
		    				  $('#calculatorGrid').jqxGrid('setcellvalue',i, "total",total/duration);
		    			  }
		    		  }
		    		  if(detaildoc=="89"){
		    			  var detaildocno=$('#calculatorGrid').jqxGrid('getcellvalue', i, "detaildocno");
		    			  if(detaildocno=="116"){
		    				  $('#calculatorGrid').jqxGrid('setcellvalue',i, "total",total/duration);
		    			  }
		    		  }
		    	  }
		    	  var netamt=0.0;
		    	  for(var i=0;i<rows.length;i++){
		    		  var detaildocno=$('#calculatorGrid').jqxGrid('getcellvalue', i, "detaildocno");
		    		  if(detaildocno=="37" || detaildocno=="89" || detaildocno=="90" || detaildocno=="91" || detaildocno=="92" || detaildocno=="93"){
		    			  netamt+=parseFloat($('#calculatorGrid').jqxGrid('getcellvalue', i, "total"));
		    		  		
		    		  }
		    	  }
		    	  alert(netamt);
		    	  for(var i=0;i<rows.length;i++){
		    		  var detaildocno=$('#calculatorGrid').jqxGrid('getcellvalue', i, "detaildocno");
		    		  if(detaildocno=="94"){
		    			  $('#calculatorGrid').jqxGrid('setcellvalue',i, "total",netamt);
		    		  }
		    		  if(detaildocno=="117"){
		    			  $('#calculatorGrid').jqxGrid('setcellvalue',i, "total",netamt/duration);
		    		  }
		    	  }
		    	/* 
		    	  var nettotalcost=$('#calculatorGrid').jqxGrid('getcellvalue',rowlength-2, "total")+
						    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-3, "total")+
						    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-4, "total")+
						    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-5, "total")+
						    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-6, "total")+
						    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-7, "total");
		    	  alert($('#calculatorGrid').jqxGrid('getcellvalue',rowlength-2, "total")+"::"+
				    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-3, "total")+"::"+
				    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-4, "total")+"::"+
				    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-5, "total")+"::"+
				    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-6, "total")+"::"+
				    	  $('#calculatorGrid').jqxGrid('getcellvalue',rowlength-7, "total")); */
				    	 // alert(amount+"//"+total);
		    	 // var summaryData= $("#calculatorGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
		    	 // $('#calculatorGrid').jqxGrid('setcellvalue',rowlength-1, "total",nettotalcost);
		      }
		           
            });
            
         $('#calculatorGrid').on('celldoubleclick', function (event) 
            { 
        	 var rowBoundIndex = args.rowindex;
	        	 var details=$('#calculatorGrid').jqxGrid('getcellvalue', rowBoundIndex, "details");
	        	
            }); 
         	            
        });
    </script>
    <div id="calculatorGrid"></div>
    
