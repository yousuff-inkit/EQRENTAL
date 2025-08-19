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
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxClienttf").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20 ,width: '100%', height: 18,placeHolder: "Enter Client"});
                $("#jqxClienttf").on('select', function (event) {        
                	  if (event.args) {
                          var item = event.args.item;                
                          if (item) {    
                              for (var i = 0; i < dataAdapter.records.length; i++) {      
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("hidclienttf").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("txtmobtf").value=dataAdapter.records[i].mob;
                                	  document.getElementById("txtemailtf").value=dataAdapter.records[i].mail;     
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxClienttf"  class="p-l-5 input-sm form-control"/>