<%@ page import="com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalDAO" %>  
<% ClsHotelBookingPortalDAO DAO=new ClsHotelBookingPortalDAO();%>
       <script type="text/javascript">
       var ldata;
       ldata= '<%=DAO.searchLocation() %>';      
		$(document).ready(function () { 	
            var source =
            { 
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: ldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxloc").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", width: 190, height: 20});
            $("#jqxloc").on('select', function (event) {            
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("locid").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxloc"/> 