<%@ page import="com.dashboard.operations.nonpoolagmtlist.*"  %>
<%
	String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
  	String status = request.getParameter("status")==null?"":request.getParameter("status").trim();
  	String fleet = request.getParameter("fleet")==null?"":request.getParameter("fleet").trim();
  	String group = request.getParameter("group")==null?"":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"":request.getParameter("model").trim();
  	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
  	String chkoverdue = request.getParameter("chkoverdue")==null?"":request.getParameter("chkoverdue").trim();
 	ClsNonPoolAgmtListDAO cad=new ClsNonPoolAgmtListDAO();
  	
 %> 
<style type="text/css">
.redClass
{
	background-color: #FFEBEB;
}
</style>
<script type="text/javascript">
 
var id='<%=id%>';
var agmtlistdata=[];
var agmtlistdataexcel=[];
if(id=="1")
{ 
	agmtlistdata='<%=cad.getNonPoolAgmtListData(branch,fromdate,todate,cldocno,status,fleet,group,brand,model,id,chkoverdue)%>';
	agmtlistdataexcel='<%=cad.getNonPoolAgmtListDataExcel(branch,fromdate,todate,cldocno,status,fleet,group,brand,model,id,chkoverdue)%>';
}
else{
	agmtlistdata=[];
	agmtlistdataexcel=[];
}
         
$(document).ready(function () { 
            var source = 
            {
                datatype: "json",
                datafields: [

                 			{name : 'doc_no', type: 'number'  },   //this is the agreement
                 			{name : 'voc_no', type: 'number'},
     						{name : 'date', type: 'date'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'flname', type: 'String'}, 
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'string'  },
     						{name : 'reg_no', type: 'number'  },
     						{name : 'authority', type: 'string'  },
     						{name : 'platecode', type: 'String'  },
     						{name : 'branch', type: 'String'  },
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						{name : 'dout', type: 'date'  },
     						{name : 'tout', type: 'string'  },
     						{name : 'date_due', type: 'date'  },
     						{name : 'time_due', type: 'String'  },
     						{name : 'din', type: 'date'  },
     						{name : 'tin', type: 'string'  },
     						{name : 'overduestatus', type: 'number'},
							{name : 'rate',type:'number'}
                          	],
                          	localdata: agmtlistdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            var cellclassname = function (row, column, value, data) {
               if (data.overduestatus == '1') {
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
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 540,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			                   { text: 'SL#', sortable: false, filterable: false, editable: false,   
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'Doc No', datafield: 'voc_no', width: '6%' ,cellclassname: cellclassname },   //voc no
							{ text: 'Doc No', datafield: 'doc_no', width: '6%' ,cellclassname: cellclassname,hidden:true },
							{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							{ text: 'Branch', datafield: 'branch', width: '10%',cellclassname: cellclassname },
							{ text: 'Fleet', datafield: 'fleet_no', width: '6%',cellclassname: cellclassname },
							{ text: 'Fleet Name', datafield: 'flname', width: '13%',cellclassname: cellclassname },
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%',cellclassname: cellclassname },
							{ text: 'Authority', datafield: 'authority', width: '8%',cellclassname: cellclassname },
							{ text: 'Plate Code', datafield: 'platecode', width: '8%',cellclassname: cellclassname },
							{ text: 'Client #', datafield: 'cldocno', width: '6%',cellclassname: cellclassname },
							{ text: 'Client Name', datafield: 'refname', width: '18%',cellclassname: cellclassname },
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%',cellclassname: cellclassname},
							{ text: 'Mob NO', datafield: 'per_mob', width: '10%',cellclassname: cellclassname},
							{ text: 'Rate', datafield: 'rate', width: '10%',cellclassname: cellclassname,cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Out Date', datafield: 'dout', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							{ text: 'Out Time', datafield: 'tout', width: '5%' ,cellclassname: cellclassname}, 
							{ text: 'Due Date', datafield: 'date_due', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							{ text: 'Due Time', datafield: 'time_due', width: '5%',cellclassname: cellclassname },
							{ text: 'In Date', datafield: 'din', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},								
							{ text: 'In Time', datafield: 'tin', width: '5%',cellclassname: cellclassname },
							{ text: 'Overdue Status', datafield: 'overduestatus', width: '5%',cellclassname: cellclassname,hidden:true },
							
							
					
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>