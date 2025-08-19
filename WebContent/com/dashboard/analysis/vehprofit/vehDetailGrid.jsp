<%@page import="com.dashboard.analysis.vehprofit.ClsVehProfitDAO" %>
<% ClsVehProfitDAO cvd=new ClsVehProfitDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
String gridtype=request.getParameter("gridtype")==null?"":request.getParameter("gridtype");
String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
%>

<script type="text/javascript">
 
$(document).ready(function() {
   var id='<%=temp%>';
var vehdetaildata;
   if(id=='1'){
	   vehdetaildata='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>'; 
	   <%-- detailExcelExport='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>'; --%>
   }
else{
	
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'fleetno',type:'number'},
                  		{name : 'reg_no',type:'string'},
                  		{name : 'flname',type:'String'},
                  		{name : 'income',type:'number'},
                  		{name : 'expenses',type:'number'},
                  		{name : 'netamount',type:'number'},
                  		{name : 'brand',type:'string'},
                  		{name : 'model',type:'string'},
                  		{name : 'gname',type:'string'},
                  		{name : 'yom',type:'string'},
                  		{name : 'raincome',type:'number'},
                  		{name : 'labcost',type:'number'},
                  		{name : 'partscost',type:'number'},
                  		{name : 'netincome',type:'number'},
                  		{name : 'depcost',type:'number'},
                  		{name : 'netexp',type:'number'},
                  		{name : 'ltincome',type:'number'},
                  		{name : 'otherexp',type:'number'},
                  		{name : 'purchase_cost',type:'number'},
                  		{name : 'agmtdetails',type:'string'},
                  		/* {name : 'salesman',type:'string'},
                  		{name : 'rentalagent',type:'string'},
                  		{name : 'yom',type:'string'}
                  		 */
                  		],
				    localdata: vehdetaildata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vehDetailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + '' + value + '</div>';
    } 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#vehDetailGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        //localization: {thousandsSeparator: ""},
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Fleet No',datafield:'fleetno',width:'6%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'6%'},
       				{ text:'Fleet Name',datafield:'flname',width:'15%'},
       				{ text: 'Group',datafield:'gname',width:'5%'},
       				{ text: 'Brand',datafield:'brand',width:'10%'},
       				{ text: 'Model',datafield:'model',width:'10%'},
       				{ text: 'RA/LA No',datafield:'agmtdetails',width:'10%'},
       				{ text: 'Purchase Cost',datafield:'purchase_cost',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right'},
       				{ text: 'RA Income',datafield:'raincome',columngroup: 'Income',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Other Income',datafield:'ltincome',columngroup: 'Income',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Net Income',datafield:'netincome',columngroup: 'Income',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Labour Cost',datafield:'labcost',columngroup: 'Expenses',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Parts Cost',datafield:'partscost',columngroup: 'Expenses',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Other Exp',datafield:'otherexp',columngroup: 'Expenses',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Dep. Cost',datafield:'depcost',columngroup: 'Expenses',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Net Expenses',datafield:'netexp',columngroup: 'Expenses',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Contribution',datafield:'netamount',width:'8%',cellsalign:'right',cellsformat:'d2',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				//{ text: 'YOM',datafield:'yom',width:'5%'},
       				//{ text: 'A/c No',datafield:'acno',width:'8%',hidden:true},
       				//{ text: 'Account',datafield:'description',width:'15%',hidden:true}
					],
					columngroups: 
					    [
					        { text: 'Income', align: 'center', name: 'Income' },
					        { text: 'Expenses', align: 'center', name: 'Expenses' },
					    ]

    });
    
  
   
});

	
	
</script>
<div id="vehDetailGrid"></div>