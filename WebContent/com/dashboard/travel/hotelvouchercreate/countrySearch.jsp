<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
       <script type="text/javascript">
       var ndata;
       ndata= '<%=DAO.searchCountry() %>';            
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: ndata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.      
                }
                                        
            }; 
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcountry").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20});
            $("#jqxcountry").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {     
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  $("#countryid").val(dataAdapter.records[i].doc_no); 
                                  var docno=dataAdapter.records[i].doc_no; 
		 						  $('#city').load('citySearch.jsp?docno='+docno);             
                                  break;   
                              }     
                          }
                      }
                  }      
                }); 
                  });    
    </script>  
    <input id="jqxcountry" placeHolder="Enter Country"   class="form-control input-sm" value='<s:property value="jqxcountry"/>'/>     