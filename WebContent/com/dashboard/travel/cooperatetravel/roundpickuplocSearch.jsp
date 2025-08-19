<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
<script type="text/javascript"> 
            $(document).ready(function () {
            	  var repckdata= '<%=DAO.getSearchData()%>';                 

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'location', type: 'string'  },
                    ],     
                    localdata: repckdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput     
                 
                $("#jqxroundPickupLoc").jqxInput({ source: dataAdapter, displayMember: "location", valueMember: "doc_no", items: 20 ,width: 166, height: 20,placeHolder:"Enter Pickup Location"});
                $("#jqxroundPickupLoc").on('select', function (event) {          
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("roundpickuplocid").value=dataAdapter.records[i].doc_no;
                                	  getReturnTariffData();
                                	  break;       
                                  }
                              }
                          }
                      }   
                    });   
            });     
        </script>
         <input id="jqxroundPickupLoc" />  