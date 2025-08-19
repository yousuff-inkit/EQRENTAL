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
            	   cdata=  '<%=DAO.searchsupplier(session)%>';     
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
                 
                $("#jqxsupplier").jqxInput({ source: dataAdapter, displayMember: "refname", valueMember: "cldocno", items: 20 }); 
                $("#jqxsupplier").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].cldocno) {   
                                	  document.getElementById("vndid").value=dataAdapter.records[i].cldocno;  
                                	  break;       
                                  }
                              }
                          }
                      }   
                    });    
            });   
        </script>
         <input id="jqxsupplier" placeHolder="Enter Supplier" class="form-control input-sm" value='<s:property value="jqxsupplier"/>'/> 