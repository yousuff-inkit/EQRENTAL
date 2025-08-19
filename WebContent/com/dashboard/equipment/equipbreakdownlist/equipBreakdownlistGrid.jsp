<%@page import="com.dashboard.equipment.equipbreakdownlist.*"%>
<%
ClsEquipBreakdownListDAO dao=new ClsEquipBreakdownListDAO();     
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var contractdata=[];
	
	if(id=='1'){
		contractdata='<%=dao.getEquipBreakdownData(branch, fromdate, todate, temp)%>';  
   	}

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                     
                   		{name : 'voc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'currentfleetno',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'hiremode',type:'string'},
                  		{name : 'strstatus',type:'string'},
                  		
                  		{name : 'startdate',type:'date'},
                  		{name : 'starttime',type:'time'},
                  		{name : 'startremarks',type:'string'},
                  		{name : 'enddate',type:'date'},
                  		{name : 'endtime',type:'time'},
                  		{name : 'endremarks',type:'string'},
                  		{name : 'amount',type:'number'}

                  		],
				    localdata: contractdata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#breakdownGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                	alert(error);    
                }
		            
	            }		
    );
    
    $("#breakdownGrid").jqxGrid(
    {
        width: '99%',
        height: 300,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        sortable:true,
        
        columns: [
               
       					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
                 		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                 		cellsrenderer: function (row, column, value) {
                  				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
               				}    
           				},
           				{ text: 'Contract No',datafield:'voc_no',width:'5%'},
           				{ text: 'Contract Date',datafield:'date',width:'5%',cellsformat:'dd.MM.yyyy'},
           				{ text: 'Fleet',datafield:'currentfleetno',width:'4%'},
    					{ text: 'Fleet Name',datafield:'flname'},
           				{ text: 'Client Name',datafield:'refname',width:'12%'},
           				{ text: 'Hiremode',datafield:'hiremode',width:'4%'},
           				{ text: 'Status',datafield:'strstatus',width:'4%'},
       				
       					{ text: 'Start Date',datafield:'startdate',width:'5%',cellsformat:'dd.MM.yyyy'},
       					{ text: 'Start Time',datafield:'starttime',width:'5%',cellsformat:'HH:mm'},
       					{ text: 'Start Remarks',datafield:'startremarks',width:'8%'},
       					{ text: 'End Date',datafield:'enddate',width:'5%',cellsformat:'dd.MM.yyyy'},
       					{ text: 'End Time',datafield:'endtime',width:'5%',cellsformat:'HH:mm'},
       					{ text: 'End Remarks',datafield:'endremarks',width:'8%'},
       					{ text: 'Amount',datafield:'amount',width:'6%',cellsformat:'d2',cellsalign:'right',align:'right'},
       					
					]

    });
    
});
	
</script>
<div id="breakdownGrid"></div>
<input type="hidden" name="rowindex" id="rowindex">