<%@page import="com.dashboard.operations.agmtpaymentupdate.*" %>
<%ClsAgmtPaymentupdateDAO updatedao=new ClsAgmtPaymentupdateDAO();
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String clientmobile=request.getParameter("clientmobile")==null?"":request.getParameter("clientmobile");
String clientmail=request.getParameter("clientmail")==null?"":request.getParameter("clientmail");
String agmtdate=request.getParameter("agmtdate")==null?"":request.getParameter("agmtdate");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var agmtsearchdata;
var id='<%=id%>';
if(id=="1"){
	agmtsearchdata='<%=updatedao.getAgmtSearchData(agmtno,clientname,clientmobile,clientmail,id,agmtdate)%>'; 
}
else{
	agmtsearchdata=[];
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'agmtdocno' , type: 'number' },
                  		{name : 'agmtvocno' , type: 'number' },
						{name : 'clientname', type: 'String'  },
						{name : 'clientmobile', type: 'String'    },
						{name : 'clientmail', type: 'String'  },
						{name : 'date',type:'date'}
						],
				    localdata: agmtsearchdata,
        
        
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
    
    
    $("#agmtSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        columnsresize:true,
        selectionmode: 'singlerow',
	    sortable:false,
        columns: [
               
						{ text: 'Doc No Original', datafield: 'agmtdocno', width: '10%',hidden:true},
						{ text: 'Doc No', datafield: 'agmtvocno', width: '10%'},
						{ text: 'Date',datafield:'date',width:'15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Name', datafield: 'clientname', width: '40%'},
						{ text: 'Mobile', datafield: 'clientmobile', width: '15%'},
						{ text: 'Email', datafield: 'clientmail', width: '20%'},
						
					]

    });

	$('#agmtSearchGrid').on('rowdoubleclick', function (event) 
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
		
		$('#agmtno').val($('#agmtSearchGrid').jqxGrid('getcellvalue',boundIndex,'agmtvocno'));
		$('#hidagmtno').val($('#agmtSearchGrid').jqxGrid('getcellvalue',boundIndex,'agmtdocno'));
		$('#agmtsearchwindow').jqxWindow('close');
	});
	
});
</script>
<div id="agmtSearchGrid"></div>