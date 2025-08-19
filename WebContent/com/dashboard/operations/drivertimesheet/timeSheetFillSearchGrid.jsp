<%@page import="com.dashboard.operations.drivertimesheet.ClsDriverTimeSheetDAO"%>
<%ClsDriverTimeSheetDAO DAO= new ClsDriverTimeSheetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString(); 
 String fillfromdate = request.getParameter("fillfromdate")==null?"0":request.getParameter("fillfromdate");
 String filltodate = request.getParameter("filltodate")==null?"0":request.getParameter("filltodate");
 String daysselected = request.getParameter("daysselected")==null?"0":request.getParameter("daysselected");
 String selectedagreement = request.getParameter("selectedagreement")==null?"0":request.getParameter("selectedagreement");
 String selectedagreementid = request.getParameter("selectedagreementid")==null?"0":request.getParameter("selectedagreementid");
 String selecteddrdocno = request.getParameter("selecteddrdocno")==null?"0":request.getParameter("selecteddrdocno");
 String fillintime = request.getParameter("fillintime")==null?"0":request.getParameter("fillintime");
 String fillouttime = request.getParameter("fillouttime")==null?"0":request.getParameter("fillouttime");
 String fillnormalhrs = request.getParameter("fillnormalhrs")==null?"0":request.getParameter("fillnormalhrs");
 String fillothrs = request.getParameter("fillothrs")==null?"0":request.getParameter("fillothrs");
 %>
 
<script type="text/javascript">
   
        $(document).ready(function () { 
        	
          var fillgriddata;
          var gridload='<%=gridload%>';
        	
          if(gridload=="1"){
        	  fillgriddata = '<%=DAO.timeSheetFillGridLoading(session,fillfromdate,filltodate,daysselected,selectedagreement,selectedagreementid,selecteddrdocno,fillintime,fillouttime,fillnormalhrs,fillothrs,gridload) %>'; 
          }
        	 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'date', type: 'date'  },
                          	{name : 'days', type: 'String'  },
							{name : 'drid', type: 'String'  },
							{name : 'drname', type: 'String'  },
							{name : 'agmtvoc_no', type: 'string' },
							{name : 'agmtdoc_no', type: 'string' },
							{name : 'intime', type: 'date'  }, 
							{name : 'outtime', type: 'date'  },
						    {name : 'hrs', type: 'date'  },
						    {name : 'othrs', type: 'date'  }, 
                          	],
                 			localdata: fillgriddata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#timeSheetFillSearchGridId").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                editable: false,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Days',datafield:'days',width:'6%' },
							{ text: 'Dr. ID', datafield: 'drid', width: '8%',hidden: true },
							{ text: 'Driver', datafield: 'drname' },
							{ text: 'Agreement', datafield: 'agmtvoc_no', width: '9%' },
							{ text: 'Agreementno', datafield: 'agmtdoc_no', width: '9%',hidden: true },
							{ text: 'In Time', datafield: 'intime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Out Time', datafield: 'outtime', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							},
							{ text: 'Normal Hours', datafield: 'hrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}, 
							{ text: 'OT Hours', datafield: 'othrs', cellsformat: 'H:mm',  width: '7%', cellsalign: 'left',columntype: 'datetimeinput',
								createeditor: function(row,cellvalue,editor,celltext,cellwidth,cellheight) {
								    editor.jqxDateTimeInput({showCalendarButton : false});
								} 
							}
						]
            
            });
            $("#overlay, #PleaseWait").hide();
           
        });
</script>
<div id="timeSheetFillSearchGridId"></div>