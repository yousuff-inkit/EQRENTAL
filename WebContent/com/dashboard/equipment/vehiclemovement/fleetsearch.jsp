<%@ page import="com.dashboard.equipment.ClsvehicleDAO" %>
<%ClsvehicleDAO cvd=new ClsvehicleDAO(); %>

<script type="text/javascript">

var	fleet= '<%=cvd.fleetseachmove()%>';

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                    	{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name: 'vehinfo',type: 'string'},
						{name: 'code_name',type: 'string'},
						{name : 'defleet',type:'string'}
						],
				    localdata: fleet,
        
        
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
    
    
    $("#fleetsearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						 { text: 'Fleet', datafield: 'fleet_no', width: '17%' },
						{ text: 'Name', datafield: 'flname', width: '50%'},
						{ text: 'Asset id', datafield: 'reg_no', width: '17%'},
						
						 {text: 'Plate Code', datafield: 'code_name', width: '16%' },
						{ text: 'vehinfo', datafield: 'vehinfo', width: '25%',hidden:true},
						{ text: 'defleet', datafield: 'defleet', width: '25%',hidden:true},
					]
    
    });
    $('#fleetsearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var boundIndex = event.args.rowindex;
    		    document.getElementById("fleetno").value= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "fleet_no");
    		   // 
    		    var values= $('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "vehinfo");
    		var defleet="Defleet : "+$('#fleetsearchGrid').jqxGrid('getcellvalue',boundIndex, "defleet");
    		    var sum2 = values.toString().replace(/\*/g, '<br>');    
    		  //  var sum2 = values.toString().replace(/\./g, '\n');
    		 
    		    //document.getElementById("vehinfo").value=sum2;
    		    var html='<span>'+sum2+'</span>';
    		    html+='<span style="color:red;font-weight:bold;font-size:12;">'+defleet+'</span>';
    		    document.getElementById("vehinfo").innerHTML =html;
    		    
    	        $('#fleetwindow').jqxWindow('close');
    		});
    
});

	
	
</script>
<div id="fleetsearchGrid"></div>