<%@page import="com.dashboard.accounts.balancesheetbranch.ClsBalanceSheetDAO" %>
<%ClsBalanceSheetDAO cbs=new ClsBalanceSheetDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String entrydate = request.getParameter("entrydate")==null?"0":request.getParameter("entrydate").trim(); 
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String level1 = request.getParameter("level1")==null?"0":request.getParameter("level1").trim();
	 String level2 = request.getParameter("level2")==null?"0":request.getParameter("level2").trim();
	 String level3 = request.getParameter("level3")==null?"0":request.getParameter("level3").trim();
	 String level4 = request.getParameter("level4")==null?"0":request.getParameter("level4").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
	 
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>

 <script type="text/javascript">
 
 		var data;
 		var dataExcelExport;
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		 
 		if(temp!='NA'){
	    		data = '<%=cbs.balanceSheetGrid(branchval, fromDate, toDate, level1, level2, level3, level4, check,entrydate)%>';
	    		dataExcelExport = '<%=cbs.balanceSheetExcelExport(branchval, fromDate, toDate, level1, level2, level3, level4, check,entrydate)%>';
 		}
 	
        $(document).ready(function () {
      	  
	      	/*$("#btnExcel").click(function () {
	            $("#balanceSheetGrid").jqxTreeGrid('exportData', 'xls');
	        });*/
      	  	
            var source =
             {
                 dataType: "json",
                 dataFields: [
					  { name: "id", type: "number" },
                      { name: 'description', type: 'string' },
                      { name: 'subchildamt', type: 'number' },
                      { name: 'grpamt', type: 'number' },
                      { name: 'childamt', type: 'number' },
                      { name: 'netamt', type: 'number' },
                      { name: "parentid", type: "number" },
                      { name: "ordno", type: "number" },
                      { name: "groupno", type: "number" },
                      { name: "subac", type: "number" },
                      { name: "gp_id", type: "number" }
                 ],
                 hierarchy:
                 {
                     keyDataField: { name: 'id' },
                     parentDataField: { name: 'parentid' }
                 },
                 id: 'id',
                 localData: data
             };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function () {
                }
            });
            
            var cellclassname = function (row, column, value, data) {
            	 if (data.gp_id == '14') {
                     return "greenClass";
                 } if (data.gp_id == '19') {
                     return "greenClass";
                 }else if (data.ordno == '5'){
                	 return "headClass";
                 } else if (data.ordno == '3') {
                     return "redClass";
                 } else if (data.ordno == '4') {
                 	 return "violetClass";
                 }else if (data.ordno == '1'){
                 	 return "yellowClass";
                 }else if (data.ordno == '6'){
                	 return "whiteClass";
                 };
            };
            
            $("#balanceSheetGrid").jqxTreeGrid(
            {
                source: dataAdapter,
                width: '99.5%',
                height: 520,
                ready: function() 
                {
                	var rows = $("#balanceSheetGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#balanceSheetGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                		$('#btnprint').attr("disabled",false);
                	}
                }, 
                
                columns: [
						  { text: 'Id',  hidden: true, datafield: 'id', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Parent Id',  hidden: true, datafield: 'parentid', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Ord No',  hidden: true, datafield: 'ordno', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Group No',  hidden: true, datafield: 'groupno', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Group Id',  hidden: true, datafield: 'gp_id', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Account',  hidden: true, datafield: 'subac', cellclassname: cellclassname, width: '10%'  },
		                  { text: 'Description',  datafield: 'description', cellclassname: cellclassname, width: '40%'  },
		                  { text: 'Detail',  datafield: 'subchildamt', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '15%' },
		                  { text: 'Main',  datafield: 'grpamt', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '15%' },
		                  { text: 'Group I',  datafield: 'childamt', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '15%' },
		                  { text: 'Group II',datafield: 'netamt', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '15%' }
                       ]
            });
            
            if(temp=='NA'){
                $("#balanceSheetGrid").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#balanceSheetGrid').on('rowDoubleClick', function (event) {
            	var args = event.args;
                var row = args.row;
                var desc= "Balance Sheet"; 
                var accdocno="";
          	    if(row.ordno == 6)
          	    {
          	        var url=document.URL;
					var reurl=url.split("com/");
					
					accdocno=row.subac;
					var detName=row.description;
					var path="com/dashboard/accounts/balancesheet/accountDetails.jsp";
					top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc.replace(/ /g, "%20")+"&branchval="+temp+'&fromdate='+temp1+'&todate='+temp2+'&accdocno='+accdocno);
          		}
          	    
              });
            
        });
    </script>

    <div id="balanceSheetGrid"></div>
