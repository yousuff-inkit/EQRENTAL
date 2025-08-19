<%@page import="com.dashboard.equipment.equipbreakdown.*"%>
<%
ClsEquipBreakdownDAO dao=new ClsEquipBreakdownDAO();
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
		contractdata='<%=dao.getContractData(branch, fromdate, todate, temp)%>';  
   	}

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'voc_no',type:'number'},
                  		{name : 'cldocno',type:'number'},
                  		{name : 'hiremode',type:'string'},
                  		{name : 'refname',type:'string'},
                  		{name : 'currentfleetno',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'calcdocno',type:'string'},
                  		{name : 'eqdocno',type:'string'},
                  		{name : 'eqclstatus',type:'string'},
                  		{name : 'strstatus',type:'string'},
                  		{name : 'startdate',type:'date'},
                  		{name : 'starttime',type:'string'}
                  		],
				    localdata: contractdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#contractGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#contractGrid").jqxGrid(
    {
        width: '99%',
        height: 535,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%',hidden:true},
       				{ text: 'Contract No',datafield:'voc_no',width:'8%'},
       				{ text: 'Date',datafield:'date',width:'8%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet',datafield:'currentfleetno',width:'7%'},
					{ text: 'Fleet Name',datafield:'flname',width:'32%'},
       				{ text: 'Client Doc No',datafield:'cldocno',width:'5%',hidden:true},
       				{ text: 'Client Name',datafield:'refname',width:'25%'},
       				{ text: 'Hiremode',datafield:'hiremode',width:'8%'},
       				{ text: 'Calc Doc No',datafield:'calcdocno',width:'8%',hidden:true},
       				{ text: 'Eq Doc No',datafield:'eqdocno',width:'8%',hidden:true},
       				{ text: 'Eq close status',datafield:'eqclstatus',width:'8%',hidden:true},
       				{ text: 'startdate',datafield:'startdate',width:'8%',hidden:true,cellsformat:'dd.MM.yyyy'},
       				{ text: 'starttime',datafield:'starttime',width:'8%',hidden:true},
       				{ text: 'Status',datafield:'strstatus',width:'8%'},
       				/*{ text: 'Date',datafield:'outdate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'outdetails'},
       				{ text: 'Time',datafield:'outtime',width:'5%',cellsformat:'HH:mm',columngroup:'outdetails'},
       				{ text: 'Km',datafield:'outkm',width:'6%',columngroup:'outdetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'outfuel',width:'6%',columngroup:'outdetails'},*/
       				
					]

    });
    $('#contractGrid').on('rowdoubleclick', function (event) 
      		{ 
  	  var rowindex1=event.args.rowindex;
  	  var status=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "strstatus");
  	  if(status=="Started"){
  	  	$('#startdate').jqxDateTimeInput('val',$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "startdate"));
  	  	$('#starttime').jqxDateTimeInput('val',$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "starttime"));
  	  	$('#startdate,#starttime').jqxDateTimeInput({'disabled':true});
  	  	$('#enddate,#endtime').jqxDateTimeInput({'disabled':false});
  	  	$('#amount').attr('disabled',false);
  	  }
  	  else if(status=="Ended"){
  	  	$('#startdate,#starttime,#enddate,#endtime').jqxDateTimeInput({'disabled':true});
  	  	$('#amount').attr('disabled',true);
  	  }
  	  else{
  	  	$('#enddate,#endtime').jqxDateTimeInput({'disabled':true});
  	  	$('#startdate,#starttime').jqxDateTimeInput({'disabled':false});
  	  	$('#amount').attr('disabled',true);
  	  	$('#startdate,#starttime,#enddate,#endtime').jqxDateTimeInput('setDate',null);
  	  }
  	  $('#rowindex').val(rowindex1);
      	/* document.getElementById("hidagmtno").value=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="contractGrid"></div>
<input type="hidden" id="rowindex">