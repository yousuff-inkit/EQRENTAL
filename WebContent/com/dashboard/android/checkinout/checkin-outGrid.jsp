<%@ page import="com.dashboard.android.checkinout.CheckInOutDAO" %>
<% CheckInOutDAO ciod=new CheckInOutDAO(); %>
<%
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();

        String fdateval = request.getParameter("fdate1")==null?"0":request.getParameter("fdate1").trim();
         String tdateval = request.getParameter("tdate1")==null?"0":request.getParameter("tdate1").trim();
         String regno = request.getParameter("regno")==null?"NA":request.getParameter("regno").trim();
         String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
        
%> 
		             	  
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">


 var temp4='<%=branchval%>';
var ssss;
var checkinoutexcel;
var aa;

if(temp4!='NA')
{ 
	//alert("in");
	ssss='<%=ciod.searchcheckinout(branchval,fdateval,tdateval,regno,type)%>'; 
	checkinoutexcel='<%=ciod.excelcheckinout(branchval,fdateval,tdateval,regno,type) %>';
	//alert(ssss);
aa=0;
	
}
else
{
	
	ssss;
	checkinoutexcel
	 aa=1;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						
						{name : 'docno', type: 'string'  },
						{name : 'brno', type: 'string'  },
						{name : 'date1', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'clientname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'rdocno', type: 'string'  },
						{name : 'rdtype', type: 'string'  },
						{name : 'fleet', type: 'string'  },
						{name : 'type', type: 'string'  },
						{name : 'pltid', type: 'string'  },
							],
				    localdata: ssss,
        
        
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
    
    
    $("#checkinoutGrid").jqxGrid(
    {
        width: '98%',
        height: 390,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Type', datafield: 'type',width: '8%' },
						{ text: 'Reg No.', datafield: 'reg_no', width: '8%'},
						{ text: 'Fleet No', datafield: 'fleet',width: '10%' },
						{ text: 'Plate Code', datafield: 'pltid',width: '10%' },
						{ text: 'Doc No.', datafield: 'docno',width: '10%'  },
						{ text: 'Date', datafield: 'date1',width: '20%'  },
						{ text: 'Branch', datafield: 'branch',width: '10%'    },
						{ text: 'Ref Doc No.', datafield: 'rdocno',width: '12%' },
						{ text: 'Ref Doc Type', datafield: 'rdtype',width: '12%' },
						{ text: 'Client Name', datafield: 'clientname', width: '12%' ,hidden:true   },
						
						
						{ text: 'Branch No', datafield: 'brno',width: '8%',hidden:true },
						
							]
    
    });
    
    	     $('#checkinoutGrid').on('rowdoubleclick', function (event) 
	     		{ 
	 	  var rowindex1=event.args.rowindex;
	 	  
	 	 var doc=$('#checkinoutGrid').jqxGrid('getcellvalue', rowindex1, "docno");
	 	$("#detaildiv").load("followDetailgrid.jsp?rdoc="+doc); 
	 	
		
	 	$("#Readygrid").load("subgrid.jsp?docno="+doc); 

	 	
	     
	     		}); 

});

	
	
</script>
<div id="checkinoutGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">