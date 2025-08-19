   <%@page import="com.dashboard.marketing.rentalquotefollowup.*"%>
     <%ClsRentalQuoteFollowupDAO cmd= new ClsRentalQuoteFollowupDAO(); %>
 
 
 <%
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	%> 
           	  
 
<script type="text/javascript">
var id='<%=id%>';
var followupdata=[];
if(id=='1')
{ 
	followupdata='<%=cmd.getFollowupData(docno,id)%>';
} 

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
                     
                        {name : 'docno', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'username', type: 'String'  },
						{name : 'description', type: 'String'  },
						{name : 'status', type: 'String'  }						
						],
				    localdata: followupdata,
        
        
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
    
    
   
   
    
    $("#rentalQuoteFollowupGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
					 { text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy'},
				     { text: 'Username',datafield: 'username', width: '10%'},
				     { text: 'Status',datafield: 'status', width: '10%' },
				     { text: 'Description',datafield: 'description',width:'67%'},
					 
					 
					]
   
    });
});


</script>
<div id="rentalQuoteFollowupGrid"></div>