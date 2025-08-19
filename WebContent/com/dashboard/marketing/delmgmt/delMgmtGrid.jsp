<%@page import="com.dashboard.marketing.delmgmt.*" %>
<%ClsDelMgmtDAO dao=new ClsDelMgmtDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
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
	floordata='<%=dao.getDelMgmtData(id, brhid, fromdate, todate)%>';
}
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	if(value=="undefined" || typeof(value)=="undefined"){
		value="0.00";
	}
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
            	        {name : 'account' , type: 'number'},
            	        {name : 'cldocno' , type: 'number'},
                      	{name : 'doc_no' , type: 'string'},
 						{name : 'voc_no', type: 'number'},
						{name : 'date', type: 'date'},
 						{name : 'reftype', type:'string'},
 						{name : 'refno',type:'string'},
 						{name : 'hirefromdate',type:'date'},
                      	{name : 'delcharges', type: 'number'  },
                      	{name : 'description',type:'string'},
                      	{name : 'clientname',type:'string'},
                      	{name : 'branchname',type:'string'},
                      	{name : 'fleet_no',type:'number'},
                      	{name : 'flname',type:'string'},
                      	{name : 'assetid',type:'string'},
                     	{name : 'salesman',type:'string'},
                      	{name : 'calcdocno',type:'number'},
                      	{name : 'delmode',type:'number'},
                      	{name : 'delstatus',type:'number'},
                      	{name : 'delfleetno',type:'number'},
                     	{name : 'doneby',type:'number'},
                     	{name : 'doctype',type:'string'},
                      	{name : 'deldocno',type:'number'},
                      	{name : 'brhid',type:'number'},
             ],
             localdata: floordata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var cellclassname = function (row, column, value, data) {
        	if(data.doctype=="DEL"){
            	return "greenClass";
            }
            else if(data.doctype=="PIK"){
            	return "redClass";
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );

        $("#floorMgmtGrid").on("bindingcomplete", function (event) {
        	$("#overlay, #PleaseWait").hide();
        }); 

        $("#floorMgmtGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'checkbox',
                  	editable:false,
                    altrows:true,
                    sortable:true,
                    columnsresize: true,
                    showaggregates:true,
                	showstatusbar:true,
                	enabletooltips:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
    					{ text: 'Doc No',datafield: 'voc_no', width: '4%',cellclassname: cellclassname},
    					{ text: 'Doc No',datafield: 'doc_no', width: '8%',hidden:true,cellclassname: cellclassname},
    					{ text: 'Cldoc No',datafield: 'cldocno', width: '4%',cellclassname: cellclassname},
    					{ text: 'Ac No',datafield: 'account', width: '4%',cellclassname: cellclassname},
    					{ text: 'Status',datafield: 'delstatus', width: '7%',cellclassname: cellclassname},
    					{ text: 'Date',datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy',hidden:true,cellclassname: cellclassname},
    					{ text: 'Ref Type',datafield: 'reftype', width: '5%',cellclassname: cellclassname},
    					{ text: 'Ref No',datafield: 'refno', width: '4%',cellclassname: cellclassname},
    					{ text: 'Calc Doc No',datafield: 'calcdocno', width: '8%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Del Mode',datafield: 'delmode', width: '8%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Done By',datafield: 'doneby', width: '8%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Del Fleet No',datafield: 'delfleetno', width: '8%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Equip No',datafield: 'fleet_no', width: '5%',cellclassname: cellclassname},
    					{ text: 'Equip Name',datafield: 'flname', width: '12%',cellclassname: cellclassname},
    					{ text: 'Asset Id',datafield: 'assetid', width: '5%',cellclassname: cellclassname},
    					{ text: 'Doc Type',datafield: 'doctype', width: '12%',cellclassname: cellclassname,hidden:true},
    					
    					{ text: 'Branch',datafield: 'branchname', width: '7%',cellclassname: cellclassname},
    					{ text: 'Hire From Date',datafield: 'hirefromdate', width: '5%' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy'},
    					{ text: 'Client',datafield: 'clientname', width: '16%' ,cellclassname: cellclassname},
    					{ text: 'Salesman',datafield: 'salesman', width: '10%' ,cellclassname: cellclassname},
    					{ text: 'Description', datafield: 'description', width: '15%',cellclassname: cellclassname},
    					{ text: 'deldocno',datafield: 'deldocno', width: '12%',hidden:true},
    					{ text: 'brhid',datafield: 'brhid', width: '12%',hidden:true},
    					
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
				    $('#jobcarddocno,#jobcardvocno,#cmbdoneby,#fleetno,#driver,#inkm,#cmbinfuel,#inremarks,#outkm,#cmboutfuel,#outremarks').val('');
				    $('#cmbdoneby,#cmboutfuel,#cmbinfuel').val('').trigger('change');
				    $('#fleetno').attr('data-fleetno','');
				    $('#driver').attr('data-drvdocno','');
				    $('#indate,#intime,#outdate,#outtime').jqxDateTimeInput('setDate',new Date());
				    $('#delstartdate,#delstarttime').jqxDateTimeInput('setDate',null);
				    $('#delstartkm').val('');
				    $('#jobcarddocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
				    $('#jobcardvocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'voc_no'));
				    $('#deldocno').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'deldocno'));
				    $('#jobcardbrid').val($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
				    
					//var rowsno=$('#floorMgmtGrid').jqxGrid('getcellvalue', boundIndex, 'rowno');
				    getComments();
				    /*getBays($('#jobcarddocno').val());
				    $('#baymovgriddiv').load('bayMovGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				     $('#partsdetailsgriddiv').load("partsDetailsGrid.jsp?id="+1+"&rowno="+rowsno+"&jobcarddocno="+$('#jobcarddocno').val());
				   	$('#jobworkersgriddiv').load('jobWorkersGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
					$('#selectedteamsgriddiv').load('selectedTeamsGrid.jsp?id=1&jobcarddocno='+$('#jobcarddocno').val());
				   	*/
				   	$('.textpanel p').text('Contract #'+$('#jobcardvocno').val()+' with Equip No: '+$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'fleet_no'));					
					$('.contract-details').text('Contract #'+$('#jobcardvocno').val()+' with Equip No: '+$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'fleet_no'));
				   	$('#rowindex').val(boundIndex);
					if($('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'delmode')=="1" && $('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'doneby')=="1"){
						var delfleetno=$('#floorMgmtGrid').jqxGrid('getcellvalue',boundIndex,'delfleetno');
				    	$.get('getDelStartDetails.jsp',{'delfleetno':delfleetno,'docno':$('#jobcarddocno').val()},function(data){
				    		console.log(data);
				    		data=JSON.parse(data.trim());
				    		$('#delstartkm').val(data.delstartkm);
				    		$('#delstartdate').jqxDateTimeInput('setDate',data.delstartdate);
				    		$('#delstarttime').jqxDateTimeInput('setDate',data.delstarttime);
				    	});	
				    }
					getAssetGroup("1");
				});
	});
	
	function removeCableChip(elm){
		$.post('deleteCableIssue.jsp',{'docno':$('#jobcarddocno').val(),'grpdocno':$(elm).closest('.chip').attr('data-docno')},function(data,status){
			data=JSON.parse(data);
			if(data.errorstatus=="0"){
				$(elm).closest('.chip').remove();
				getAssetGroup("");
			}
			else{
				$(elm).closest('.chip').addClass('bg-error');
			}
		});
	}
	
	function getAssetGroup(mode){
		$.get('getAssetGrp.jsp',{'docno':$('#jobcarddocno').val()},function(data){
			data=JSON.parse(data);
			var htmldata='';
			htmldata='<option value="">--Select--</option>';
	  		$.each(data.assetgrpdata,function(index,value){
	  			htmldata+='<option value="'+value.docno+'" data-balqty="'+value.balqty+'">'+value.refname+'</option>';
	  		});
	  		$('#cmbassetgroup').html($.parseHTML(htmldata));
	  		$('#cmbassetgroup').select2();
	  		if(mode=="1"){
	  			$('.chips').empty();
		  		$.each(data.cabledata,function(index,value){
		  			
		  			var chiphtml='';
		  			chiphtml+='<div class="chip" data-docno="'+value.grpdocno+'">';
					chiphtml+=value.refname;
					chiphtml+=': <span class="chip-qty">'+value.qty+'</span>';
					chiphtml+='<span class="closebtn" onclick="removeCableChip(this);">&times;</span>';
					chiphtml+='</div>';
					
					$('.chips').append($.parseHTML(chiphtml));
		  		});
	  		}
		});
	}
</script>
<div id="floorMgmtGrid"></div>
<input type="hidden" id="rowindex" name="rowindex">
