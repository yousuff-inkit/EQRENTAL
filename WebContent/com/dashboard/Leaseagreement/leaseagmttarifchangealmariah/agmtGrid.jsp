<%@page import="com.dashboard.leaseagreement.leaseagmttarifchangealmariah.*" %>
<%
	ClsLeaseAgmtTarifChangeAlMariahDAO tarifchangedao=new ClsLeaseAgmtTarifChangeAlMariahDAO(); 
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
	String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String datetype=request.getParameter("datetype")==null?"":request.getParameter("datetype");
%>
<script type="text/javascript">
var id='<%=id%>';
var agmtdata;
if(id=="1"){
	agmtdata='<%=tarifchangedao.getAgmtData(branch,fromdate,todate,cldocno,agmtno,datetype,id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'brhid', type: 'number'},
						{name : 'branchname',type:'string'},
						{name : 'doc_no', type: 'number'},
						{name : 'voc_no',type:'string'},
						{name : 'date', type: 'date'},
						{name : 'cldocno',type:'number'},
						{name : 'refname',type:'number'},
						{name : 'perfleet', type: 'String'},
						{name : 'flname',type:'string'},
						{name : 'outdate', type: 'date'},
						{name : 'reg_no',type:'number'}
						

						],
				    localdata: agmtdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#agmtGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#agmtGrid").jqxGrid(
    {
        width: '98%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [  
                  	 { text: 'Branch ID', datafield: 'brhid', width: '12%',hidden:true},
				     { text: 'Branch', datafield:'branchname', width: '10%'}, 
				     { text: 'Doc No',datafield: 'doc_no', width: '12%',hidden:true},
				     { text: 'Voc No',datafield: 'voc_no', width: '10%'},
				     { text: 'Date',datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Client ID', datafield: 'cldocno', width: '15%',hidden:true },
					 { text: 'Client',datafield: 'refname',width:'28%'},
					 { text: 'Fleet', datafield: 'perfleet', width: '8%'},
					 { text: 'Reg No', datafield:'reg_no',width:'8%'},
					 { text: 'Fleet Name', datafield: 'flname',width: '20%'},
					 { text: 'Agmt Date', datafield: 'outdate', width: '8%',cellsformat:'dd.MM.yyyy'}
					
					]
   
    });

    $('#agmtGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("agmtdocno").value=$('#agmtGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
    	$('#tarifchangediv').load('tarifChangeGrid.jsp?agmtdocno='+document.getElementById("agmtdocno").value+'&id=1');
    }); 
});
</script>
<div id="agmtGrid"></div>