   <%@page import="com.dashboard.vehicle.*"%>
     <%ClsvehicleDAO secdao= new ClsvehicleDAO(); %>
 <% String contextPath=request.getContextPath();%>
 
 <%
    String branch = request.getParameter("branch")==null?"":request.getParameter("branch").trim();
	String fleetno = request.getParameter("fleetno")==null?"":request.getParameter("fleetno").trim();
  	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
 %> 
           	  
 <style type="text/css">
  
    .yellowClass
    {
        background-color: #F8E489;  
    }
    
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  .greenClass
    {
        background-color: #7AFA90;
    }
     .whiteClass
    {
        background-color: #FFFFFF;
    }
</style>
<script type="text/javascript">


var secdata;
var id='<%=id%>';
if(id=="1")
{ 
	 secdata='<%=secdao.getSecurityPassData(branch,fleetno,id)%>'; 
} 
else{	
	secdata=[];
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                        {name : 'doc_no', type: 'number'  },
                        {name : 'date', type: 'date'  },
						{name : 'authority', type: 'string'  },
						{name : 'hidauthority', type: 'string'  },
						{name : 'type', type: 'String'  },
						{name : 'vehicle', type: 'String'  },
						{name : 'hidvehicle', type: 'String'  },
						{name : 'driver',type:'string'},
						{name : 'hiddriver',type:'string'},
						{name : 'passno',type:'string'},
						{name : 'issuedate',type:'date'},
						{name : 'expirydate',type:'date'},
						{name : 'notes',type:'string'},
						{name : 'description',type:'string'},
						{name : 'brhid',type:'string'}
						],
				    localdata: secdata,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  	$("#securityPassMgmtGrid").on("bindingcomplete", function (event) {
  	// your code here.
  	$('#overlay,#PleaseWait').hide();
  	});
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#securityPassMgmtGrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
    //selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columnsresize:true,
        columns: [   
                  	{ text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '3%', 
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                  	},	
                     { text: 'Doc No', datafield: 'doc_no',  width: '5%'}, 
                     { text: 'Date', datafield: 'date',  width: '8%',cellsformat:'dd.MM.yyyy' }, 
           	         { text: 'Authority', datafield: 'authority',  width: '8%' },
           	         { text: 'Type', datafield: 'type',  width: '8%' },
           	         { text: 'Authority Doc No', datafield: 'hidauthority',  width: '25%',hidden:true }, 
           	         { text: 'Vehicle', datafield: 'vehicle',  width: '15%' },
           	         { text: 'Fleet No', datafield: 'hidvehicle',  width: '25%',hidden:true },
           	         /*{ text: 'Driver', datafield: 'driver',  width: '15%' },
           	         { text: 'Driver Doc No', datafield: 'hiddriver',  width: '25%',hidden:true },*/
           	         { text: 'Branch Doc No', datafield: 'brhid',  width: '25%',hidden:true },
           	         { text: 'Pass No', datafield: 'passno',  width: '10%' },
           	         { text: 'Description', datafield: 'description',  width: '12%' },
					 { text: 'Issue Date', datafield: 'issuedate', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Expiry Date', datafield: 'expirydate', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Notes',datafield: 'notes'}
					]

   
    });
   $('#securityPassMgmtGrid').on('celldoubleclick', function (event) 
   { 
	   var rowindex=event.args.rowindex;
	   document.getElementById("docno").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"doc_no");
	   document.getElementById("authority").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"authority");
	   document.getElementById("hidauthority").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"hidauthority");
	   if($('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"type")=="Vehicle"){
	   		document.getElementById("cmbtype").value="VEH";
	   }
	   else if($('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"type")=="Driver"){
	   		document.getElementById("cmbtype").value="DRV";
	   }
	   document.getElementById("vehicle").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"vehicle");
	   document.getElementById("hidvehicle").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"hidvehicle");
	   document.getElementById("driver").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"driver");
	   document.getElementById("hiddriver").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"hiddriver");
	   document.getElementById("passno").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"passno");
	   document.getElementById("description").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"description");
	   document.getElementById("notes").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"notes");
	   document.getElementById("cmbbranch").value=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"brhid");
	   $('#issuedate').jqxDateTimeInput('val',$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"issuedate"));
	   $('#expirydate').jqxDateTimeInput('val',$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex,"expirydate"));
	
   });	 
    
 <%--   $('#securityPassMgmtGrid').on('cellclick', function (event) 
		   { 
	   var brch="1";
	   var rowindex1=event.args.rowindex;
	   var datafield=event.args.datafield;
	   if(datafield=="attach"){
		var doc_no=$('#securityPassMgmtGrid').jqxGrid('getcellvalue',rowindex1,"doc_no");
		   var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode=BDCR&docno="+doc_no+"&brchid="+brch+"&frmname="+document.getElementById("detailname").value,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					  myWindow.focus();
	   }
	   
		   });	 --%> 
});


</script>
<div id="securityPassMgmtGrid"></div>