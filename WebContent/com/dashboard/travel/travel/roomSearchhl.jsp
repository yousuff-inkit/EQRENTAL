 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
 <%  ClsTravelDAO DAO=new ClsTravelDAO(); %>
       <script type="text/javascript">
       var rrdata;
       rrdata= '<%=DAO.searchRoom() %>';    
		$(document).ready(function () { 	  
            var source =
            {  
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                        ],
                		  
                		//  url: url1,
                 localdata: rrdata,
                  
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };  
         
            var dataAdapter = new $.jqx.dataAdapter(source);      
            
            $("#jqxroomname").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "name", width: 180, height: 14,placeHolder: "Enter Room Type"});
            $("#jqxroomname").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].name) {   
                                  document.getElementById("roomidhl").value=dataAdapter.records[i].name;
                                  break;   
                              }   
                          }
                      }
                  }      
                });        
                  }); 
		function checkroom(){   
			var room=document.getElementById("jqxroomname").value;
			if(room==""){
				document.getElementById("roomidhl").value="";	     
			}
		}
    </script>  
    <input id="jqxroomname" class="p-l-5 input-sm form-control" onblur="checkroom();"/> 