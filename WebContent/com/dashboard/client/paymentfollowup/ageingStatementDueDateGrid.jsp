<%@page import="com.dashboard.client.paymentfollowup.ClsPaymentFollowUpDAO"%>
<%ClsPaymentFollowUpDAO DAO= new ClsPaymentFollowUpDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	 String clientaccount = request.getParameter("clientaccount")==null?"0":request.getParameter("clientaccount").trim();
     String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String amtrangefrm = request.getParameter("amtrangefrm")==null?"0":request.getParameter("amtrangefrm").trim();
     String amtrangeto = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String clientstatus = request.getParameter("clientstatus")==null?"0":request.getParameter("clientstatus").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>  
     
<style type="text/css">
  .duebalanceClass
  {
      background-color: #ABEAF5;
  }

  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var l1=''+0+' - '+30+'';
      var l2=''+31+' - '+60+'';
      var l3=''+61+' - '+90+'';
      var l4=''+91+' - '+120+'';
      var l5='>='+121+'';  
      
	  	if(temp!='NA'){   
	  		   data='<%=DAO.ageingStatement(branchval, uptodate, clientaccount, chkfollowup, followupdate, salesperson, category, amtrangefrm, amtrangeto, clientstatus,check)%>';
	  	}  
  	
        $(document).ready(function () {
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name' , type: 'String' },
							{name : 'contact' , type:'String'},
							{name : 'pmob' , type:'String'},
							{name : 'duebalance' , type:'number'},
							{name : 'advance' , type:'number'},
							{name : 'balance' , type:'number'},
							{name : 'unapplied',type:'number'},
							{name : 'netamount' , type:'number'},
							{name : 'level0' , type:'number'},
							{name : 'level1' , type:'number'},
							{name : 'level2' , type:'number'},
							{name : 'level3' , type:'number'},
							{name : 'level4' , type:'number'},
							{name : 'level5' , type:'number'},
							{name : 'acno' , type:'int'},
							{name : 'brhid' , type:'int'},
							{name : 'cldocno' , type:'int'},
							{name : 'email' , type:'String'},
							{name : 'doc_no' , type:'int'},
							{name : 'currency' , type:'String'},
							
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#ageingStatementDueDate").jqxGrid(
            {
            	width: '98%',
                height: 400,  
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                //localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Account Name', datafield: 'name', width: '13%' },
							{ text: 'Currency', datafield: 'currency', width: '5%' },
							{ text: 'Contact Person',  datafield: 'contact',  width: '12%' },
							{ text: 'Mobile No',  datafield: 'pmob',  width: '7%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Due Balance', datafield:'duebalance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'duebalanceClass' },
							{ text: 'Advance', datafield:'advance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield:'balance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Total',  datafield: 'netamount',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: '<0',  datafield: 'level0',  width: '5%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: l1,  datafield: 'level1',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: l2,  datafield: 'level2',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l3,  datafield: 'level3',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l4,  datafield: 'level4',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: l5,  datafield: 'level5',  width: '7%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
							{ text: 'Email',  datafield: 'email', hidden: true, width: '8%'  },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '8%'  },
							{ text: 'Cldocno',  datafield: 'cldocno', hidden: true, width: '8%'  },
						 ]
            });
            
            if(temp=='NA'){
                $("#ageingStatementDueDate").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#ageingStatementDueDate').on('rowdoubleclick', function (event) { 
            	  var rowindex1 = event.args.rowindex;
            	  
            	  $('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');$('#txtbranch').val('');$('#txtacountno').val('');$('#txtdocno').val('');
      			  $('#txttranid').val('');
              	  
                  $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                  $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
            	  
                  document.getElementById("txtacountno").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "acno"); 
              	  document.getElementById("txtdocno").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "doc_no");
              	  document.getElementById("txtbranch").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "brhid");
              	  document.getElementById("txtcldocno").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "cldocno");
              	  document.getElementById("txtmobno").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "pmob");
              	  document.getElementById("txtclientaccountemail").value=$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, "email");
              	
                  $("#detailDiv").load("detailGrid.jsp?cldocno="+$('#ageingStatementDueDate').jqxGrid('getcellvalue', rowindex1, 'cldocno')+'&check=1');
               }); 

        });

</script>
<div id="ageingStatementDueDate"></div>
