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
  var cdata;
            $(document).ready(function () {
            	   cdata= '<%=DAO.searchRoomtype(session)%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'roomtype', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxRoomtype").jqxInput({ source: dataAdapter, displayMember: "roomtype", valueMember: "doc_no", items: 20 ,width: '100%', height: 18,placeHolder: "Enter Room Type"});
                $("#jqxRoomtype").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("roomtypeid").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxRoomtype"  class="p-l-5 input-sm form-control"/>