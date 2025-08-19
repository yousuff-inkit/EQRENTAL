<%@page import="com.dashboard.operations.drivertimesheet.*"%>
<%
	ClsDriverTimeSheetDAO DAO= new ClsDriverTimeSheetDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String clientname = request.getParameter("clientName")==null?"0":request.getParameter("clientName");
 String agmtno = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 
 %>
<script type="text/javascript">
	   
       var data1= '<%=DAO.agreementDetailsSearch(clientname, agmtno, regno, fleetno, date)%>';  
       
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'refname', type: 'string'   },
     						{name : 'voc_no', type: 'int'   },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'reg_no', type: 'string'  },
     						{name : 'fleet_no', type: 'string'  },
     						{name : 'date', type: 'date'},
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agreementDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Agmt No', datafield: 'voc_no', width: '15%' },
							{ text: 'Date', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Client', datafield: 'refname', width: '40%' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '15%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' }
						]
            });
            
             $('#agreementDetailsSearch').on('rowdoubleclick', function (event) {
                 var rowindex2 = event.args.rowindex;
                 
                 if($('#txtorgridclick').val()=='1') {
                	 document.getElementById("txtagreementid").value = $('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
  	            	 document.getElementById("txtagreement").value = $('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "voc_no");
                 } else if($('#txtorgridclick').val()=='2') {
                	 var rowindex1 =$('#rowindex').val();
                	 $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindex1, "agmtdoc_no" ,$('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                     $('#timeSheetDetailsGridID').jqxGrid('setcellvalue', rowindex1, "agmtvoc_no" ,$('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "voc_no"));
                 } else if($('#txtorgridclick').val()=='3') {
	                 document.getElementById("txtselectedagreementid").value = $('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
	            	 document.getElementById("txtselectedagreement").value = $('#agreementDetailsSearch').jqxGrid('getcellvalue', rowindex2, "voc_no");
            	} 
                 
            	$('#agreementDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="agreementDetailsSearch"></div>
 