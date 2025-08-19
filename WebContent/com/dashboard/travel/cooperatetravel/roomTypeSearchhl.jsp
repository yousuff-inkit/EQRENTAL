<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchRoomtype(session) %>';      
		$(document).ready(function () { 	  
            var source =
            {  
                datatype: "json",
                datafields: [
                             {name : 'roomtype', type: 'string'  },
                        ],
                		  
                		//  url: url1,
                 localdata: vdata,
                  
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };  
         
            var dataAdapter = new $.jqx.dataAdapter(source);         
            
            $("#jqxrtype").jqxInput({ source: dataAdapter, displayMember: "roomtype", valueMember: "roomtype", width: 180, height: 14,placeHolder: "Enter Room Type"});
            $("#jqxrtype").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].roomtype) {   
                                  document.getElementById("roomtypeidhl").value=dataAdapter.records[i].roomtype;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
		function checkrtype(){   
			var rtype=document.getElementById("jqxrtype").value;
			if(rtype==""){
				document.getElementById("roomtypeidhl").value="";	
			}
		}
    </script>  
    <input id="jqxrtype" class="p-l-5 input-sm form-control" onblur="checkrtype();"/> 