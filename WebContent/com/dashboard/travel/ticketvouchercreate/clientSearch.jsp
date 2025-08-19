<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.dashboard.travel.ticketvouchercreate.ClsTicketVoucherCreateDAO"%>
<%
		ClsTicketVoucherCreateDAO DAO=new ClsTicketVoucherCreateDAO();                                                                                  
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
            	   cdata=  '<%=DAO.searchclient(session)%>';     
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'cldocno', type: 'string'  },
                                 {name : 'refname', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxclient").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 }); 
                $("#jqxclient").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].cldocno) {   
                                	  document.getElementById("clid").value=dataAdapter.records[i].cldocno;  
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxclient" placeHolder="Enter Customer" class="form-control input-sm" value='<s:property value="jqxclient"/>'/> 