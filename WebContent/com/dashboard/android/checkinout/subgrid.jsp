<%@ page import="com.dashboard.android.checkinout.CheckInOutDAO" %>
<% CheckInOutDAO ciod=new CheckInOutDAO(); %>

 <%
/*  String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();

 String fdateval = request.getParameter("fdate1")==null?"0":request.getParameter("fdate1").trim();
  String tdateval = request.getParameter("tdate1")==null?"0":request.getParameter("tdate1").trim();
  String regno = request.getParameter("regno")==null?"NA":request.getParameter("regno").trim();
  String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
 */  
  String doc = request.getParameter("docno")==null?"NA":request.getParameter("docno").trim();
           	  %> 
<script type="text/javascript">
	var temp1='<%=doc%>';
	
	 var vehdatas;
		vehdatas= '<%=ciod.subDetails(doc)%>';
$(document).ready(function () {
	

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 
						{name : 'name', type: 'string'  },
						{name : 'val', type: 'bool'  },
						
						
						],
				    localdata: vehdatas,
        
        
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
    
    
    $("#chkvalues").jqxGrid(
    {
        width: '90%',
        height: 200,
        source: dataAdapter,
        rowsheight:20,
        statusbarheight: 20,
       // selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Type', datafield: 'name', width: '70%'},
						{ text: 'Value', datafield: 'val', width: '30%', columntype: 'checkbox'},
						
						
					]
    
    });
    
});

	
	
</script>
<div id="chkvalues"></div>