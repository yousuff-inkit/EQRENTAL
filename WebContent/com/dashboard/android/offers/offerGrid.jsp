<%@ page import="com.dashboard.android.veh_booking.ClsVehicleBookDAO" %>
<% ClsVehicleBookDAO cvbd=new ClsVehicleBookDAO(); %>
<% String contextPath=request.getContextPath();%>
 
 <%
	
 	String idd=request.getParameter("id");
   
 	//System.out.println(idd);
 %>
 
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">

var id='<%=idd%>';
<%-- var brcc='<%=session.getAttribute("BRANCHID")%>'; --%>
//alert("id:"+id);
var ssss;
if(id=="1")
{
	//alert("iiiii");
	ssss='<%=cvbd.offerSearch()%>';
}

 
$(document).ready(function () {
   //alert(brcc);

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						{name : 'doc_no', type: 'string'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'vehicle_name', type: 'string'  },
						{name : 'monthly', type: 'string'  },
						{name : 'weekly', type: 'string'},
						{name : 'daily', type: 'string'  },
						{name : 'adult', type: 'string'  },
						{name : 'door', type: 'string'  },
						{name : 'luggage', type: 'string'  },
						{name : 'fuel', type: 'string'},
						{name : 'wheel', type: 'string'  },
						{name : 'attachbtn', type: 'string'},
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
    
    
    $("#vehOfferGrid").jqxGrid(
    {
        width: '100%',
        height: 515,
        source: dataAdapter,
        //showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'SL#', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '4%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						  }
						},  
						  
						{ text: 'Sl No.', datafield: 'doc_no',width: '4%',hidden:true},
						{ text: 'Valid From', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Valid To', datafield: 'todate',width: '8%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Vehicle Name', datafield: 'vehicle_name',width: '10%' },
						{ text: 'Monthly', datafield: 'monthly',width: '8%' },
						{ text: 'Weekly', datafield: 'weekly',width: '8%' },
						{ text: 'Daily', datafield: 'daily', width: '8%'},
						{ text: 'Adult Passenger', datafield: 'adult',width: '8%' },
						{ text: 'No. of Door', datafield: 'door',width: '6%' },
						{ text: 'No. of Luggage', datafield: 'luggage',width: '8%' },
						{ text: 'Fuel Capacity', datafield: 'fuel',width: '8%' },
						{ text: '4 Wheel Drive', datafield: 'wheel', width: '9%'},
						
						{ text: ' ', datafield: 'attachbtn', width: '7%',columntype: 'button',editable:false, filterable: false},
						
				]
    
    });
    
    

    $('#vehOfferGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
 		var vehicle=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "vehicle_name");
 		var month=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "monthly");
 		var week=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "weekly");
 		var day=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "daily");
 		var adlt=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "adult");
 		var door=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "door");
 		var lugg=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "luggage");
 		var fuel=$('#vehOfferGrid').jqxGrid('getcellvalue', rowindex1, "fuel");


		document.getElementById("sdocno").value= doc;
		document.getElementById("name").value= vehicle;
		document.getElementById("monthly").value= month;
		document.getElementById("weekly").value= week;
		document.getElementById("daily").value= day;
		document.getElementById("adult").value= adlt;
		document.getElementById("door").value= door;
		document.getElementById("luggage").value= lugg;
		document.getElementById("fuel").value= fuel;
		/* document.getElementById( */


	}); 
    
	$("#vehOfferGrid").on('cellclick', function (event) 
    {
		var datafield = event.args.datafield;
		var rowindex1=event.args.rowindex;
		//alert("attach"+datafield);
		 if(datafield=="attachbtn")
		 {
			 //alert("atchbtn");
      		//var brchid=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch"); 
      		var docno=$("#vehOfferGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
      		
      		var frmdet="OFFR";
      		if (docno!="")
      		{
				//alert("formCode="+frmdet+"&docno="+docno+"&brchid=1");
				var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid=1 &frmname=OFFER","_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
			
			} 
      		else 
			{
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			 }
      		 
           }
		
    });
    		   

});

	
	
</script>
<div id="vehOfferGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">