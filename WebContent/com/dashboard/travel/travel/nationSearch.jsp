 <%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
 <%  ClsTravelDAO DAO=new ClsTravelDAO(); %>
       <script type="text/javascript">
       var ndata;
       ndata= '<%=DAO.searchNation() %>';        
		$(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: ndata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            }; 
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxnation").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", width: 190, height:14,placeHolder: "Enter Nationality"});
            $("#jqxnation").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("nationidhl").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
		function checnation(){   
			var nation=document.getElementById("jqxnation").value;
			if(nation==""){
				document.getElementById("nationidhl").value="";	        
			}
		}
    </script>  
    <input id="jqxnation" class="p-l-5 input-sm form-control" onblur="checnation();"/> 