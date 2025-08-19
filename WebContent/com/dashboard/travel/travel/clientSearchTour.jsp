<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%
ClsTravelDAO DAO=new ClsTravelDAO();                                            
%>
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
                                 {name : 'nation', type: 'string'  },
                                 {name : 'nationid', type: 'string'  },
                                 {name : 'disper', type: 'string'  },
                                 {name : 'salesman', type: 'string'  },
                                 {name : 'salid', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxClienttr").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20});
                $("#jqxClienttr").on('select', function (event) {        
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {    
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("hidclienttr").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("txtmobtr").value=dataAdapter.records[i].mob;
                                	  document.getElementById("txtemailtr").value=dataAdapter.records[i].mail;    
                                	  document.getElementById("nationidtr").value=dataAdapter.records[i].nationid;
                                	  document.getElementById("jqxNationtr").value=dataAdapter.records[i].nation;
                                	  document.getElementById("disper").value=dataAdapter.records[i].disper;
                                	  if($('#salesmanidtr').val()==''){     
                                	  	document.getElementById("jqxSalesmantr").value=dataAdapter.records[i].salesman;
                                	  	document.getElementById("salesmanidtr").value=dataAdapter.records[i].salid;
                                	  }
                                	  break;       
                                  }                                   
                              }   
                          } 
                      }   
                    });  
            });   
        </script>
         <input id="jqxClienttr" class="form-control input-sm jqxtoursearch" placeHolder="Enter Client"/>