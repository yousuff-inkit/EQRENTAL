<%@page import="com.dashboard.operations.vehiclecustodylist.*"%>
<%
ClsVehCustodyListDAO DAO=new ClsVehCustodyListDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtbranch=request.getParameter("agmtbranch")==null?"":request.getParameter("agmtbranch");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String custatus=request.getParameter("custatus")==null?"":request.getParameter("custatus");

%>

<script type="text/javascript">
 
var id='<%=temp%>';
var custodydata;
if(id=='1'){
	custodydata='<%=DAO.getCustodyData(fromdate,todate,agmttype,agmtno,agmtbranch,custatus,temp)%>';
} 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'agmtno',type:'number'},
                  		{name : 'agmttype',type:'string'},
                  		{name : 'fleetno',type:'string'},
                  		{name : 'fleetreg',type:'string'},
                  		{name : 'fleetname',type:'string'},
                  		
                  		{name : 'odate',type:'string'},
                  		{name : 'otime',type:'string'},
                  		{name : 'okm',type:'number'},
                  		{name : 'ofuel',type:'string'},
                  		
                  		{name : 'indate',type:'string'},
                  		{name : 'intime',type:'string'},
                  		{name : 'inkm',type:'number'},
                  		{name : 'infuel',type:'string'},
                  		
                  		{name :'cldate',type:'string'},
                  		{name :'cltime',type:'string'},
                  		{name :'clkm',type:'number'},
                  		{name :'clfuel',type:'string'},
                  		{name :'coldriver',type:'string'},
                  		
                  		{name : 'deldate',type:'string'},
                  		{name : 'deltime',type:'string'},
                  		{name : 'delkm',type:'number'},
                  		{name : 'delfuel',type:'string'},            		
                  		{name : 'deldriver',type:'string'},
                  		
                  		{name : 'rtype',type:'string'},
                  		{name : 'st_desc',type:'string'},
                  		{name : 'agmtbranch',type:'string'},
                  		{name : 'mainbrch',type:'string'},

						{name : 'delconkm',type:'number'},
                  		{name : 'colconkm',type:'number'},
                  		
                  		{name : 'descin',type:'string'},
                  		{name : 'descout',type:'string'},
                  		],
				    localdata: custodydata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#custodyGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#custodyGrid").jqxGrid(
    {
        width: '98%',
        height: 535,
        columnsheight:23,
        source: dataAdapter,
        showfilterrow:true,
        columnsresize: true, 
        enabletooltips:true,
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
       				{ text:'Custody Branch',datafield:'mainbrch',width:'12%'},
       				{ text:'Custody No',datafield:'doc_no',width:'6%'},
       				{ text:'Agmt Branch',datafield:'agmtbranch',width:'7%'},
       				{ text:'Agmt No',datafield:'agmtno',width:'7%'},
       				{ text:'Agmt Type',datafield:'rtype',width:'6%'},
       				
       				{ text :'Fleet No',datafield:'fleetno',width:'8%'},
       				{ text :'Reg No',datafield:'fleetreg',width:'8%'},
       				{ text :'Fleet Name',datafield:'fleetname',width:'8%',hidden:true},
       				
       				{ text :'Description In',datafield:'descin',width:'20%'},
       				{ text :'Description Out',datafield:'descout',width:'20%'},
       				
       				{ text :'Driver',datafield:'coldriver',width:'8%',columngroup:'coldetails'},
       				{ text :'Date',datafield:'cldate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'coldetails'},
       				{ text :'Time',datafield:'cltime',width:'8%',cellsformat:'HH:mm',columngroup:'coldetails'},
       				{ text: 'Km',datafield:'clkm',width:'8%',columngroup:'coldetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'clfuel',width:'8%',columngroup:'coldetails'},
       				
       				
       				{ text :'Date',datafield:'indate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'indetails'},
       				{ text :'Time',datafield:'intime',width:'8%',cellsformat:'HH:mm',columngroup:'indetails'},
       				{ text: 'Km',datafield:'inkm',width:'8%',columngroup:'indetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'infuel',width:'8%',columngroup:'indetails'},
       				
       				{ text :'Date',datafield:'odate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'outdetails'},
       				{ text :'Time',datafield:'otime',width:'8%',cellsformat:'HH:mm',columngroup:'outdetails'},
       				{ text :'Km',datafield:'okm',width:'8%',columngroup:'outdetails',cellsalign: 'right', align:'right'},
       				{ text :'Fuel',datafield:'ofuel',width:'8%',columngroup:'outdetails'},
       				
       				{ text :'Driver',datafield:'deldriver',width:'8%',columngroup:'deldetails'},
       				{ text :'Date',datafield:'deldate',width:'8%',cellsformat:'dd.MM.yyyy',columngroup:'deldetails'},
       				{ text :'Time',datafield:'deltime',width:'8%',cellsformat:'HH:mm',columngroup:'deldetails'},
       				{ text: 'Km',datafield:'delkm',width:'8%',columngroup:'deldetails',cellsalign: 'right', align:'right'},
       				{ text: 'Fuel',datafield:'delfuel',width:'8%',columngroup:'deldetails'},
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */


					],columngroups: 
	                     [
	                       { text: 'Out Fleet Details', align: 'center', name: 'outdetails'},
	                       { text: 'In Fleet Details', align: 'center', name: 'indetails'},
	                       { text: 'Collection Details', align: 'center', name: 'coldetails'},
	                       { text: 'Delivery Details', align: 'center', name: 'deldetails'}
	                    
	                     ]

    });
    $('#custodyGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
      	/* document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="custodyGrid"></div>