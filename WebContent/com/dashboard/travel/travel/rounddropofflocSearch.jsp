<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%
ClsTravelDAO DAO=new ClsTravelDAO();                                            
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
<script type="text/javascript"> 
            $(document).ready(function () {
            	  var redrpdata= '<%=DAO.getSearchData()%>';         

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'location', type: 'string'  },
                    ],     
                    localdata: redrpdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                 
                $("#jqxroundDropoffLoc").jqxInput({ source: dataAdapter, displayMember: "location", valueMember: "doc_no", items: 20 ,width: 166, height: 20,placeHolder:"Enter 	Drop Off Location"});
                $("#jqxroundDropoffLoc").on('select', function (event) {            
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {          
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("rounddropofflocid").value=dataAdapter.records[i].doc_no;
                                	  getReturnTariffData();
                                	  break;         
                                  }
                              }
                          }
                      }   
                    }); 
            });     
        </script>
         <input id="jqxroundDropoffLoc" />                     