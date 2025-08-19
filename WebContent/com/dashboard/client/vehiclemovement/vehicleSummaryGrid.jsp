
<%-- <jsp:include page="../../../../menu.jsp"></jsp:include> --%>
<%@ page import="com.dashboard.client.vehiclemovement.ClsVehicleMovDAO" %>

 <%
    String client = request.getParameter("client")==null?"NA":request.getParameter("client").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	ClsVehicleMovDAO vmdao=new ClsVehicleMovDAO();

 %> 
           	  
 
<script type="text/javascript">


/* function addTab(title, url){
	if ($('#tt').tabs('exists', title)){
		$('#tt').tabs('select', title);
	} else {
	 
	 var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('#tt').tabs('add',{
			title:title,
			content:content,
			closable:true
			/* showCloseButtons: true 
		 });
	} 
	
} */ 
 var temp4='<%=client%>';
var vehiclesummary;

 if(temp4!='NA')
{ 
	  
	 vehiclesummary='<%=vmdao.vehicleSummary(client,fromdate,todate)%>'; 
	
} 
else
{ 
	
	vehiclesummary;

	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'hourdiff', type: 'number'  },
						{name : 'st_desc', type: 'string'  },
						{name : 'rdtype', type: 'String'  },
						{name : 'tfuel', type: 'number'  },
						{name : 'tkm', type: 'number'}
						
						
					
						
						],
				    localdata: vehiclesummary,
        
        
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
    
    
   
   
    
    $("#vehiclesummary").jqxGrid(
    {
        width: '98%',
        height: 200,
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
                  
                
					
           	         { text: 'Type', datafield: 'rdtype',  width: '20%' }, 
					 { text: 'Tran Code', datafield: 'st_desc', width: '20%'},
					 { text: 'Total Hours', datafield: 'hourdiff', width: '20%',cellsformat:'d2'},
					 { text: 'Total Fuel', datafield: 'tfuel', width: '20%',cellsformat:'d3'},
					 { text: 'Total Km', datafield: 'tkm', width: '20%',cellsformat:'d2'}
				     
					 
					]
   
    });
 
    
  
});


</script>
<div id="vehiclesummary"></div>