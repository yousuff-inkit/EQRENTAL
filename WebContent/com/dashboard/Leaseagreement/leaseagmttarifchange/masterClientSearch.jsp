<%@page import="com.dashboard.leaseagreement.leaseagmttarifchange.*" %>
<% ClsLeaseAgmtTarifChangeDAO tarifchangedao=new ClsLeaseAgmtTarifChangeDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var clientdata;
if(id=="1"){
	clientdata='<%=tarifchangedao.getClientData(id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
           
						{name : 'cldocno', type: 'number'},
						{name : 'per_mob',type:'string'},
						{name : 'mail1', type: 'number'},
						{name : 'refname',type:'string'},
						{name : 'address', type: 'string'}

						],
				    localdata: clientdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#clientGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	$("#loadingImage1").css("display", "none");
   });
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );

    $("#clientGrid").jqxGrid(
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
                  	 { text: 'Client Id', datafield: 'cldocno', width: '8%'},
				     { text: 'Client Name', datafield:'refname', width: '20%'}, 
				     { text: 'Mobile',datafield: 'per_mob', width: '15%'},
				     { text: 'Mail',datafield: 'mail1', width: '15%'},
				     { text: 'Address',datafield: 'address', width: '42%'}
					]
   
    });

    $('#clientGrid').on('rowdoubleclick', function (event){
    	var rowindex=event.args.rowindex;
    	document.getElementById("hidclient").value=$('#clientGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
    	document.getElementById("client").value=$('#clientGrid').jqxGrid('getcellvalue',rowindex,'refname');
    	$('#clientwindow').jqxWindow('close');
    }); 
});
    
</script>
<div id="clientGrid"></div>
