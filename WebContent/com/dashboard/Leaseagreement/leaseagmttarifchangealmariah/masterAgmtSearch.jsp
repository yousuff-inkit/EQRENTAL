<%@page import="com.dashboard.leaseagreement.leaseagmttarifchange.*" %>
<% ClsLeaseAgmtTarifChangeDAO tarifchangedao=new ClsLeaseAgmtTarifChangeDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var agmtsearchdata;
if(id=="1"){
	agmtsearchdata='<%=tarifchangedao.getAgmtSearchData(id)%>'; 
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'doc_no',type:'number'},
						{name : 'voc_no', type: 'number'},
						{name : 'date', type: 'date'},
						{name : 'perfleet',type:'number'},
						{name : 'outdate',type:'date'},
						{name : 'reg_no',type:'number'},
						{name : 'flname',type:'string'}

						],
				    localdata: agmtsearchdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#agmtSearchGrid").on("bindingcomplete", function (event) {
    	$("#loadingImage2").css("display", "none");
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#agmtSearchGrid").jqxGrid(
    {
        width: '99%',
        height: 315,
        source: dataAdapter,
        showaggregates:true,
        showfilterrow:true,
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
                  	 
				     { text: 'Doc no',datafield: 'doc_no', width: '20%',hidden:true},
				     { text: 'Doc No',datafield: 'voc_no', width: '10%'},
				     { text: 'Doc Date',datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Out Date',datafield: 'outdate', width: '10%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Fleet No',datafield: 'perfleet', width: '10%'},
				     { text: 'Reg No',datafield: 'reg_no', width: '10%'},
				     { text: 'Fleet Name',datafield: 'flname', width: '50%'}
					]
   
    });

    $('#agmtSearchGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("agmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue',rowindex,'voc_no');
    	document.getElementById("hidagmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
    	$('#agmtwindow').jqxWindow('close');
    }); 
});
    
</script>
<div id="agmtSearchGrid"></div>
