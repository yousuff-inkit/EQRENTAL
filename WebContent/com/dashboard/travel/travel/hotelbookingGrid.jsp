 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
 <%  ClsTravelDAO DAO=new ClsTravelDAO(); %>          
<%        
		String roomid = request.getParameter("roomid")=="" || request.getParameter("roomid")==null?"0":request.getParameter("roomid").trim();  
		String roomtypeid = request.getParameter("roomtypeid")=="" || request.getParameter("roomtypeid")==null?"0":request.getParameter("roomtypeid").trim();
		String rating = request.getParameter("rating")=="" || request.getParameter("rating")==null?"0":request.getParameter("rating").trim();
        String cldocno = request.getParameter("cldocno")=="" || request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
		int extrabed = request.getParameter("extrabed")=="" || request.getParameter("extrabed")==null?0:Integer.parseInt(request.getParameter("extrabed").toString());   
		String mealplan = request.getParameter("mealplan")=="" || request.getParameter("mealplan")==null?"0":request.getParameter("mealplan").trim();
		String fromdate = request.getParameter("fromdate")=="" || request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
		String todate = request.getParameter("todate")=="" || request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
		String locid = request.getParameter("locid")=="" || request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
		String nationid = request.getParameter("nationid")=="" || request.getParameter("nationid")==null?"0":request.getParameter("nationid").trim();
		String hotelid = request.getParameter("hotelid")=="" || request.getParameter("hotelid")==null?"0":request.getParameter("hotelid").trim();
		int adult = request.getParameter("pax")=="" || request.getParameter("pax")==null?0:Integer.parseInt(request.getParameter("pax").toString());
		int child = request.getParameter("child")=="" || request.getParameter("child")==null?0:Integer.parseInt(request.getParameter("child").toString());
		String check = request.getParameter("check")=="" || request.getParameter("check")==null?"0":request.getParameter("check").trim();
		int child1 = request.getParameter("child1")=="" || request.getParameter("child1")==null?0:Integer.parseInt(request.getParameter("child1").toString());
		int child2 = request.getParameter("child2")=="" || request.getParameter("child2")==null?0:Integer.parseInt(request.getParameter("child2").toString());
		int child3 = request.getParameter("child3")=="" || request.getParameter("child3")==null?0:Integer.parseInt(request.getParameter("child3").toString());
		int child4 = request.getParameter("child4")=="" || request.getParameter("child4")==null?0:Integer.parseInt(request.getParameter("child4").toString());
		int child5 = request.getParameter("child5")=="" || request.getParameter("child5")==null?0:Integer.parseInt(request.getParameter("child5").toString());
		int child6 = request.getParameter("child6")=="" || request.getParameter("child6")==null?0:Integer.parseInt(request.getParameter("child6").toString());
%>  
<style type="text/css">        
    #jqxhotelbook .jqx-grid
    {  
        border: none;
    }     
    #jqxhotelbook .jqx-grid-cell
       {
            border-right-color: transparent !important;
       } 
</style>  
<script type="text/javascript">     
      var data1;  
	  		   data1='<%=DAO.bookinggriddata(fromdate,todate,locid,nationid,hotelid,adult,child,check,child1,child2,child3,child4,child5,child6,extrabed,mealplan,cldocno,roomid,roomtypeid,rating)%>';         
  	  
        $(document).ready(function () {
        	var source = 
            {
                datatype: "json",
                datafields: [   
					{name : 'hotel' , type: 'string' },
					{name : 'loc', type: 'string'  },
					{name : 'rtype', type: 'string'  },
					{name : 'cat', type: 'string'  },
					{name : 'name', type: 'string'  },
					{name : 'details' , type: 'string' },  
					{name : 'price', type: 'number'  },     
					{name : 'hotelid' , type: 'string' },
					{name : 'roomid', type: 'string'  },
	            ],    
                localdata: data1,
               
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
            $("#jqxhotelbook").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                filterable: true,
                sortable: true,
                enabletooltips: true,
                selectionmode: 'checkbox',      
                editable: false, 
                localization: {thousandsSeparator: ""},  
                
                columns: [
						{ text: 'Hotel', datafield: 'hotel', width: '10%' },   
						{ text: 'Hotel id', datafield: 'hotelid',hidden:true, width: '5%'}, 
                		{ text: 'room id', datafield: 'roomid',hidden:true, width: '5%'}, 
						{ text: 'Area', datafield: 'loc', width: '13%' },
						{ text: 'Room Type', datafield: 'rtype', width: '10%' },        
						{ text: 'Category', datafield: 'cat', width: '10%' },
						{ text: 'Name', datafield: 'name', width: '15%' },
						{ text: 'Details', datafield: 'details'},  
						{ text: 'Price', datafield: 'price',width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
					 ]
            });
            $("#overlay, #PleaseWait").hide();  
            //$("#jqxhotelbook").jqxGrid('addrow', null, {}); 
        });

</script>
<div id="jqxhotelbook"></div>