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
  var trndata;
  	  trndata= '<%=DAO.searchNation(session)%>';           
            $(document).ready(function () {
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",    
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'nation', type: 'string'  },
                    ],
                    localdata: trndata,
                };  
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                   
                $("#jqxNationtr").jqxInput({ source: dataAdapter, displayMember: "nation", valueMember: "doc_no", items: 20});
                $("#jqxNationtr").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {      
                                	  document.getElementById("nationidtr").value=dataAdapter.records[i].doc_no;
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>  
         <input id="jqxNationtr" class="form-control input-sm jqxtoursearch" placeHolder="Enter Nation"/>