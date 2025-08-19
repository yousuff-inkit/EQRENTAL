<%@page import="com.dashboard.client.ClsClientDAO"%>
<%ClsClientDAO DAO= new ClsClientDAO(); 
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
       
<script type="text/javascript">
  var id='<%=id%>';
  var clientcatdata=[];
  if(id=="1"){
  	clientcatdata='<%=DAO.getClientCategory(id)%>';
  }
  else{
  	clientcatdata=[];
  }
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'cat_name', type: 'string'  }
                        ],
                 	localdata: clientcatdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
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
                              { text: 'Name', datafield: 'cat_name', width: '100%' },
						]
            });
            
          $('#clientCatSearchGrid').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("clientcat").value=$('#clientCatSearchGrid').jqxGrid('getcellvalue', rowindex2, "cat_name");
                document.getElementById("hidclientcat").value=$('#clientCatSearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
                
                $('#clientcatwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="clientCatSearchGrid"></div>