<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.Sales.deliverynote.ClsDeliveryNoteDAO"%>
<%ClsDeliveryNoteDAO DAO= new ClsDeliveryNoteDAO();%>
<%-- <%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<% ClsgoodsreceiptnoteDAO searchDAO = new ClsgoodsreceiptnoteDAO(); %> --%>   
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
String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
String griddepartment = request.getParameter("griddepartment")==null?"0":request.getParameter("griddepartment");
%>
 
<style>
#jqxInput1{
	background-color:#fff;
}
</style>
 
  <script type="text/javascript">
  
 
            $(document).ready(function () {
                
            	 var dd2=  '<%=DAO.searchProduct(session,"0","0",location,"0",dates,productname,brandname,gridunit,gridprdname,gridcategory,gridssubcategory,griddepartment,"1")%>';
            	 
            	 
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
                                 {name : 'costprice', type: 'string'  },
                                 {name : 'brandname', type: 'string'  },    
                                 {name : 'taxper', type: 'number'  },
                                 {name : 'balqty', type: 'number'  },
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
                               $("#totalstock").val(dataAdapter.records[i].balqty);
                          /*           funRoundAmt(dataAdapter.records[i].taxper,"taxpers");
                                    funRoundAmt(dataAdapter.records[i].unitprice,"uprice"); */
                                    document.getElementById("hidpsrno").value=dataAdapter.records[i].psrno;
                                    getSaleDet();
                                    document.getElementById("stockmsg").innerText="Qty:"+dataAdapter.records[i].balqty+" "+"CP:"+dataAdapter.records[i].costprice;
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
         