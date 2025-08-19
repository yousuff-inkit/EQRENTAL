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
                 
                $("#jqxClienthl").jqxInput({ source: dataAdapter, displayMember: "user", valueMember: "doc_no", items: 20 ,width: '100%', height: 14,placeHolder:"Enter Client"});
                $("#jqxClienthl").on('select', function (event) {        
                	  if (event.args) {
                          var item = event.args.item;                
                          if (item) {    
                              for (var i = 0; i < dataAdapter.records.length; i++) {   
                                  if (item.value == dataAdapter.records[i].doc_no) {       
                                	  document.getElementById("hidclienthl").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("txtmobhl").value=dataAdapter.records[i].mob;
                                	  document.getElementById("txtemailhl").value=dataAdapter.records[i].mail;     
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
            function checkclient(){   
    			var nation=document.getElementById("jqxClienthl").value;
    			if(nation==""){
    				  document.getElementById("hidclienthl").value="";
                	  document.getElementById("txtmobhl").value="";    
                	  document.getElementById("txtemailhl").value="";          	        
    			}
    		}
        </script>
         <input id="jqxClienthl"  class="p-l-5 input-sm form-control" onblur="checkclient();"/>