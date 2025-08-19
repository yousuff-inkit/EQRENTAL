<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%  ClsTravelDAO sd=new ClsTravelDAO(); %>
 <script type="text/javascript">
    var data= '<%= sd.accsearch_ap() %>';
    $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },  
     						{name : 'description', type: 'String'  },
     						{name : 'acno',type:'string'}
                 ],
                 localdata: data, 
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);   
            // Create a jqxInput  
             
            $("#jqxsalesagent").jqxInput({ source: dataAdapter, displayMember: "description", valueMember: "doc_no", items: 20 ,width: 450, height: 20});
            $("#jqxsalesagent").on('select', function (event) {        
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {    
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].doc_no) {       
                            	  document.getElementById("salesagentacno").value=dataAdapter.records[i].acno;
                            	  document.getElementById("salesagentdocno").value=dataAdapter.records[i].doc_no;     
                            	  break;       
                              }  
                          }
                      }
                  }   
                }); 
        });   
    </script>
     <input id="jqxsalesagent" />