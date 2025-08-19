<%@ taglib prefix="s" uri="/struts-tags"%>
 <%@page import="com.dashboard.travel.hotelvouchercreate.ClsHotelVoucherCreateDAO"%>
 <%  ClsHotelVoucherCreateDAO DAO=new ClsHotelVoucherCreateDAO(); %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchRoomtype(session) %>';      
		$(document).ready(function () { 	  
            var source =
            {  
                datatype: "json",
                datafields: [
                             {name : 'roomtype', type: 'string'  },
                        ],
                		  
                		//  url: url1,
                 localdata: vdata,
                  
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };  
         
            var dataAdapter = new $.jqx.dataAdapter(source);         
            
            $("#jqxrtype").jqxInput({ source: dataAdapter, displayMember: "roomtype", valueMember: "roomtype"});
            $("#jqxrtype").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].roomtype) {   
                                  document.getElementById("roomtypeid").value=dataAdapter.records[i].roomtype;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxrtype" placeHolder="Enter Room Type" class="form-control input-sm" value='<s:property value="jqxrtype"/>'/> 