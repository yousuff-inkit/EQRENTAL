<%@ page import="com.dashboard.travel.hotelbookingportal.ClsHotelBookingPortalDAO" %>  
<% ClsHotelBookingPortalDAO DAO=new ClsHotelBookingPortalDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	  
}   
</style>
 
  <script type="text/javascript"> 
            $(document).ready(function () {    
            	  var cdata= '<%=DAO.searchclient(session)%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'user', type: 'string'  },
                                 {name : 'mob', type: 'string'  },
                                 {name : 'mail', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxClient").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20 ,width: 800, height: 20});
                $("#jqxClient").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("hidclient").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("txtmob").value=dataAdapter.records[i].mob;
                                	  document.getElementById("hidname").value=dataAdapter.records[i].user;  
                                	  document.getElementById("txtemail").value=dataAdapter.records[i].mail;     
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxClient" />