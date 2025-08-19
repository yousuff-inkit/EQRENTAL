<%@ page import="com.dashboard.android.rentalreceipt.ClsToRentalReceipt" %>
<%
	String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();

        String fdateval = request.getParameter("fdate1")==null?"0":request.getParameter("fdate1").trim();
         String tdateval = request.getParameter("tdate1")==null?"0":request.getParameter("tdate1").trim();
        


// String RR="RR";
// System.out.println("---------"+descval);
ClsToRentalReceipt cta=new ClsToRentalReceipt();
%> 
		             	  
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">


 var temp4='<%=branchval%>';
var ssss;
var rentalexcel;
var aa;

if(temp4!='NA')
{ 
	//alert("in");
	ssss='<%=cta.searchrentalreceipt(branchval,fdateval,tdateval)%>'; 
	<%-- rentalexcel='<%=cta.excelrentalreceipt(branchval,fdateval,tdateval)%>'; --%>
	//alert(ssss);
aa=0;
	
}
else
{
	
	ssss;
	 aa=1;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						
						{name : 'docno', type: 'string'  },
						{name : 'brno', type: 'string'  },
						{name : 'date1', type: 'string'  },
						{name : 'branch', type: 'string'  },
						{name : 'clientname', type: 'string'  },
						{name : 'mod1', type: 'string'  },
						{name : 'ctype', type: 'string'  },
						{name : 'checkno', type: 'string'  },
						{name : 'checkdate', type: 'string'  },
						{name : 'amount', type: 'string'  },
						{name : 'description', type: 'string'  },
						
						{name : 'cardtype', type: 'string'  },
						{name : 'cldocno', type: 'string'  },
						{name : 'txtdoc', type: 'string'  },
						{name : 'txtacno', type: 'string'  },
						{name : 'type', type: 'string'  }
							],
				    localdata: ssss,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
   
    
    $("#rentalreceiptGrid").jqxGrid(
    {
        width: '98%',
        height: 390,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						
						{ text: 'Doc No.', datafield: 'docno',width: '5%' },
						{ text: 'Date', datafield: 'date1',width: '7%' },
						{ text: 'Branch', datafield: 'branch',width: '10%'   },
						{ text: 'Client Name', datafield: 'clientname', width: '12%'    },
						{ text: 'Type', datafield: 'mod1', width: '11%' },
						{ text: 'Card Type', datafield: 'ctype',width: '11%'},
						{ text: 'Chq/Card No/Online.', datafield: 'checkno',width: '10%'},
						{ text: 'Cheque Date', datafield: 'checkdate',width: '11%'},
						{ text: 'Amount', datafield: 'amount',width: '10%'},
						{ text: 'Description', datafield: 'description', width: '13%' },
						
						{ text: 'crdype', datafield: 'type', width: '11%',hidden:true  },
						{ text: 'Card Type Mode', datafield: 'cardtype',width: '11%',hidden:true },
						{ text: 'Client docno', datafield: 'cldocno',width: '11%',hidden:true },
						{ text: 'Txt Doc', datafield: 'txtdoc',width: '11%',hidden:true },
						{ text: 'Txt Acno', datafield: 'txtacno',width: '11%',hidden:true },
						{ text: 'Branch No', datafield: 'brno',width: '8%',hidden:true },
						
							]
   
    });
    document.getElementById("recdetails").innerText="";
  
	     $('#rentalreceiptGrid').on('rowdoubleclick', function (event) {
         	var rowindex1=event.args.rowindex;
         	
         	 var doc=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "docno");
     	 	$("#detaildiv").load("followDetailgrid.jsp?rdoc="+doc); 
         	
         		document.getElementById("btnUpdate").disabled=false;
         		
			document.getElementById("recdetails").innerText="Doc No: "+$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "docno")+"\n"+"Branch: "+$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "branch")+"\n"+
				  "Client Name: "+$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "clientname")+"";
				
				document.getElementById("doc").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "docno");
				document.getElementById("brno").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "brno");
          		document.getElementById("date1").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "date1");
          		document.getElementById("cname").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "clientname");
          		document.getElementById("type").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "type");
          		document.getElementById("ctype").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "cardtype");
          		document.getElementById("chkno").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "checkno");
          		document.getElementById("chkdate").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "checkdate");
          		document.getElementById("amount").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "amount");
          		document.getElementById("desc").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "description");
          		
          		document.getElementById("cldocno").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
          		document.getElementById("txtdoc").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "txtdoc");
          		document.getElementById("txtacno").value=$('#rentalreceiptGrid').jqxGrid('getcellvalue', rowindex1, "txtacno");
			
          		
	     });
	     //document.getElementById("txttotalvehicles").value=rowscounts;
});

	
	
</script>
<div id="rentalreceiptGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">