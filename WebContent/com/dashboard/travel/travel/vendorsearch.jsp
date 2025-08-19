<%@page import="com.dashboard.travel.travel.ClsTravelDAO"%>
<%
ClsTravelDAO DAO=new ClsTravelDAO();                                            
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>     
 <%
    int tourid=request.getParameter("tourid")=="" || request.getParameter("tourid")==null?0:Integer.parseInt(request.getParameter("tourid").toString());
    String dates=request.getParameter("dates")=="" || request.getParameter("dates")==null?"0":request.getParameter("dates").toString();
 %>     
<style>      
#jqxInput{
	background-color:#fff;    
	height: 20px;
}
</style>
 
  <script type="text/javascript"> 
  var vdata;
  var tid='<%= tourid%>';
  if(tid>0){  
	  vdata= '<%=DAO.searchVendor(session,tourid,dates)%>';   
  }else{
	  vdata= '<%=DAO.searchVendor(session)%>';  
  }
            $(document).ready(function () {
            	 
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",
                    datafields: [
                    			 {name : 'stockid', type: 'string'  },
                    			 {name : 'adultcount', type: 'string'  },
                    			 {name : 'childcount', type: 'string'  },
                    			 {name : 'type', type: 'string'  },                        
                    			 {name : 'cmode', type: 'string'  },
                                 {name : 'rowno', type: 'string'  },
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'name', type: 'string'  },
                                 {name : 'adult', type: 'number'  },
                                 {name : 'spadult', type: 'number'  },
                                 {name : 'child', type: 'number'  },
                                 {name : 'spchild', type: 'number'  },
                                 {name : 'admaxdis', type: 'number'  },
                                 {name : 'chmaxdis', type: 'number'  },     
                    ],
                    localdata: vdata,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                 
                $("#jqxvendor").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: '100%', height: 18,placeHolder:"Enter Vendor"});
                $("#jqxvendor").on('select', function (event) {     
                	  if (event.args) {    
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {                  
                                	  document.getElementById("vndid").value=dataAdapter.records[i].doc_no;
                                	  if($('#tourismconfig').val()!=1){
	                                	  document.getElementById("spchild").value=dataAdapter.records[i].spchild;    
	                                	  document.getElementById("spadult").value=dataAdapter.records[i].spadult;
                                	  }
                                	  if($('#privatetr').val()=="1"){                                                                         
                                		  document.getElementById("tourtotal").value=dataAdapter.records[i].spadult;                                            
                                	  }
                                	  var adultdis=0.00,childdis=0.00,admaxdis=0.00,chmaxdis=0.00,disper=0.00;    
                                	  admaxdis=dataAdapter.records[i].admaxdis;
                                	  chmaxdis=dataAdapter.records[i].chmaxdis;   
                                	  document.getElementById("stockid").value=dataAdapter.records[i].stockid;
                                	  document.getElementById("stocktype").value=dataAdapter.records[i].type;                      
                                	  document.getElementById("adultval").value=dataAdapter.records[i].adult;                     
	                                  document.getElementById("childval").value=dataAdapter.records[i].child;
                                	  document.getElementById("tourdocno").value=dataAdapter.records[i].rowno;
                                	  document.getElementById("cmode").value=dataAdapter.records[i].cmode;
                                	  document.getElementById("admaxdis").value=admaxdis;
                                	  document.getElementById("chmaxdis").value=chmaxdis;        
                                	  if($('#stocktype').val()=="stock"){
                                	       var adultcnt=0,childcnt=0;     
                                	       var stkvndid=dataAdapter.records[i].doc_no;
                                	       var childcount=dataAdapter.records[i].childcount;
                                	       var adultcount=dataAdapter.records[i].adultcount;
	                                	   var rows=$('#tourGrid').jqxGrid('getrows');
										   for(var i=0;i<rows.length;i++){
										       var chk=$('#tourGrid').jqxGrid('getcellvalue',i,'tourid');
											   var vndid=$('#tourGrid').jqxGrid('getcellvalue',i,'vndid');
											   var adult=$('#tourGrid').jqxGrid('getcellvalue',i,'adult');  
											   var child=$('#tourGrid').jqxGrid('getcellvalue',i,'child');
											   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){ 
                                                     if(parseInt(stkvndid)==parseInt(vndid)){  
                                                        adultcnt=adultcnt+parseInt(adult);
                                                        childcnt=childcnt+parseInt(child);            
							                         }        	  
                                	           }
                                	       }
                                	      adultcount=parseInt(adultcount)-adultcnt;
                                	      childcount=parseInt(childcount)-childcnt;
                                	      if(adultcount<0){
                                	         adultcount=0;  
                                	      }
                                	      if(childcount<0){
                                	         childcount=0;    
                                	      }
	                                	  document.getElementById("child").value=childcount;   
	                                	  document.getElementById("adult").value=adultcount;  
	                                	  document.getElementById("stockchild").value=childcount;   
	                                	  document.getElementById("stockadult").value=adultcount;                                                       
                                	  }else{
	                                	  document.getElementById("child").value=0;       
	                                	  document.getElementById("adult").value=0;          
                                	  }   
                                	  document.getElementById("infant").value=0;    
                                	  disper=$('#disper').val(); 
                                	  if(disper==""){
                                		  disper=0.00;          
                                	  }
                                	  document.getElementById("cmbtourdiscounttype").value="DISCOUNT";
                                	  adultdis=(parseFloat(admaxdis)*parseFloat(disper))/100;
                                	  childdis=(parseFloat(chmaxdis)*parseFloat(disper))/100;
                                	  document.getElementById("tourdiscountadult").value=adultdis;  
                                	  document.getElementById("tourdiscountchild").value=childdis; 
                                	  break;                  
                                  }  
                              }
                          }
                      }   
                    }); 
            });   
        </script>
         <input id="jqxvendor" class="p-l-5 input-sm form-control"/>  