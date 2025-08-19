<%@ page import="com.dashboard.integration.airlineticketing.*" %>
<% ClsAirlineTicketingDAO dao=new ClsAirlineTicketingDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

 <%
  
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
  	String id = request.getParameter("id")==null?"0":request.getParameter("id");
  	String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
  	System.out.println("fromdate ="+fromdate+"todate = "+todate);
 %> 
           	  
 <style type="text/css">
	.redClass
	{
	    color: red;
	}
	.yellowClass
	{
	    color: green;
	}
       </style>
<script type="text/javascript">
var id='<%=id%>';
var airlinedata=[];
if(id=="1"){
	airlinedata='<%=dao.getDownloadData(docno,id)%>';
}

$(document).ready(function () {
 
    var source =
    {
        datatype: "json",
        datafields: [  
                        {name : 'doc_no', type: 'number'},
                        {name : 'airline', type: 'string'  },
						{name : 'documentno', type: 'string'  },
						{name : 'issuedate', type: 'date'  },
						{name : 'netamount', type: 'number'  }
						],
				    localdata: airlinedata,
        
        
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
    
    
    $("#airlineTicketingGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        columns: [   
                  
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
					
              	 { text: 'Doc No', datafield: 'doc_no',  width: '10%' }, 
              	 { text: 'Airline', datafield: 'airline',  width: '35%' }, 
           	     { text: 'Document No', datafield: 'documentno',  width: '30%' }, 
				{ text: 'Issue Date', datafield: 'issuedate', width: '10%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Net Amount', datafield: 'netamount', width: '10%',align:'right',cellsalign:'right',cellsformat:'d2'},
					 
					]
   
    });
    
    $("#overlay, #PleaseWait").hide();
    
  
    
  
});


</script>
<div id="airlineTicketingGrid"></div>