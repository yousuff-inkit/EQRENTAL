<%@page import="com.dashboard.analysis.vehicledetailanalysis.*" %>
<%ClsVehicleDetailAnalysisDAO floordao=new ClsVehicleDetailAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var floordata=[];
if(id=="1"){
	<%-- floordata='<%=floordao.getGIPMgmtData(id,brhid)%>'; --%>
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'branchname' , type: 'string'},
                      	{name : 'customertype',type:'string'},
 						{name : 'docno', type: 'number'},
 						{name : 'vocno', type: 'number'},
 						{name : 'date', type:'date'},
 						{name : 'time',type:'string'},
 						{name : 'refname',type:'string'},
                      	{name : 'mobile', type: 'string'  },
                      	{name : 'email',type:'string'},
                      	{name : 'repairtype',type:'string'},
                      	{name : 'processstatus',type:'string'},
                      	{name : 'estdocno',type:'string'},
                      	{name : 'cldocno',type:'number'},
                      	{name : 'insurcldocno',type:'number'},
                      	{name : 'gipprocess',type:'string'}
                      	
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var cellclassname = function (row, column, value, data) {
        	/*if(data.z1.includes("P")){
            	return "redClass";
            }*/
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Client Type',datafield: 'customertype', width: '6%',cellclassname: cellclassname},
    					{ text: 'Branch',datafield: 'branchname', width: '7%',cellclassname: cellclassname},
    					{ text: 'Doc No',datafield: 'docno', width: '5%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Doc No',datafield: 'vocno', width: '5%',cellclassname: cellclassname},
    					{ text: 'Process',datafield: 'gipprocess', width: '8%',cellclassname: cellclassname},
    					{ text: 'Date',datafield: 'date', width: '6%',cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Time', datafield: 'time', width: '4%',cellclassname: cellclassname,cellsformat:'HH:mm'},
    					{ text: 'Client',datafield: 'refname' ,cellclassname: cellclassname},
    					{ text: 'Telephone', datafield: 'mobile', width: '13%',cellclassname: cellclassname},
    					{ text: 'Email', datafield: 'email', width: '13%',cellclassname: cellclassname},
    					{ text: 'Repair Type', datafield: 'repairtype', width: '10%',cellclassname: cellclassname},
    					{ text: 'Process Status', datafield: 'processstatus', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Est Doc No', datafield: 'estdocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Client Doc No', datafield: 'cldocno', width: '10%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Insur Client Doc No', datafield: 'insurcldocno', width: '10%',cellclassname: cellclassname,hidden:true}								
						
    	              ]
                });

				$('#floorMgmtGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = args.rowindex;
				    // row's visible index.
				    var visibleIndex = args.visibleindex;
				    // right click.
				    var rightclick = args.rightclick; 
				    // original event.
				    var ev = args.originalEvent;
				    
				 	$('#rowindex').val(boundIndex);
				 	var docno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'docno');
				 	$('#docno').val(docno);
				 	var vocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'vocno');
				 	var refname=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'refname');
				 	var cldocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'cldocno');
				 	var insurcldocno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'insurcldocno');
				 	if(parseInt(cldocno)>0){
				 		$('#cmbbilltoclient').val(cldocno).trigger('change');
				 	}
				 	if(parseInt(insurcldocno)>0){
				 		$('#cmbbilltoinsur').val(insurcldocno).trigger('change');
				 	}
				 	$('.textpanel p').text(vocno+' - '+refname);
				});
	});
</script>
<div id="floorMgmtGrid"></div>