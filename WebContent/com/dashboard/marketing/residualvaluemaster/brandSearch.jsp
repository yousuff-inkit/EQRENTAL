<%@page import="com.dashboard.marketing.residualvaluemaster.*" %>
<%ClsResidualValueMasterDAO masterdao=new ClsResidualValueMasterDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var branddata;
var id='<%=id%>';
if(id=="1"){
	branddata='<%=masterdao.getBrand(id)%>';
}
else{
	branddata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'brand_name', type: 'String'  }
						],
				    localdata: branddata,
        
        
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
    
    
    $("#brandSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
	    sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'doc_no', width: '30%'},
						{ text: 'Brand',datafield:'brand_name',width:'70%'}
					]

    });

	$('#brandSearchGrid').on('rowdoubleclick', function (event) 
	{ 
		var args = event.args;
		// row's bound index.
		var boundIndex = args.rowindex;
		// row's visible index.
		var visibleIndex = args.visibleindex;
		// right click.
		var rightclick = args.rightclick; 
		// original event.
		var ev = args.originalEvent;
		
		$('#brand').val($('#brandSearchGrid').jqxGrid('getcellvalue',boundIndex,'brand_name'));
		$('#hidbrand').val($('#brandSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
		$('#brandwindow').jqxWindow('close');
	});
	
});
</script>
<div id="brandSearchGrid"></div>