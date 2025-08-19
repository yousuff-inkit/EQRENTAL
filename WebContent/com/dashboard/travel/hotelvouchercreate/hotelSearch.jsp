 <%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}
</style>
       <script type="text/javascript">
       var hdata;
       hdata= '<%=DAO.searchHotel() %>';      
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: hdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxhotel").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 });
            $("#jqxhotel").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {     
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("hotelid").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxhotel" placeHolder="Enter Hotel" class="form-control input-sm" value='<s:property value="jqxhotel"/>'/> 