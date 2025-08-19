 <%@page import="com.dashboard.audit.datalog.ClsDataLogDAO"%>
<%ClsDataLogDAO logdao=new ClsDataLogDAO();%>
 
 <%
 	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
 	String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim();
    String hidform=request.getParameter("hidform")==null?"":request.getParameter("hidform").trim();
  
 	String hiduser=request.getParameter("hiduser")==null?"":request.getParameter("hiduser").trim();
 	String value=request.getParameter("value")==null?"":request.getParameter("value").trim();
 	%> 
           	  
 <style>
 
 .addClass
        {
            background-color: #DAF7A6;
        }
 .editClass
	{
    background-color: #FFFFD1;
	}
 .deleteClass
	{
   background-color: #FFEBEB;
	}
 </style>
<script type="text/javascript">
 var temp4='<%=branch%>';
var data;
var exceldata;

if(temp4!='')
{ 
	 data='<%=logdao.getLogData(branch, fromdate, todate, id, hiduser, hidform,value)%>';
	exceldata='<%=logdao.getLogExcelData(branch, fromdate, todate, id, hiduser, hidform,value)%>'; 
}
else
{
	data;
	} 
	
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		
						{name : 'transno', type: 'string'  },
						{name : 'transtype', type: 'string'  },
						{name : 'formname', type: 'string'  },
						{name : 'branchname', type: 'string'  },
						{name : 'user', type: 'string'  },
						{name : 'action', type: 'string'  },
						{name : 'date', type: 'date'  }
						
						
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#datalogGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        

    
	var cellclassname = function (row, column, value, data) {
		if (data.action=='Add') {
            return "addClass";
        } else if (data.action=='Edit') {
            return "editClass";
        }
        else if (data.action=='Delete') {
            return "deleteClass";
        }
        else{
        
        };
    };
    
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
       
    $("#datalogGrid").jqxGrid(
    {
        width: '98%',
        height: 557,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        pagermode: 'default',
	showfilterrow: true,
	selectionmode: 'singlerow', 
	enabletooltips: true,
       
        columns: [
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    						groupable: false, draggable: false, resizable: false,datafield: '',
    						columntype: 'number', width: '5%',cellclassname:cellclassname,cellsalign: 'center', align: 'center',
    						cellsrenderer: function (row, column, value) {
     							return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
  								}    
					},
					{ text: 'Form Code', datafield: 'transtype', width: '10%',cellclassname:cellclassname  },
					{ text: 'Form Name',datafield: 'formname',width:'19%',cellclassname:cellclassname},
					{ text: 'Branch Name', datafield: 'branchname', width: '19%',cellclassname:cellclassname},
					{ text: 'Doc No', datafield: 'transno', width: '10%',cellclassname:cellclassname},
					{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy HH:mm',cellclassname:cellclassname},
					{ text: 'User', datafield: 'user', width: '20%',cellclassname:cellclassname},
					{ text: 'Action', datafield: 'action', width: '7%',cellclassname:cellclassname}
					/* { text: 'Staff Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'}, */
											
						]
    
    });
    
    


    
});

	
	
</script>
<div id="datalogGrid"></div>