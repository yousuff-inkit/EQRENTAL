<%@ page import="com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalDAO" %>  
<% ClsHotelBookingPortalDAO DAO=new ClsHotelBookingPortalDAO();%>

<%  
     String check = request.getParameter("check")=="" || request.getParameter("check")==null?"0":request.getParameter("check").trim();
	 String hotelid = request.getParameter("hotelid")=="" || request.getParameter("hotelid")==null?"0":request.getParameter("hotelid").trim();
     String roomid = request.getParameter("roomid")=="" || request.getParameter("roomid")==null?"0":request.getParameter("roomid").trim();
     int child1 = request.getParameter("child1")=="" || request.getParameter("child1")==null?0:Integer.parseInt(request.getParameter("child1").toString());
	 int child2 = request.getParameter("child2")=="" || request.getParameter("child2")==null?0:Integer.parseInt(request.getParameter("child2").toString());
	 int child3 = request.getParameter("child3")=="" || request.getParameter("child3")==null?0:Integer.parseInt(request.getParameter("child3").toString());
	 int child4 = request.getParameter("child4")=="" || request.getParameter("child4")==null?0:Integer.parseInt(request.getParameter("child4").toString());
	 int child5 = request.getParameter("child5")=="" || request.getParameter("child5")==null?0:Integer.parseInt(request.getParameter("child5").toString());
	 int child6 = request.getParameter("child6")=="" || request.getParameter("child6")==null?0:Integer.parseInt(request.getParameter("child6").toString());

%>
<style>
.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    background-color: orange;
    background-image: none
}
</style>  
<script type="text/javascript">   
      var data2;
       
	  		   data2='<%=DAO.subgriddata(hotelid,roomid,check,child1,child2,child3,child4,child5,child6)%>';      
  	  
        $(document).ready(function () {
        	 $("#jqxpricedet").jqxGrid({ theme: "latextheme" });     
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'name', type: 'string'  },
				    {name : 'hotelid' , type: 'string' },
				    {name : 'roomid', type: 'string'  },
				    {name : 'areaid', type: 'string'  },
				    {name : 'basic', type: 'number'  },
				    {name : 'exbed' , type: 'number' },   
					{name : 'child', type: 'number'  },
					{name : 'teenage', type: 'number'  },
					{name : 'total', type: 'number'  },
	            ],
                localdata: data2,
               
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
            $("#jqxpricedet").jqxGrid(
            {
                width: '100%',
                height: 140,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow', 
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [   
                  		{ text: 'Name', datafield: 'name'},          
                  		{ text: 'Hotel id', datafield: 'hotelid',hidden:true, width: '5%'}, 
                		{ text: 'area id', datafield: 'areaid',hidden:true, width: '5%'}, 
                		{ text: 'room id', datafield: 'roomid',hidden:true, width: '5%'}, 
						{ text: 'Basic', datafield: 'basic', width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right'},
						{ text: 'Extra Bed', datafield: 'exbed', width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right'},
						{ text: 'Child', datafield: 'child', width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right'},
						{ text: 'Teenage', datafield: 'teenage', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
						{ text: 'Total', datafield: 'total', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
					 ]                  
            });
            $("#overlay, #PleaseWait").hide();
            //$("#jqxpricedet").jqxGrid('addrow', null, {}); 
        });  

</script>
<div id="jqxpricedet"></div>