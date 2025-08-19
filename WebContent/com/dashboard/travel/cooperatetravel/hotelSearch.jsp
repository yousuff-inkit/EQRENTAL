<%@page import="com.dashboard.travel.cooperatetravel.ClsCooperateTravelDAO"%>
<% ClsCooperateTravelDAO DAO=new ClsCooperateTravelDAO(); %>
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}
</style>
       <script type="text/javascript">
       var hdata;
       hdata= '<%=DAO.searchHotel() %>';      
		$(document).ready(function () { 	   
            var source =
            {
                datatype: "json",   
                datafields: [
                             {name : 'name', type: 'string'  },
                             {name : 'doc_no', type: 'string'  },
                        ],
                		
                		//  url: url1,
                 localdata: hdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxhotel").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no",width: '100%', height: 14,placeHolder: "Enter Hotel"});
            $("#jqxhotel").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;           
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {   
                              if (item.value == dataAdapter.records[i].doc_no) {   
                                  document.getElementById("hotelidhl").value=dataAdapter.records[i].doc_no;
                                  break;   
                              }   
                          }
                      }
                  }      
                }); 
                  }); 
		function checkhotel(){   
			var hotel=document.getElementById("jqxhotel").value;
			if(hotel==""){
				document.getElementById("hotelidhl").value="";	        
			}
		}
    </script>  
    <input id="jqxhotel" class="p-l-5 input-sm form-control" onblur="checkhotel();"/> 