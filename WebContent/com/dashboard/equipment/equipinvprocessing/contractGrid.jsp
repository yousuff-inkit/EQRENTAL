<%@page import="com.dashboard.equipment.equipinvprocessing.*"%>
<%
ClsEquipInvProcessingDAO dao=new ClsEquipInvProcessingDAO();
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String periodupto=request.getParameter("periodupto")==null?"":request.getParameter("periodupto");
%>

<script type="text/javascript">
 
$(document).ready(function () {
	var id='<%=temp%>';
	var contractdata=[];
	
	if(id=='1'){
		contractdata='<%=dao.getContractData(branch, periodupto, temp)%>';  
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
                  		{name : 'desc1',type:'string'},
                  		{name : 'assetid',type:'string'},
                  		{name : 'sal',type:'string'},
                  		{name : 'currentfleetno',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'equipcount',type:'number'},
                  		{name : 'delcharges',type:'number'},
                  		{name : 'collectcharges',type:'number'},
                  		{name : 'srvcharges',type:'number'},
                  		{name : 'srvdesc',type:'string'},
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
        height: 300,
        columnsheight:23,
        columnsresize:true,
        source: dataAdapter,
     //   filtermode:'excel',
    //    filterable: true,
       sortable:false,
       filterable: true,
       showfilterrow: true,
       selectionmode: 'singlerow',
       enabletooltips: true,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: '',
             		columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             		cellsrenderer: function (row, column, value) {
              				return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           				}    
       				},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%',hidden:true},
       				{ text: 'Contract No',datafield:'voc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'6%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Fleet',datafield:'currentfleetno',width:'7%',hidden:true},
					{ text: 'Fleet Name',datafield:'flname',width:'20%',hidden:true},
       				{ text: 'Client Doc No',datafield:'cldocno',width:'5%',hidden:true},
       				{ text: 'AssetId',datafield:'assetid',width:'8%'},
       				{ text: 'Client Name',datafield:'refname',width:'20%'},
       				{ text: 'Hiremode',datafield:'hiremode',width:'8%'},
       				{ text: 'Description',datafield:'desc1'},
       				{ text: 'Salesman',datafield:'sal',width:'8%'},
       				{ text: 'Del.Charges',datafield:'delcharges',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'Collect.Charges',datafield:'collectcharges',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'Service Charges',datafield:'srvcharges',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
       				{ text: 'Equip.Count',datafield:'equipcount',width:'6%'},
       				{ text: 'srvdesc',datafield:'srvdesc',hidden:true },
       				
       				/*{ text: 'Date',datafield:'outdate',width:'6%',cellsformat:'dd.MM.yyyy',columngroup:'outdetails'},
       				{ text: 'Time',datafield:'outtime',width:'5%',cellsformat:'HH:mm',columngroup:'outdetails'},
       				{ text: 'Km',datafield:'outkm',width:'6%',columngroup:'outdetails',cellsalign:'right',align:'right'},
       				{ text: 'Fuel',datafield:'outfuel',width:'6%',columngroup:'outdetails'},*/
       				
					]

    });
	 $("#overlay, #PleaseWait").hide();

    $('#contractGrid').on('rowdoubleclick', function (event) 
    { 
  		var rowindex1=event.args.rowindex;
  		var brhid='<%=request.getParameter("brhid")==null?"":request.getParameter("brhid")%>';
		var periodupto='<%=request.getParameter("periodupto")==null?"":request.getParameter("periodupto")%>';
		var contractdocno=$('#contractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		 $("#overlay, #PleaseWait").show();

  	  	$('#equipdiv').load('equipGrid.jsp?brhid='+brhid+'&periodupto='+periodupto+'&contractdocno='+contractdocno+'&id=1');
  	  	$('#rowindex').val(rowindex1);
  	  	$('#docbrhid').val(brhid);
      	/* document.getElementById("hidagmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
         document.getElementById("agmtno").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
         document.getElementById("agmttype").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
         document.getElementById("hidofleet").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
         document.getElementById("hidfleetreg").value=$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg");	
         document.getElementById("agmtdetails").value="Agreement :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "reftype")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+"\n"+"Fleet     :"+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no")+"   "+$('#updateContractGrid').jqxGrid('getcellvalue', rowindex1, "fleetreg"); */
      		});	 
     
  
    });

	
	
</script>
<div id="contractGrid"></div>
<input type="hidden" name="rowindex" id="rowindex">