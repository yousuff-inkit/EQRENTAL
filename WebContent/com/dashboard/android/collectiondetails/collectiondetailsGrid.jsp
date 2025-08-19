<%@ page import="com.dashboard.android.collectiondetails.ClsToCollectionDetails" %>
<%
	      String fdateval = request.getParameter("fdate1")==null?"0":request.getParameter("fdate1").trim();
         String tdateval = request.getParameter("tdate1")==null?"0":request.getParameter("tdate1").trim();
        
//System.out.println(fdateval+"=="+tdateval);

// String RR="RR";
// System.out.println("---------"+descval);
ClsToCollectionDetails ctcd=new ClsToCollectionDetails();
%> 
		             	  
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">

	var ssss='<%=ctcd.searchCollectionDetails(fdateval,tdateval)%>'; 
	
	var collectionexcel='<%=ctcd.excelCollectionDetails(fdateval,tdateval)%>';
	
	
	
	
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						
						{name : 'ratype', type: 'string'  },
						{name : 'rano', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'km', type: 'string'  },
						{name : 'fuel', type: 'string'  },
						{name : 'date1', type: 'date'  },
						{name : 'time1', type: 'string'  },
						{name : 'user_name', type: 'string'  },
						{name : 'edate', type: 'date'  },
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
    
   
    
    $("#collectionGrid").jqxGrid(
    {
        width: '98%',
        height: 525,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						
						{ text: 'RA Type', datafield: 'ratype',width: '10%'  },
						{ text: 'RA No.', datafield: 'rano', width: '10%' },
						{ text: 'Branch', datafield: 'branch',width: '14%'    },
						{ text: 'KM', datafield: 'km',width: '10%' },
						{ text: 'Fuel', datafield: 'fuel', width: '10%' },
						{ text: 'Date', datafield: 'date1',width: '10%' ,cellsformat:'dd.MM.yyyy' },
						{ text: 'Time', datafield: 'time1', width: '10%'    },
						{ text: 'Username', datafield: 'user_name',width: '12%' },
						{ text: 'Entry Date', datafield: 'edate',width: '14%',cellsformat:'dd.MM.yyyy HH:mm' },
						
											
							]
    
    });
   	    
});

	
	
</script>
<div id="collectionGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">