<%@page import="com.operations.agreement.masterleaseagmt.*" %>
<%ClsMasterLeaseAgmtDAO masterdao=new ClsMasterLeaseAgmtDAO();
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var mastergriddata;
if(id=="1"){
	mastergriddata='<%=masterdao.getMasterGridData(docno,id)%>';
}
	$(document).ready(function () { 
		
		
    	var source = 
       	{
        	datatype: "json",
           	datafields: [
 						
				{name : 'brand', type: 'String'  },
				{name : 'brandid',type:'string'},
				{name : 'model', type: 'String'  },
				{name : 'modelid',type:'string'},
				{name : 'specification', type: 'String'  },
				{name : 'specid',type:'string'},
				{name : 'leaseduration', type: 'number'  },
				{name : 'qty', type: 'number'}, 
				{name : 'rate', type: 'number'  },
				{name : 'cdw', type: 'number'  },
				{name : 'pai', type: 'number'  },
				{name : 'gps', type: 'number'},
				{name : 'childseat', type: 'number'  },
				{name : 'kmrestrict', type: 'number'  },
				{name : 'excesskmrate', type: 'number' }
          ],
          localdata: mastergriddata,
           
           pager: function (pagenum, pagesize, oldpagenum) {
              
           }
       };
            
      var dataAdapter = new $.jqx.dataAdapter(source,
		{
        	loadError: function (xhr, status, error) {
            	alert(error);    
            }
        }		
      );
            
            $("#masterLeaseGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlecell',
                editable:true,
                columns: [
					
					{ text: 'Brand', datafield: 'brand', width: '12%',editable:false },
					{ text: 'Brand Id', datafield: 'brandid', width: '16%',hidden:true,editable:false },
					{ text: 'Model', datafield: 'model', width: '12%' ,editable:false},
					{ text: 'Model Id', datafield: 'modelid', width: '7%',hidden:true,editable:false},
					{ text: 'Specification', datafield: 'specification', width: '15%' ,editable:false},
					{ text: 'Spec Id', datafield: 'specid', width: '8%',hidden:true ,editable:false},
					{ text: 'Lease Duration', datafield: 'leaseduration', width: '6%' ,editable:true},
					{ text: 'Quantity', datafield: 'qty', width: '6%' ,editable:true},
					{ text: 'Rate', datafield: 'rate', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2',editable:true }, 
					{ text: 'Cdw', datafield: 'cdw', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
					{ text: 'Pai', datafield: 'pai', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
					{ text: 'GPS', datafield: 'gps', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
					{ text: 'Child Seat', datafield: 'childseat', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
					{ text: 'Km Restict', datafield: 'kmrestrict', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
					{ text: 'Excess Km Rate', datafield: 'excesskmrate', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,editable:true},
	 	
				]
            });
            
            $("#masterLeaseGrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = args.visibleindex;
            		    // right click.
            		    var rightClick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    // column index.
            		    var columnIndex = args.columnindex;
            		    // column data field.
            		    var dataField = args.datafield;
            		    // cell value
            		    var value = args.value;
            		    
            		    if(dataField=="brand"){
            		    	$('#searchwindow').jqxWindow({ title: 'Brand Search' });
            		    	$('#searchwindow').jqxWindow('open');
            		        $('#searchwindow').jqxWindow('focus');
            		        dataSearchContent('brandSearch.jsp?id=1');
            		        var rows=$('#masterLeaseGrid').jqxGrid('getrows');
            		        $('#masterLeaseGrid').jqxGrid('addrow', rows.length+1, {});
            		    }
            		    else if(dataField=="model"){
            		    	var brandid=$('#masterLeaseGrid').jqxGrid('getcellvalue',rowBoundIndex,'brandid');
            		    	if(brandid=='' || brandid==null || brandid=='undefined'){
            		    		$.messager.alert('Warning','Brand is Mandatory');
            		    		return false;
            		    	}
            		    	$('#searchwindow').jqxWindow({ title: 'Model Search' });
            		    	$('#searchwindow').jqxWindow('open');
            		        $('#searchwindow').jqxWindow('focus');
            		        dataSearchContent('modelSearch.jsp?id=1&brandid='+brandid);
            		    }
            		    else if(dataField=="specification"){
            		    	$('#searchwindow').jqxWindow({ title: 'Specification Search' });
            		    	$('#searchwindow').jqxWindow('open');
            		        $('#searchwindow').jqxWindow('focus');
            		        dataSearchContent('specSearch.jsp?id=1');
            		    }
            		    $('#gridrowindex').val(rowBoundIndex);
            		});
    
}); 
	
</script>
<div id="masterLeaseGrid"></div>
<input type="hidden" name="gridrowindex" id="gridrowindex">
