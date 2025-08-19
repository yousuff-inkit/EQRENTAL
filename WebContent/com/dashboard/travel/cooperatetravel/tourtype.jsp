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
  var cdata;
            $(document).ready(function () {  
            	   cdata= '<%=DAO.searchTourtype(session)%>';      
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'name', type: 'string'  },
                                 {name : 'transport', type: 'string'  },  
                                 {name : 'privateval', type: 'string'  },
                    ],
                    localdata: cdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxTourtype").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: '100%', height: 18,placeHolder:"Enter Tour"});
                $("#jqxTourtype").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {   
                                	  document.getElementById("ttypeid").value=dataAdapter.records[i].doc_no;
                                	  document.getElementById("transporttr").value=dataAdapter.records[i].transport;
                                	  document.getElementById("privatetr").value=dataAdapter.records[i].privateval;   
                                	  document.getElementById("child").value=0;  
                                	  document.getElementById("adult").value=0;
                                	  document.getElementById("infant").value=0;
                                	  document.getElementById("spchild").value=0;    
                                	  document.getElementById("spadult").value=0;       
                                	  funload();
                                	  var trnsprt=dataAdapter.records[i].transport;
                                	  if(trnsprt=="1"){
                                		  document.getElementById("cmbtourtransferchoose").value="1";  
                                		  document.getElementById("cmbtourtransferroundtrip").value="1";  
                                		  funChooseTourTransfer(1);
                                		  funChooseTourTransferRound(1);
                                		  $('#cmbtourtransfertype').attr('disabled', true);  
                                		  $('#cmbtourtransfergroup').attr('disabled', true);  
                                		  $('#tourtransferqty').attr('disabled', true); 
                                		   document.getElementById('tourtransferlocrefname').value=$('#cmblocation option:selected').html();  
                                	  }else{
                                		  document.getElementById("cmbtourtransferchoose").value=""; 
                                		  document.getElementById("cmbtourtransferroundtrip").value="";    
                                		  funChooseTourTransfer(0);
                                		  funChooseTourTransferRound(0);
                                		  $('#cmbtourtransfertype').attr('disabled', false);  
                                		  $('#cmbtourtransfergroup').attr('disabled', false);   
                                		   $('#tourtransferqty').attr('disabled', false);                  
                                	  } 
                                	  break;          
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxTourtype" class="p-l-5 input-sm form-control"/>