<%@page import="com.dashboard.operations.gateinpasscreate.ClsGateinpassCreateDAO"%> 
<%ClsGateinpassCreateDAO DAO=new ClsGateinpassCreateDAO();%>
<% 
   String branch =request.getParameter("branch")==null?"0":request.getParameter("branch").toString().trim();
   String todate = request.getParameter("to")==null?"0":request.getParameter("to").toString().trim(); 
   int check =request.getParameter("check")==null?0:Integer.parseInt(request.getParameter("check").toString());
   String clientid =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
   String fromdate =request.getParameter("from")==null?"0":request.getParameter("from").toString();
%>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.greenClass {
	background-color: #DAF7A6;
}

.violetClass {
	background-color: #D59FFD;
}
</style>  
<script type="text/javascript">
var data1;

        $(document).ready(function () { 
        	data1= '<%= DAO.detailgrid(session,fromdate,todate,branch,clientid,check) %>';
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'tr_no', type: 'String'  },
							{name : 'regno', type: 'String'  },
							{name : 'fleetno', type: 'String'  },
							{name : 'cldocno', type: 'String'  },
							{name : 'cregno', type: 'String'  },
							{name : 'date', type: 'date' },
							{name : 'user', type: 'String'  },
							{name : 'vehicle', type: 'string'   },
							{name : 'place', type: 'string'   },
							{name : 'entrydatetime', type: 'date'   },
							
     						{name : 'status', type: 'String' },
     						{name : 'statusid', type: 'String' },
     						
     						{name : 'assigngrp', type: 'String' },
     						{name : 'grpid', type: 'String' },
     						
     						{name : 'assignmembr', type: 'String' },
     						{name : 'grpempid', type: 'String' },
     						
     						{name : 'type', type: 'String' },
     						{name : 'typeid', type: 'String' },
     						{name : 'remarks', type: 'String' },
     						{name : 'repeated', type: 'String' },
     						{name : 'client', type: 'String' },
     						{name : 'callby', type: 'String' },
     						{name : 'mob', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						{name : 'agmtexist',type:'number'},
     						{name : 'srvckm',type:'number'},
     						{name : 'lastsrvckm',type:'number'},
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
          var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxgipGrid").jqxGrid(
            {
                width: '99.5%',
                height: 550,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
		        showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
                    
					{ text: 'trno',width: '8%', datafield: 'tr_no', hidden : true},
					{ text: 'cldocno',width: '8%', datafield: 'cldocno', hidden : true},
					{ text: 'regno',width: '8%', datafield: 'regno', hidden : true},
					{ text: 'fleetno',width: '8%', datafield: 'fleetno', hidden : true},
                    { text: 'CREG NO',width: '5%', datafield: 'cregno'},
                    { text: 'DATE',width: '7%', datafield: 'date', cellsformat:'dd.MM.yyyy'},
                    { text: 'VEHICLE', datafield: 'vehicle',width: '15%' },
                    { text: 'CLIENT' ,width: '13%', datafield: 'client'},
                    { text: 'TYPE',width: '7%', datafield: 'type'},
                    { text: 'CALL BY',width: '9%', datafield: 'callby'},
                    { text: 'MOBILE NO',width: '9%', datafield: 'mob'},
                    { text: 'REPEATED',width: '6%', datafield: 'repeated'},
                    { text: 'REMARKS',width: '10%', datafield: 'remarks'},
                    { text: 'PLACE',width: '10%', datafield: 'place'},
                    { text: 'ENTRY DATETIME',width: '9%', datafield: 'entrydatetime', cellsformat:'dd.MM.yyyy HH:mm'},
                    
                    { text: 'USER',width: '17%', datafield: 'user', hidden : true},
                    { text: 'STATUS',width: '10%', datafield: 'status', hidden : true},
                    { text: 'statusid',width: '10%', datafield: 'statusid', hidden : true },
                    { text: 'ASSIGN GROUP',width: '14%', datafield: 'assigngrp', hidden : true},
                    { text: 'grpid',width: '10%', datafield: 'grpid', hidden : true },
                    { text: 'ASSIGN MEMBER',width: '15%', datafield: 'assignmembr', hidden : true},
                    { text: 'grpempid',width: '10%', datafield: 'grpempid', hidden : true },
                    { text : 'Agmt Exist', datafield:'agmtexist', hidden : true},
                    
                    { text: 'TYPEID',width: '8%', datafield: 'typeid', hidden : true},
                    { text: 'brhId',width: '8%', datafield: 'brhid', hidden : true},
                    { text: 'Srvc Km',datafield:'srvckm',hidden:true},
					{ text : 'Last Srvc km', datafield:'lastsrvckm',hidden:true},
                    
                        
                  ]
            });
            $('#jqxgipGrid').on('rowdoubleclick', function (event) 
            		{ 
            	
            		    var rowindex = event.args.rowindex;
            		     
            		     $("#hidregno").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "regno"));
            		     $("#hidcldocno").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
            		     $("#hidclient").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "client"));
            		     $("#hidtrno").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "tr_no"));
            		     $("#hidbrhid").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "brhid"));
            		     $("#hidfleetno").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "fleetno"));
            		     $("#hidvehicle").val($('#jqxgipGrid').jqxGrid('getcellvalue', rowindex, "vehicle"));
            		     $('#hidagmtexist').val($('#jqxgipGrid').jqxGrid('getcellvalue',rowindex,'agmtexist'));
            		     $('#hidsrvckm').val($('#jqxgipGrid').jqxGrid('getcellvalue',rowindex,'srvckm'));
         				$('#hidlastsrvckm').val($('#jqxgipGrid').jqxGrid('getcellvalue',rowindex,'lastsrvckm'));
//             		     $("#assignDiv input").attr('disabled', false);
//             		     $("#assignDiv button").attr('disabled', false);
            		});  
            
        });
        
    </script>
<div id="jqxgipGrid"></div>
