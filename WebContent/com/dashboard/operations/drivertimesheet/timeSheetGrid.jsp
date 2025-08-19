<%@page import="com.dashboard.operations.drivertimesheet.ClsDriverTimeSheetDAO"%>
<% ClsDriverTimeSheetDAO DAO= new ClsDriverTimeSheetDAO(); %>
<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String driverid = request.getParameter("driverid")==null?"":request.getParameter("driverid").trim();
String agmtno = request.getParameter("agmtno")==null?"":request.getParameter("agmtno").trim();
String year = request.getParameter("year")==null?"":request.getParameter("year").trim();
String month = request.getParameter("month")==null?"":request.getParameter("month").trim();
String date = request.getParameter("date")==null?"":request.getParameter("date").trim();
String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
%>

<script type="text/javascript">
        var data;
        var temp1='<%=branchval%>';
        var id='<%=id%>';
        if(id==1){ 
        	
        	data='<%=DAO.getTimeSheetData(driverid,agmtno,year,month,date,id)%>'
        }
        
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'date', type: 'date'  },
					{name : 'drid', type: 'String'  },
					{name : 'drname', type: 'String'  },
					{name : 'agmtdoc_no', type: 'string'    },
					{name : 'agmtvoc_no', type: 'string'    },
					{name : 'intime', type: 'date'  }, 
					{name : 'outtime', type: 'date'  }, 
				    {name : 'hrs', type: 'date'  }, 
				    {name : 'othrs', type: 'date'  }
	            ],
                localdata: data,
        	
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#timeSheetDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                editable: true,
                selectionmode: 'singlecell',
                
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#timeSheetDetailsGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'drname') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {   
                        	$('#rowindex').val(cell1.rowindex);$('#txtorgridclick').val('2');
                        	driverSearchContent("driverDetailsSearch.jsp");
                        }
                    } 
                    
                    var cell2 = $('#timeSheetDetailsGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'agmtvoc_no') {
                	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {  
                    	 $('#rowindex').val(cell2.rowindex);
                    	 $('#txtorgridclick').val('2');
                    	 agreementNoSearchContent("agreementDetailsSearch.jsp");
                    	 $('#timeSheetDetailsGridID').jqxGrid('render');
                      }
                	}
                    
                    
                },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',columntype: 'datetimeinput', width: '7%', editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								},
								cellbeginedit: function (row) {
									if($('#cmbyear').val()=='' || $('#cmbmonth').val()=='')
							         {
										  $.messager.alert('Message','Year and Month are Mandatory.','warning');
							              return false;
							         }}	
							},
							{ text: 'Driver. ID', datafield: 'drid', width: '8%', editable: false,hidden: true},
							{ text: 'Driver', datafield: 'drname', editable: false },
							{ text: 'Agreement', datafield: 'agmtvoc_no', width: '9%', editable: false },
							{ text: 'agreementdocno', datafield: 'agmtdoc_no', width: '8%',hidden: true },
							{ text: 'In Time', datafield: 'intime', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Out Time', datafield: 'outtime', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: true,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Total Hours', datafield: 'hrs', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',editable: false,
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'OT Hours', datafield: 'othrs', cellsformat: 'HH:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
						
					 		]
            });
            $("#overlay, #PleaseWait").hide();
            
            if(temp1=='NA'){
                $("#timeSheetDetailsGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
            $("#timeSheetDetailsGridID").on('cellvaluechanged', function (event) {
            	 var datafield = event.args.datafield;
          	     var rowindexestemp = event.args.rowindex;
          	     $('#rowindex').val(rowindexestemp);
          	   
				 if(datafield=="date"){
	         	    	var date = $('#timeSheetDetailsGridID').jqxGrid('getcelltext', rowindexestemp, "date");
	         	    	var day = date.split(".");
	         	    	
	         	    	if($('#cmbmonth').val()!=day[1]) {
							 $.messager.alert('Message','Month should be '+$('#cmbmonth option:selected').text(),'warning');
				             return 0;
				        }
            
	         	    	if($('#cmbyear').val()!=day[2]) {
		   					 $.messager.alert('Message','Year should be '+$('#cmbyear').val(),'warning');
		   		             return 0;
	   			        }
	         	 }
					
	          	 
	          	 
	          	if(datafield=="hrs"){
	          		if($('#txtfillbtnclick').val()!='1'){
			          	var rows = $('#timeSheetDetailsGridID').jqxGrid('getrows');
		            	var rowlength= rows.length;
		            	var rowindex1 = rowlength - 1;
		          	    var hours=$("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindex1, "hrs");
		          	    if(typeof(hours) != "undefined" && typeof(hours) != "NaN" && hours != ""){
		          	    	$("#timeSheetDetailsGridID").jqxGrid('addrow', null, {"date": ""+$('#date').val()+"","drid": ""+$('#txtdriverid').val()+"","drname": ""+$('#txtdrivername').val()+"","agmtvoc_no": ""+$('#txtagreement').val()+"","agmtdoc_no": ""+$('#txtagreementid').val()+"","hrs": ""});
		          	    }
	          		}
	          	}
	          	
	          	if(datafield=="intime" || datafield=="outtime"){
	          		
	          		var intime=$("#timeSheetDetailsGridID").jqxGrid('getcelltext', rowindexestemp, "intime");
	          		var outtime=$("#timeSheetDetailsGridID").jqxGrid('getcelltext', rowindexestemp, "outtime");
	          		
	          		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != ""){
	             
	                var startDate = new Date($("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindexestemp, "intime"));
	                var endDate   = new Date($("#timeSheetDetailsGridID").jqxGrid('getcellvalue', rowindexestemp, "outtime"));
	                
	                if(Date.parse(endDate) < Date.parse(startDate)){
	                	endDate = new Date(endDate.setDate(endDate.getDate() + 1));
	                }
	                
	                var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
	                var newhours = parseFloat(hours1/60).toFixed(0);
	                var newhours1 = ('0' + newhours).slice(-2);
	                var newminutes = parseFloat(hours1%60);
	                var newminutes1 = ('0' + newminutes).slice(-2);
	                var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
	                 
	                $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,normalHours);
	                	
	          	    }
	          	}
	          	
            });
            
            $('#timeSheetDetailsGridID').on('celldoubleclick', function (event) {
         	     
           	    if(event.args.columnindex == 3)
           	    {
           			var rowindextemp = event.args.rowindex;
           			document.getElementById("rowindex").value = rowindextemp;
           			$('#txtorgridclick').val('2');
           			driverSearchContent("driverDetailsSearch.jsp");
                } 
                
           	
  	         	if(event.args.columnindex == 4)
  	            {
  		           var rowindextemp = event.args.rowindex;
  		           document.getElementById("rowindex").value = rowindextemp;
  		           $('#txtorgridclick').val('2');
  		           $('#timeSheetDetailsGridID').jqxGrid('clearselection');
  		         agreementNoSearchContent("agreementDetailSearch.jsp");
  	            }
  	    		  
  	           
  	           if(event.args.columnindex == 0)
        		  {
        			var rowindexestemp = event.args.rowindex;
        			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "date" ,'');
        			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "drid" ,'');	
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "drname" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "agmtvoc_no" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "agmtdoc_no" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "intime" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "outtime" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "hrs" ,'');
	       			$('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "othrs" ,'');
                  } 
               });
            
            
            /*Delete Row*/
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#timeSheetDetailsGridID").on('contextmenu', function () {
                   return false;
               });
               
            $("#Menu2").on('itemclick', function (event) {
                var rowindex = $("#timeSheetDetailsGridID").jqxGrid('getselectedrowindex');
                    
                var rowid = $("#timeSheetDetailsGridID").jqxGrid('getrowid', rowindex);
                $("#timeSheetDetailsGridID").jqxGrid('deleterow', rowid);
            });
            
            $("#timeSheetDetailsGridID").on('cellclick', function (event) {
                if (event.args.rightclick) {
                    $("#timeSheetDetailsGridID").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);

                    return false;
                }
            });
            /*Delete Row Ends*/
  });
                       
</script>

<div id='jqxWidget'>
   <div id="timeSheetDetailsGridID"></div>
    <div id="popupWindow2">
 
 <div id='Menu2'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>       
</div>
</div>
<input type="hidden" id="rowindex"/> 