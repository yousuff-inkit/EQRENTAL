 <%@page import="com.dashboard.salik.othersalik.*"%>
 
 
 <%
           	String id = request.getParameter("chval")==null?"NA":request.getParameter("chval").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	//System.out.println("---------"+chval);
	
	ClsOtherSalikDAO viewDAO= new ClsOtherSalikDAO();
	
           	  %> 
           	  

<script type="text/javascript">
 var temp4='<%=id%>';
var dats;
  if(temp4=='1')
{ 
	//alert("in");
dats='<%=viewDAO.getOtherSalikData(id,uptodate)%>'; 


	
}
else
{
	
	dats;
	
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",       
        datafields: [
       

						{name : 'regno', type: 'string'  },
						{name : 'trans', type: 'String'  },
						{name : 'tagno', type: 'String'  },
						{name : 'source', type: 'string'  },
						{name : 'sal_date', type: 'date'  },
						{name : 'source', type: 'string'  },
						{name : 'amount', type: 'string'  },
						{name : 'btnsave', type: 'string'  },
					
						
						],
				    localdata: dats,
        
        
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
    
    
    $("#salikGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
      
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode:'checkbox',
        pagermode: 'default',
       
        columns: [   	
			                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                     	
                     	
						{ text: 'Reg NO', datafield: 'regno', width: '12%' },
						{ text: 'Tag No', datafield: 'tagno', width: '12%'   },
						{ text: 'Transaction No', datafield: 'trans', width: '20%' },
						{ text: 'Source', datafield: 'source', width: '22%'},
						{ text: 'Salik Date', datafield: 'sal_date', width: '13%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Amount', datafield: 'amount', width: '13%',cellsalign: 'right', align:'right' },
					 
						
						 { text: ' ', datafield: 'btnsave', width: '10%',columntype: 'button',editable:false, filterable: false,hidden:true},
					
					/* 
						{ text: 'doc_no', datafield: 'doc_no', width: '10%',hidden:true},
						{ text: 'sr_no', datafield: 'sr_no', width: '10%' ,hidden:true}, */
						
					]
    
    });
    
    $("#overlay, #PleaseWait").hide(); 
    
     
    
    $("#salikGrid").on('cellclick', function (event) 
   		{
        var datafield = event.args.datafield;

	    var rowBoundIndex = args.rowindex;
	    
	    
	    if(datafield=="btnsave"){
       	 if($('#salikGrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Delete"){
       		
       		 
       		 var trans= $('#salikGrid').jqxGrid('getcellvalue',rowBoundIndex, "trans");
       		 
       		 
       
		                          $.messager.confirm('Message', 'Do you want to Delete?', function(r){
		        	  
	     		       
				       		        	if(r==false)
				       		        	  {
				       		        		return false; 
				       		        	  }
				       		        	else{
				        				 savegriddatas(trans);
				       		        	   }
		                      });
       	 }
       	 else {
       		 
       	
       	  $('#salikGrid').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Delete");
       	    }
    	
	    }
   		});
    
    
   
    
    
    
    
	   
});

function savegriddatas(trans)
{
	  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			
			
			 
			   if(parseInt(itemval)=="99")
			    	{
			    	
			    	   $.messager.alert('Message', '  Record Successfully Deleted ');
			    	   funreload(event);
				       $("#hidediv").hide();
				       
				     
	
			    	}
			    else
			    	{
			    	
			    	  $.messager.alert('Message', '  Not Deleted ');
				      // funreload(event);
				       $("#hidediv").hide();
			    	
			    	}
			    
			    
			}
		else
			{
			
			}                                                                // trftype branchsss   rentaldoc leasedoc drdoc staffdoc
	}
	x.open("GET","deletedata.jsp?trans="+trans);

	x.send();	
	
}
	
</script>
<div id="salikGrid"></div>