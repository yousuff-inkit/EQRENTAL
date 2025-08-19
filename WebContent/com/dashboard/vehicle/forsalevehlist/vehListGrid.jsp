<%@ page import="com.dashboard.vehicle.forsalevehlist.*" %>
<% ClsForSaleVehListDAO vehdao=new ClsForSaleVehListDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
%> 
<style type="text/css">
.advanceClass
{
	color: #FF0000;
}
.yellowClass
{
background-color: #A4A4A4; 
}
</style>
             	  
<script type="text/javascript">
var id='<%=id%>';
var data=[];
var exceldata=[];
if(id=="1")
{ 
	data='<%=vehdao.getVehListData(branch,id)%>'; 
	exceldata='<%=vehdao.getVehListDataExcel(branch,id)%>';
}
else
{
} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'branchname' , type: 'string' },
						{name : 'loc_name', type: 'string'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'brand_name', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  },
						{name : 'color', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'kmin', type: 'int'  },
						{name : 'srvc_km', type: 'int'  },
						{name : 'fin', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'vrent', type: 'string'  },
						{name : 'renttype', type: 'string'  },
						{name : 'idealdys', type: 'number'  },
						{name : 'branchid', type: 'string'  },
						{name : 'groupid', type: 'string'  },
						{name : 'doc_no', type: 'string'  },
						{name : 'days', type: 'string'  },
						{name : 'permanent', type: 'string'  },
						{name : 'securitypass',type:'string'},
						{name : 'ofleet_no', type: 'number'  },
						
						
						
						
						],
				    localdata: data,
        
        
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
    var cellclassname =  function (row, column, value, data) {
		var ofleet_no=$('#jqxFleetGrid').jqxGrid('getcellvalue', row, "ofleet_no");
	    if(parseInt(ofleet_no)>0){
	    	return "yellowClass";
	    }
	}
        
    
    $("#jqxFleetGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
		showfilterrow: true,
        sortable:true,
        rowsheight:20,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,
		showfilterrow: true,

        columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '5%', 
							cellsrenderer: function (row, column, value) {
						    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}
						},
                        { text: 'ofleet_no', datafield: 'ofleet_no', width: '8%'  ,hidden:true},         
						{ text: 'Avail. Br', datafield: 'branchname', width: '8%',cellclassname: cellclassname   },
						{ text: 'Location', datafield: 'loc_name', width: '8%',cellclassname: cellclassname  },
						{ text: 'Group', datafield: 'gname', width: '5%' ,cellclassname: cellclassname  },
						{ text: 'Brand', datafield: 'brand_name', width: '7%' ,cellclassname: cellclassname  },
						{ text: 'Fleet', datafield: 'fleet_no', width: '5%'  ,cellclassname: cellclassname },
						{ text: 'Fleet Name', datafield: 'flname', width: '14%',cellclassname: cellclassname  },
						{ text: 'YOM', datafield: 'yom', width: '4%' ,cellclassname: cellclassname  },
						{ text: 'Color', datafield: 'color', width: '5%'  ,cellclassname: cellclassname  },
						{ text: 'Reg No', datafield: 'reg_no', width: '6%'  ,cellclassname: cellclassname   },
						{ text: 'Cur. KM', datafield: 'kmin', width: '6%'  ,cellclassname: cellclassname  },
						{ text: 'Due Serv. KM', datafield: 'srvc_km', width: '7%'  ,cellclassname: cellclassname },
						{ text: 'Fuel', datafield: 'fin', width: '7%',cellclassname: cellclassname  },
						{ text: 'Rent Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname  },
						{ text: 'Idle days', datafield: 'idealdys', width: '8%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'},
						//{ text: 'Permanent', datafield: 'permanent', width: '6%' ,cellclassname: cellclassname  },
						{ text: 'branchid', datafield: 'branchid', width: '10%',hidden:true},
						{ text: 'groupid', datafield: 'groupid', width: '10%',hidden:true},
						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'days', datafield: 'days', width: '10%',hidden:true},
						/*{ text: 'Security Pass', datafield: 'securitypass', width: '10%',columntype:'button'},*/
						]
    
    });
    
});
</script>
<div id="jqxFleetGrid"></div>