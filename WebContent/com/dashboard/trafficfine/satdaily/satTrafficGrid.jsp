<%@page import="com.dashboard.trafficfine.satdaily.ClsSatDailyReport" %>
<%ClsSatDailyReport DAO=new ClsSatDailyReport(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
<% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
<% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>
<% String datefilter =request.getParameter("datefilter")==null?"0":request.getParameter("datefilter").toString();%>
<% String check =request.getParameter("check")==null?"0":request.getParameter("check").toString();%>

 <script type="text/javascript">
 		var data;
 		var trafficdailyexceldata;
 
 		data= '<%= DAO.satDailyReportGridLoading(fromdate,todate,satcateg,datefilter,check) %>';
		trafficdailyexceldata= '<%= DAO.satDailyReportExcelExport(fromdate,todate,satcateg,datefilter,check) %>' ; 
    
        $(document).ready(function () { 	
            
            var source =
            {
            		
                datatype: "json",
                datafields: [
							{name : 'tcno', type: 'String'  },
     						{name : 'ticket_no', type: 'String'  },
     						{name : 'traffic_date', type: 'String' },
     						{name : 'time', type: 'String' },
     						{name : 'fine_source', type: 'String' },
     						{name : 'amount', type: 'String' },
     						{name : 'regno', type: 'String' },
     						{name : 'pcolor', type: 'String' },
     						{name : 'licence_no', type: 'String' },
     						{name : 'licence_from', type: 'String' },
     						{name : 'tick_location', type: 'String' },
     						{name : 'tick_violat', type: 'String' },
     						{name : 'date', type: 'String' },
     						{name : 'desc1', type: 'String' }
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
		            }		
            );
            $("#jqxloadtrafficdataGrid").jqxGrid(
            {
                width: '100%',
                height: 480,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,

                columns: [
					{ text: '#TcNo',columntype: 'textbox' , datafield: 'tcno', width: '10%' },
					{ text: ' Downloaded Date',columntype: 'textbox',  datafield: 'date', width: '10%' },
					{ text: 'Fine No',columntype: 'textbox' , datafield: 'ticket_no', width: '10%' },
					{ text: 'Traffic Date',columntype: 'textbox' , datafield: 'traffic_date', width: '10%' },
					{ text: 'Time',columntype: 'textbox' , datafield: 'time', width: '10%' },
					{ text: 'Fine Source',columntype: 'textbox' , datafield: 'fine_source', width: '10%' },
					{ text: 'Fees',columntype: 'textbox' , datafield: 'amount', width: '10%' },
					{ text: 'Plate No',columntype: 'textbox' , datafield: 'regno', width: '10%' },
					{ text: 'Plate Category',columntype: 'textbox' , datafield: 'pcolor', width: '10%' },
					/* { text: 'Plate Code',columntype: 'textbox' , datafield: 'pcolor', width: '10%' }, */
					/* { text: 'Licence No',columntype: 'textbox' , datafield: 'licence_no', width: '10%' },
					{ text: 'Licence From',columntype: 'textbox' , datafield: 'licence_from', width: '10%' }, */
					/* { text: 'Ticket Violation Desc',columntype: 'textbox' , datafield: 'TICK_VIOLAT', width: '10%' }, */
					//{ text: 'Ticket Location',columntype: 'textbox' , datafield: 'tick_location', width: '10%' }
					{ text: 'Description',columntype: 'textbox' , datafield: 'desc1', width: '30%' }
					
	              ]
            });

            $("#overlay, #PleaseWait").hide();
 });

</script>
<div id="jqxloadtrafficdataGrid"></div>
