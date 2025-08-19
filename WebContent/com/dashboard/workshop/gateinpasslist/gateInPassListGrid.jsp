<%@page import="com.dashboard.workshop.gateinpasslist.*"%>
<%
ClsGateInPassListDAO gatedao=new ClsGateInPassListDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;
var gateexceldata;

if(id=='1'){
 gatedata='<%=gatedao.getGateInPassData(fromdate,todate,id)%>';
 <%-- gateexceldata='<%=gatedao.getGateInPassExcelData(fromdate,todate,id)%>'; --%>
}
else{
gatedata=[];
gateexceldata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'brhid',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'branchname',type:'string'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'indate',type:'date'},
                  		{name : 'intime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		{name : 'infuel',type:'string'},
                  		{name : 'driver',type:'string'},
                  		{name : 'serviceduekm',type:'number'}
				
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#gateInPassListGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#gateInPassListGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Branch',datafield:'branchname',width:'12%'},
       				{ text: 'Branch Id',datafield:'brhid',width:'12%',hidden:true},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'7%'},
       				{ text: 'Asset id',datafield:'reg_no',width:'6%'},
       				{ text: 'Fleet Name',datafield:'flname',width:'12%'},
       				{ text: 'Driver',datafield:'driver',width:'12%'},
       				{ text: 'In Date',datafield:'indate',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'In Time',datafield:'intime',width:'6%',cellsformat:'HH:mm'},
       				{ text: 'In Km',datafield:'inkm',width:'7%',cellsalign: 'right', align:'right'},
       				{ text: 'In Fuel',datafield:'infuel',width:'6%'},
       				{ text: 'Service Due Km',datafield:'serviceduekm',width:'8%',cellsalign: 'right', align:'right'}


					]
    });
    $('#gateInPassListGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
  	  $('#gatedocno').val($('#gateInPassListGrid').jqxGrid('getcellvalue',rowindex1,'doc_no'));
  	 $('#brhid').val($('#gateInPassListGrid').jqxGrid('getcellvalue',rowindex1,'brhid'));

      		});	 
     
  
    });

	
	
</script>
<div id="gateInPassListGrid"></div>