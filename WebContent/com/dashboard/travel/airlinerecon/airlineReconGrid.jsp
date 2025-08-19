<%@ page import="com.dashboard.travel.airlinerecon.*" %>  
<%
	ClsTravelAirlineReconDAO dao=new ClsTravelAirlineReconDAO();
   	String id = request.getParameter("id")==null?"0":request.getParameter("id");
   	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
   	String todate = request.getParameter("todate")==null?"":request.getParameter("todate");
 %>
 <script type="text/javascript">
 var data=[];
 var id='<%=id%>';
 if(id=="1"){
 	data='<%=dao.getAirlineReconData(id,fromdate,todate)%>';
 }
 $(document).ready(function () { 
 	var source = 
    {
    	datatype: "json", 
        datafields: [
        	{name : 'gwairline', type: 'string'},
			{name : 'gwticketno', type: 'String'  },
     		{name : 'gwissuedate', type: 'date'},
     		{name : 'gwamount', type: 'number'  },
     		{name : 'iataairline', type: 'string'},
			{name : 'iataticketno', type: 'String'  },
     		{name : 'iataissuedate', type: 'date'},
     		{name : 'iataamount', type: 'number'  }
		],
        localdata: data,  
        pager: function (pagenum, pagesize, oldpagenum) {
        }
	};
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
    	loadError: function (xhr, status, error) {
	    	alert(error);    
	    }
	});
    $("#airlineReconGrid").jqxGrid(
    { 
    	width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'singlecell',
        columns: [
        	{ text: 'SL#', sortable: false, filterable: false, editable: false,
				groupable: false, draggable: false, resizable: false,
				datafield: 'sl', columntype: 'number', width: '4%',
				cellsrenderer: function (row, column, value) {
					return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				}  
			},
            { text: 'Airline', datafield: 'gwairline', width: '20%',columngroup: 'gateway'},
            { text: 'Ticket No', datafield: 'gwticketno', width: '10%',columngroup: 'gateway'},
            { text: 'Issue Date', datafield: 'gwissuedate', width: '8%',cellsformat:'dd.MM.yyyy',columngroup: 'gateway'},
            { text: 'Amount', datafield: 'gwamount', width: '10%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'gateway'},
			{ text: 'Airline', datafield: 'iataairline', width: '20%',columngroup: 'iata'},
            { text: 'Ticket No', datafield: 'iataticketno', width: '10%',columngroup: 'iata'},
            { text: 'Issue Date', datafield: 'iataissuedate', width: '8%',cellsformat:'dd.MM.yyyy',columngroup: 'iata'},
            { text: 'Amount', datafield: 'iataamount', width: '10%',cellsformat:'d2',align:'right',cellsalign:'right',columngroup: 'iata'}
		],
		columngroups: 
    	[
        	{ text: 'Gateway', align: 'center', name: 'gateway' },
        	{ text: 'IATA',align: 'center', name: 'iata' },
    	]
	});
});
</script>
<div id="airlineReconGrid"></div>