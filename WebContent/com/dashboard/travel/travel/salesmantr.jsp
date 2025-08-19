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
  var ndata;
  	  ndata= '<%=DAO.searchSalesman()%>';           
            $(document).ready(function () {
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",    
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'sal_name', type: 'string'  },
                    ],
                    localdata: ndata,
                };  
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                   
                $("#jqxSalesmantr").jqxInput({ source: dataAdapter, displayMember: "sal_name", valueMember: "doc_no", items: 20});
                $("#jqxSalesmantr").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {      
                                	  document.getElementById("salesmanidtr").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }  
                              }
                          }
                      }   
                    });   
            });     
        </script>
         <input id="jqxSalesmantr" class="form-control input-sm jqxtoursearch" placeHolder="Enter Salesman"/>  