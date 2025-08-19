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
  var cdata;
            $(document).ready(function () {
            	   cdata= '<%=DAO.searchPtype(session)%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'name', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxPackagetype").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20,width: '100%', height: 18,placeHolder: "Enter Package Type"});
                $("#jqxPackagetype").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("hpackageid").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxPackagetype"  class="p-l-5 input-sm form-control"/>