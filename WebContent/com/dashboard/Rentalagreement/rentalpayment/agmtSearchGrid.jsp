<%@page import="com.dashboard.rentalagreement.preauthrental.ClsPreAuthRentalDAO"%>
<%ClsPreAuthRentalDAO preauthdao=new ClsPreAuthRentalDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
%>
<script type="text/javascript">
var id='<%=id%>';
var agmtdata;
if(id=="1"){
	agmtdata='<%=preauthdao.getAgmtData(id,docno,date,fleetno,regno,clientname,clientmobile)%>';
}
else{
	agmtdata=[];
}
$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'date', type: 'date'  },
                            {name : 'doc_no', type: 'number'  },
                            {name : 'voc_no', type: 'number'  },
                            {name : 'fleet_no',type:'number'},
                            {name : 'reg_no',type:'number'},
                            {name : 'refname',type:'string'},
                            {name : 'per_mob',type:'string'}    						
                        ],
                		
                 localdata: agmtdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         	$("#agmtSearchGrid").on("bindingcomplete", function (event) {
		    	$("#overlay, #PleaseWait").hide();
		    });
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agmtSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
                  
                columns: [
		                      { text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'Doc No', datafield: 'voc_no', width: '10%'},
                              { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
                              { text: 'Client Name', datafield: 'refname', width: '44%' },
                              { text: 'Mobile', datafield: 'per_mob', width: '15%' },
                              { text: 'Fleet No', datafield: 'fleet_no', width: '10%' },
                              { text: 'Reg No', datafield: 'reg_no', width: '10%' }
                           
						
						]
            });
            
          $('#agmtSearchGrid').on('rowdoubleclick', function (event) {
          	var rowindex = event.args.rowindex;
            document.getElementById("agmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex, "voc_no");
            document.getElementById("hidagmtno").value=$('#agmtSearchGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
            $('#agmtwindow').jqxWindow('close'); 
          }); 
        });
    </script>
    <div id="agmtSearchGrid"></div>