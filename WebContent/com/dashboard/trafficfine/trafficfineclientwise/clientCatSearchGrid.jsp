<%@page import="com.dashboard.trafficfine.trafficfineclientwise.*"%>
<%ClsTrafficFineClientWiseDAO DAO= new ClsTrafficFineClientWiseDAO(); %>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=id%>';

   var data2;
   
   if(id=='1'){
	   data2='<%=DAO.clientCategorySearch(id)%>';
	}
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                  		{name : 'doc_no',type:'number'},
                  		{name : 'clientcatname',type:'String'},
                  	],
				    localdata: data2,
        
        
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
    
    
    $("#clientCatSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        sortable:false,
        
        columns: [
       				{ text: 'Doc No',datafield:'doc_no',width:'25%'},
       				{ text:'Category Name',datafield:'clientcatname',width:'75%'}
				]

    });
     $('#clientCatSearch').on('rowdoubleclick', function (event) 
		{ 
		var rowindex1=event.args.rowindex;
		document.getElementById("clientcat").value=$('#clientCatSearch').jqxGrid('getcellvalue', rowindex1, "clientcatname"); 
		document.getElementById("hidclientcat").value=$('#clientCatSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		$('#clientcatwindow').jqxWindow('close');
	}); 
    
});
	
</script>
<div id="clientCatSearch"></div>