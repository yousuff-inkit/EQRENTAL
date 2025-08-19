<%@page import="com.dashboard.rentalagreement.preauthrental.ClsPreAuthRentalDAO"%>
<%ClsPreAuthRentalDAO preauthdao=new ClsPreAuthRentalDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var clientcatdata;
if(id=="1"){
	clientcatdata='<%=preauthdao.getClientCatData(id)%>';
}
else{
	clientcatdata=[];
}
$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'cat_name', type: 'string'  },
                            {name : 'doc_no', type: 'number'  }
     						
                        ],
                		
                 localdata: clientcatdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         	$("#clientCatSearchGrid").on("bindingcomplete", function (event) {
		    	$("#overlay, #PleaseWait").hide();
		    });
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientCatSearchGrid").jqxGrid(
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
		                      { text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Category Name', datafield: 'cat_name', width: '100%' },
                           
						
						]
            });
            
          $('#clientCatSearchGrid').on('rowdoubleclick', function (event) {
          	var rowindex = event.args.rowindex;
            document.getElementById("clientcat").value=$('#clientCatSearchGrid').jqxGrid('getcellvalue', rowindex, "cat_name");
            document.getElementById("hidclientcat").value=$('#clientCatSearchGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
            $('#clientcatwindow').jqxWindow('close'); 
          }); 
        });
    </script>
    <div id="clientCatSearchGrid"></div>