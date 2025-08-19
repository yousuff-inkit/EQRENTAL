<%@page import="com.limousine.jobassignmentmultiplebus.*" %>
<%ClsJobAssignMultipleBusDAO limodao=new ClsJobAssignMultipleBusDAO();
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"0":request.getParameter("modelid");
String groupid=request.getParameter("groupid")==null?"0":request.getParameter("groupid");
String gridname=request.getParameter("gridname")==null?"":request.getParameter("gridname");
String tarifmode=request.getParameter("tarifmode")==null?"":request.getParameter("tarifmode");
String pickuplocid=request.getParameter("pickuplocid")==null?"":request.getParameter("pickuplocid");
String dropofflocid=request.getParameter("dropofflocid")==null?"":request.getParameter("dropofflocid");
String blockhrs=request.getParameter("blockhrs")==null?"":request.getParameter("blockhrs");
String cldocno=request.getParameter("client")==null?"":request.getParameter("client");
String transfertype=request.getParameter("transfertype")==null?"":request.getParameter("transfertype");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript">
var id='<%=id%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var tarifdata=[];
if(id=="1"){
	tarifdata='<%=limodao.getTarifData(tarifmode,brandid,modelid,pickuplocid,dropofflocid,blockhrs,cldocno,transfertype,id,groupid)%>';
}
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'doc_no', type: 'string'},
     						{name : 'validto', type: 'date'},
     						{name : 'tariftype',type:'string'},
     						{name : 'tarifclient',type:'string'},
     						{name : 'estdistance',type:'number'},
     						{name : 'esttime',type:'date'},
     						{name : 'tarif',type:'number'},
     						{name : 'exdistancerate',type:'number'},
     						{name : 'extimerate',type:'number'},
     						{name : 'gid',type:'string'},
     						{name : 'blockhrs',type:'number'},
     						{name : 'exhrrate',type:'number'},
     						{name : 'nighttarif',type:'number'},
     						{name : 'nightexhrrate',type:'number'},
     						{name : 'tarifdetaildocno',type:'number'}
     						
     											
                 ],               
               localdata:tarifdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage").css("display", "none"); 
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#tarifSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
                
                handlekeyboardnavigation: function (event) {
                  
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'doc_no',width:'20%'},	
							{ text: 'Valid To', datafield: 'validto', width: '20%',cellsformat:'dd.MM.yyyy' },
							{text: 'Tarif Type',datafield:'tariftype',width:'40%'},
							{text: 'Tarif Client',datafield:'tarifclient',width:'20%'},
							{text: 'Est.Distance',datafield:'estdistance',width:'20%',hidden:true},
							{text: 'Est.Time',datafield:'esttime',width:'20%',hidden:true,cellsformat:'HH:mm'},
							{text: 'Tarif',datafield:'tarif',width:'20%',hidden:true},
							{text: 'exdistancerate',datafield:'exdistancerate',width:'20%',hidden:true},
							{text: 'extimerate',datafield:'extimerate',width:'20%',hidden:true},
							{text: 'gid',datafield:'gid',width:'20%',hidden:true},
							{text: 'Block Hrs',datafield:'blockhrs',width:'20%',hidden:true},
							{text: 'Ex.Hr rate',datafield:'exhrrate',width:'20%',hidden:true},
							{text: 'Night Tarif',datafield:'nighttarif',width:'20%',hidden:true},
							{text: 'Night ex.hr rate',datafield:'nightexhrrate',width:'20%',hidden:true},
							{text: 'Tarif Detail Docno',datafield:'tarifdetaildocno',width:'20%',hidden:true}
	              		]
            });
       	$('#tarifSearch').on('rowdoubleclick', function (event) {
       		var rowindex=event.args.rowindex;
       		$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "tarifdocno", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "doc_no"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "estdistance", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "estdistance"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "esttime", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "esttime"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "tarif", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "tarif"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "exdistancerate", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "exdistancerate"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "extimerate", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "extimerate"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "gid", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "gid"));
           	$("#"+gridname).jqxGrid('setcellvalue', gridrowindex, "tarifdetaildocno", $('#tarifSearch').jqxGrid('getcellvalue', rowindex, "tarifdetaildocno"));
       		$('#tarifwindow').jqxWindow('close');
       	});
            
        });
    </script>
    <div id="tarifSearch"></div>
 
