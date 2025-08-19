<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%
ClsTravelDAO DAO=new ClsTravelDAO();                                            
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
<script type="text/javascript"> 
            $(document).ready(function () {
            	  var pckdata= '<%=DAO.getSearchData()%>';            

            	  var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'location', type: 'string'  },
                    ],     
                    localdata: pckdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);  
                // Create a jqxInput  
                 
                $("#jqxPickupLoc").jqxInput({ source: dataAdapter, displayMember: "location", valueMember: "doc_no", items: 20 ,width: 166, height: 20,placeHolder:"Enter Pickup Location"});
                $("#jqxPickupLoc").on('select', function (event) {          
                	  if (event.args) {  
                          var item = event.args.item;                 
                          if (item) {
                              for (var i = 0; i < dataAdapter.records.length; i++) {     
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("pickuplocid").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("pickuploc").value=dataAdapter.records[i].location;
                                	  getTariffData();getReturnTariffData();
                                	  var trnsprt=document.getElementById("transporttr").value;
                                	  if(trnsprt=="1"){
                                			 document.getElementById("rounddropofflocid").value=$('#pickuplocid').val();
                                			 document.getElementById("jqxroundDropoffLoc").value=$('#pickuploc').val();
                                	  }     
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });     
        </script>
         <input id="jqxPickupLoc" class="p-l-5 input-sm form-control"/>  