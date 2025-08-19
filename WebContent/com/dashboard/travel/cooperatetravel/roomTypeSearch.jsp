 <%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
       <script type="text/javascript">
       var vdata;
       vdata= '<%=DAO.searchRoom() %>';    
		$(document).ready(function () { 	  
            var source =
            {  
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: vdata,
                  
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);      
            
            $("#jqxrtype").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", width: 180, height: 14,placeHolder: "Enter Room Type"});
            $("#jqxrtype").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("roomid").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
    </script>  
    <input id="jqxrtype" class="p-l-5 input-sm form-control"/> 