<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
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
            	  var cdata= '<%=DAO.searchAgentclient(session)%>';        
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'user', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxAgentClienttr").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20});
                $("#jqxAgentClienttr").on('select', function (event) {        
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {    
                              for (var i = 0; i < dataAdapter.records.length; i++) {    
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("agentid").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }                                   
                              }   
                          } 
                      }   
                    });  
            });   
        </script>
         <input id="jqxAgentClienttr" class="form-control input-sm jqxtoursearch" placeHolder="Enter Client"/>