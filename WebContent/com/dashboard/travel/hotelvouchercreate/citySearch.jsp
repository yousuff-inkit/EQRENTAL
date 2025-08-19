<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
 <%                 
    String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
%>
       <script type="text/javascript">
       var ndata;
       ndata= '<%=DAO.searchCity(docno) %>';          
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
            
            $("#jqxcity").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20});
            $("#jqxcity").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("cityid").value=dataAdapter.records[i].doc_no;  
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxcity" placeHolder="Enter City" class="form-control input-sm" value='<s:property value="jqxcity"/>'/>   