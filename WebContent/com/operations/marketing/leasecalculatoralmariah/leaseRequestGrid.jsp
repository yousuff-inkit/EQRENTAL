<%@page import="com.dashboard.leaseagreement.ClsleaseagreementDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecalculatoralmariah.*" %>
<% String contextPath=request.getContextPath();%>
<%String reqdocno=request.getParameter("reqdocno")==null?"0":request.getParameter("reqdocno");%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>
<%String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");%>
<%ClsLeaseCalcAlMariahDAO DAO=new ClsLeaseCalcAlMariahDAO();%>
<style>
.focusClass{
	background-color:#5ae1b5;
}
</style>
<script type="text/javascript">
		var reqdocno='<%=reqdocno%>';
		
		var id='<%=id%>';
		var reqdata;
		if(reqdocno!="0" && reqdocno!=""){
			reqdata='<%=DAO.getRequestData(reqdocno,id,docno)%>';
		}
		else{
			
		}
        
		$(document).ready(function() { 
                   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'leasefromdate', type: 'date' }, 
     						{name : 'brand', type: 'string'   },
     						{name : 'model', type: 'string'  },
     						{name : 'brdid', type: 'number'   },
     						{name : 'modelid', type: 'number'  },
     						{name : 'leasemonths', type: 'number' },
     						{name : 'kmpermonth',type:'number'},
     						{name : 'driver',type:'string'},
     						{name : 'security_pass',type:'string'},
     						{name : 'fuel',type:'string'},
     						{name : 'salik',type:'string'},
     						{name : 'safetyaccessories',type:'string'},
     						{name : 'ratepermonth',type:'number'},
     						{name : 'exkmcharge',type:'number'},
     						{name : 'ddiw',type:'number'},
     						{name : 'dhpd',type:'number'},
     						{name : 'rateperexhour',type:'number'},
     						
     						{name : 'fsavestatus', type: 'number'   },
     						{name : 'savestatus', type: 'number'   },
     						{name : 'confirmstatus', type: 'number'   },
     						{name : 'rowcolor', type: 'number'   },
     						{name : 'srno', type: 'number'   },
     						{name : 'grpid', type: 'number'   },
     						{name : 'gname', type: 'string'   },
     						{name : 'leasereqdocno', type: 'string'   },
     						{name : 'loadgrid',type:'string'},
     						{name : 'quotbtn', type: 'String'  },
     						
                        ],
                         localdata: reqdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var cellclassname = function (row, column, value, data) {
                if(data.rowcolor=="1"){
                	return "focusClass";
                }
                else{
                	
                }
                  };
            var dataAdapter = new $.jqx.dataAdapter(source);
            var dropdownListSource=['Yes','No'];
            
            $("#leaseReqGrid").jqxGrid(
            {
                width: '100%',
                height: 130,
                source: dataAdapter,
     
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    							groupable: false, draggable: false, resizable: false,datafield: '',
    							columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
    							cellsrenderer: function (row, column, value) {
     								return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}
							},
							{ text: 'Lease From', datafield: 'leasefromdate',  width: '7%',cellsformat:'dd.MM.yyyy',hidden:true,cellclassname:cellclassname},	
							{ text: 'Brand', datafield: 'brand', width: '10%',editable: false,cellclassname:cellclassname},	
							{ text: 'Model', datafield: 'model',  width: '8%',editable: false,cellclassname:cellclassname},
							{ text: 'Group', datafield: 'gname',  width: '5%',editable: false,cellclassname:cellclassname},
							{ text: 'Lease In Month', datafield: 'leasemonths',  width: '6%',editable: false,cellclassname:cellclassname},
							{ text: 'KM / Month', datafield: 'kmpermonth',  width: '5%',editable: false,cellsalign: 'right', align: 'right', cellsformat:'d2',cellclassname:cellclassname},
							{ text: 'Driver', datafield: 'driver',  width: '5%',columntype: 'dropdownlist',cellclassname:cellclassname,
								initeditor: function (row, cellvalue, editor) {
			                          editor.jqxDropDownList({ source: dropdownListSource});
			                      },
			                      cellbeginedit: function (row) {
										var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "fsavestatus");
									     if (temp=="1")
									    	 {
									       return false; 
									    	 }
									  }},
							{ text: 'Security Pass', datafield: 'security_pass',  width: '6%',columntype: 'dropdownlist',cellclassname:cellclassname,
								initeditor: function (row, cellvalue, editor) {
					                  editor.jqxDropDownList({ source: dropdownListSource});
					               },
					               cellbeginedit: function (row) {
										var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "fsavestatus");
									     if (temp=="1")
									    	 {
									       return false; 
									    	 }
									  }},
							{ text: 'Fuel', datafield: 'fuel',  width: '5%',columntype: 'dropdownlist',cellclassname:cellclassname,
								initeditor: function (row, cellvalue, editor) {
							          editor.jqxDropDownList({ source: dropdownListSource});
							       },
							       cellbeginedit: function (row) {
										var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "fsavestatus");
									     if (temp=="1")
									    	 {
									       return false; 
									    	 }
									  }},
							{ text: 'Salik', datafield: 'salik',  width: '5%',columntype: 'dropdownlist',cellclassname:cellclassname,
								initeditor: function (row, cellvalue, editor) {
									  editor.jqxDropDownList({ source: dropdownListSource});
								   },
								   cellbeginedit: function (row) {
										var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "fsavestatus");
									     if (temp=="1")
									    	 {
									       return false; 
									    	 }
									  }},
							{ text: 'Safety Acc..', datafield: 'safetyaccessories',  width: '5%',columntype: 'dropdownlist',cellclassname:cellclassname,
								initeditor: function (row, cellvalue, editor) {
					                  editor.jqxDropDownList({ source: dropdownListSource});
					               },
					               cellbeginedit: function (row) {
										var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "fsavestatus");
									     if (temp=="1")
									    	 {
									       return false; 
									    	 }
									  }},
							
							
							{ text: 'DIW', datafield: 'ddiw',  width: '3%',cellclassname:cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "savestatus");
								     if (temp=="1")
								    	 {
								       return false; 
								    	 }
								  }},
							{ text: 'HPD', datafield: 'dhpd',  width: '3%',cellclassname:cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "savestatus");
								     if (temp=="1")
								    	 {
								    			    	 
								       return false; 
								    	 }
								  }},
							{ text: 'Rate / Ex.Hour', datafield: 'rateperexhour',  width: '6%',cellsalign: 'right', align: 'right', cellsformat:'d2',cellclassname:cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "savestatus");
								     if (temp=="1")
								    	 {
								    			    	 
								       return false; 
								    	 }
								  }},
							{ text: 'Excess KM Chg', datafield: 'exkmcharge',  width: '6%',cellsalign: 'right', align: 'right', cellsformat:'d2',cellclassname:cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#leaseReqGrid').jqxGrid('getcellvalue', row, "savestatus");
								     if (temp=="1")
								    	 {
								    			    	 
								       return false; 
								    	 }
								  }},
							{ text: 'Rate / Month', datafield: 'ratepermonth',  width: '6%',cellsalign: 'right', align: 'right', cellsformat:'d2',editable:false,cellclassname:cellclassname},
							
							{ text: ' ', datafield: 'quotbtn', width: '6%',columntype: 'button',editable:false, filterable: false,cellclassname:cellclassname},
							{ text: ' ',datafield: 'loadgrid', width: '6%',columntype: 'button',editable:false, filterable: false,cellclassname:cellclassname},
							{ text: 'Brandid', datafield: 'brdid', width: '10%',hidden:true,cellclassname:cellclassname},	
							{ text: 'Modelid', datafield: 'modelid',  width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'savestatus', datafield: 'savestatus', width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'confirmstatus', datafield: 'confirmstatus',  width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'rowcolor', datafield: 'rowcolor',  width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'srno', datafield: 'srno',  width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'grpid', datafield: 'grpid',  width: '10%',hidden:true,cellclassname:cellclassname},
							{ text: 'leasereqdocno', datafield: 'leasereqdocno',  width: '10%',hidden:true,cellclassname:cellclassname},
							
						]
            });




            $('#leaseReqGrid').on('cellclick', function (event) 
           		{ 
             
		           var data=args.datafield;
				   if(data=="quotbtn"){
		            	// alert("===="+event.args.rowindex);
		    			var value = $('#leaseReqGrid').jqxGrid('getcelltext', event.args.rowindex, "quotbtn");
		    			// alert("=== "+value);
		    			
		    			if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
		      		  	  
		     		  	    var url=document.URL;
							 //alert(url);
							var reurl=url.split("com/");
							 // alert(reurl[0]);       
							$("#docno").prop("disabled", false);
							
							var win= window.open(reurl[0]+"com/operations/marketing/leasecalculatoralmariah/printAlmariah?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						      
							 win.focus();
				    			}
		    		}
		    		else if(data=="loadgrid"){
		    		        	 var rowindex1=event.args.rowindex;
		    		        	 document.getElementById("driver").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'driver');
				document.getElementById("securitypass").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'security_pass');
				document.getElementById("fuel").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'fuel');
				document.getElementById("salik").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'salik');
				document.getElementById("safetyaccess").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'safetyaccessories');	
				document.getElementById("leasemonths").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
				document.getElementById("kmpermonth").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
				document.getElementById("srno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
				document.getElementById("grpid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'grpid');
				document.getElementById("leasereqdoc").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasereqdocno');
		    			document.getElementById("savestatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus');
        	 if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus')=="1"){
					
					var srno=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
					var leasereqdocno=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasereqdocno');
					var docno=document.getElementById("docno").value;
					document.getElementById("btnconfirm").disabled=false;
					$('#leaseReqGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
					var leasemonths=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
					$('#calculatordiv').load('leaseCalculatorGrid.jsp?srno='+srno+'&leasereqdoc='+leasereqdocno+'&docno='+docno+'&id=2');
					$('#detaildiv').load('detailGrid.jsp?srno='+srno+'&leasereqdocno='+leasereqdocno+'&docno='+docno+'&id=1&leasemonths='+leasemonths);
					
				}
				else{
					$('#calculatorGrid').jqxGrid('clear');
					document.getElementById("btncalculate").disabled=false;
					document.getElementById("btnleasesave").disabled=false;
					document.getElementById("btnconfirm").disabled=true;
					var srno=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
					var leasereqdocno=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasereqdocno');
					var docno=document.getElementById("docno").value;
					$('#leaseReqGrid').jqxGrid('setcellvalue',rowindex1,'rowcolor','1');
					document.getElementById("savestatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'savestatus');
					document.getElementById("confirmstatus").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus');
					document.getElementById("leasemonths").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
					document.getElementById("kmpermonth").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
					document.getElementById("srno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
					document.getElementById("grpid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'grpid');
					var leasemonths=document.getElementById("leasemonths").value;
					$('#detaildiv').load('detailGrid.jsp?srno='+srno+'&leasereqdocno='+leasereqdocno+'&docno='+docno+'&id=1&leasemonths='+leasemonths);
				}
				    if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="1"){
					document.getElementById("btncalculate").disabled=true;
					document.getElementById("btnleasesave").disabled=true;
					document.getElementById("btnconfirm").disabled=true;
			 }else{
				 	document.getElementById("btncalculate").disabled=false;
					document.getElementById("btnleasesave").disabled=false;
					document.getElementById("btnconfirm").disabled=false;
			 }    	 
		    		}
            	});
            
         $('#leaseReqGrid').on('celldoubleclick', function (event) 
            { 
        	 if(document.getElementById("mode").value=="A"){
 				return false;
 			}
        	 var rowindex1=event.args.rowindex;
				var rows=$('#leaseReqGrid').jqxGrid('getrows');
				for(var i=0;i<rows.length;i++){
					$('#leaseReqGrid').jqxGrid('setcellvalue',i,'rowcolor','0');
				}
				
				document.getElementById("driver").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'driver');
				document.getElementById("securitypass").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'security_pass');
				document.getElementById("fuel").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'fuel');
				document.getElementById("salik").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'salik');
				document.getElementById("safetyaccess").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'safetyaccessories');	
				document.getElementById("leasemonths").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasemonths');
				document.getElementById("kmpermonth").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'kmpermonth');
				document.getElementById("srno").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'srno');
				document.getElementById("grpid").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'grpid');
				document.getElementById("leasereqdoc").value=$('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'leasereqdocno');
				//	var docno=document.getElementById("docno").value;
				
			 if($('#leaseReqGrid').jqxGrid('getcellvalue',rowindex1,'confirmstatus')=="1"){
					document.getElementById("btncalculate").disabled=true;
					document.getElementById("btnleasesave").disabled=true;
					document.getElementById("btnconfirm").disabled=true;
			 }else{
				 	document.getElementById("btncalculate").disabled=false;
					document.getElementById("btnleasesave").disabled=false;
					document.getElementById("btnconfirm").disabled=false;
			 }	
        	 
            }); 
         	            
        });
    </script>
    <div id="leaseReqGrid"></div>
    
