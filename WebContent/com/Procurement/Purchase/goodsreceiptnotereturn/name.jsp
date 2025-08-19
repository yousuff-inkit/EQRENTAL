<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.procurement.purchase.goodsreceiptnotereturn.ClsgoodsreceiptnotereturnDAO "%>
<% ClsgoodsreceiptnotereturnDAO searchDAO = new ClsgoodsreceiptnotereturnDAO(); %>
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
 
String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();


String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String brandids=request.getParameter("brandids")==null?"0":request.getParameter("brandids").trim();
String conf=request.getParameter("psconf")==null?"0":request.getParameter("psconf").trim();
%>
 
<style>
#jqxInput1{
	background-color:#fff;
}
</style>
 
  <script type="text/javascript">
  var dtype='<%=reftypes%>'; 
	 var dd2;
	  if(dtype=='GRN')
	       
	   {
	   
		  dd2 = '<%=searchDAO.searchorderProduct(rrefno,session,conf)%>';   
	   
	   }
  else
	   {
	   
	  dd2= '<%=searchDAO.searchProduct(session,conf)%>';
	   }
            $(document).ready(function () {
            	
            	 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'part_no', type: 'string'  },
                                 {name : 'productname', type: 'string'  },
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'unit', type: 'string'  },
                                 {name : 'unitdocno', type: 'string'  },
                                 {name : 'psrno', type: 'string'  },
                                 {name : 'specid', type: 'string'  },
                                  
                                 {name : 'unitprice', type: 'string'  },
                               
                              
                                 
                                 {name : 'brandname', type: 'string'  },    
                                 {name : 'taxper', type: 'number'  },
                    ],
                    localdata: dd2,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput1").jqxInput({ source: dataAdapter, displayMember: "productname", valueMember: "psrno", width: 260, height: 20});
                
                $("#jqxInput1").on('select', function (event) {
              	  if (event.args) {
                        var item = event.args.item;
                        if (item) {
                            for (var i = 0; i < dataAdapter.records.length; i++) {
                                if (item.value == dataAdapter.records[i].psrno) {
                                    document.getElementById("jqxInput").value=dataAdapter.records[i].part_no;
                                    document.getElementById("temppsrno").value=dataAdapter.records[i].psrno;
                                    document.getElementById("tempspecid").value=dataAdapter.records[i].specid;
                                    getunit(dataAdapter.records[i].psrno);
                                    
                                    
                                    document.getElementById("unit").value=dataAdapter.records[i].unitdocno;
                                
                                    
                                    document.getElementById("brand").value=dataAdapter.records[i].brandname; 
                          /*           funRoundAmt(dataAdapter.records[i].taxper,"taxpers");
                                    funRoundAmt(dataAdapter.records[i].unitprice,"uprice"); */
                                    document.getElementById("quantity").focus();
                                    break;
                                }
                            }
                            

                             
                        }
                    }
                  }); 
            });
        </script>
        <input id="jqxInput1" />
        <br />
         