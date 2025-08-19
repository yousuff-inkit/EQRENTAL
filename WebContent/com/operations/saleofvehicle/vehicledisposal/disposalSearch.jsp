<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.operations.saleofvehicle.vehicledisposal.ClsVehicleDisposalDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date=request.getParameter("date")==null?"":request.getParameter("date");
 String client=request.getParameter("client")==null?"0":request.getParameter("client");
 String cmbtype = request.getParameter("type")==null?"":request.getParameter("type");
 String acno = request.getParameter("acno")==null?"0":request.getParameter("acno");
 String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
 ClsVehicleDisposalDAO disposaldao=new ClsVehicleDisposalDAO();
%> 
 <script type="text/javascript">
 var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';
  var subsearchdata=[];
if(temp=="1"){
	subsearchdata='<%=disposaldao.getSearchData(docno,date,client,cmbtype,acno,mobile,branch)%>';	
}
else{
	subsearchdata=[];
}

        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'String' },
                          	{name : 'voc_no' , type: 'String' },
     						{name : 'date', type: 'date'  },
     						{name : 'acno', type: 'String'  },
     						{name : 'type', type: 'String'  },
     						{name : 'description', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'trno', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						{name :'address',type:'string'},
     						{name :'per_mob',type:'string'},
     						{name :'mail1',type:'string'},
     						{name :'brhid',type:'string'},
     						{name :'typename',type:'string'}
                 ],
                localdata: subsearchdata,
                //url: url,
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
            $("#disposalSearch").jqxGrid(
            {
                width: '98%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [

							{ text: 'Original Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Ac No', datafield: 'acno', width: '12%'},
							{ text: 'Type', datafield: 'type', width: '16.66%',hidden:true},
							{ text: 'Description', datafield: 'description', width: '80%',hidden:true},
							{ text: 'Client', datafield: 'refname', width: '32.64%'},
							{ text: 'TrNo', datafield: 'trno', width: '80%',hidden:true},
							{ text: 'Client Id', datafield: 'cldocno', width: '80%',hidden:true},
							{ text: 'Address',datafield:'address',width:'10%',hidden:true},
							{ text: 'Mobile',datafield:'per_mob',width:'16.66%'},
							{ text: 'Mail',datafield:'mail1',width:'10%',hidden:true},
							{ text: 'Branch',datafield:'brhid',width:'10%',hidden:true},
							{ text: 'Type',datafield:'typename', width: '16.66%'},
							]
            });
           
           $('#disposalSearch').on('rowdoubleclick', function (event) {
        	   var row2=event.args.rowindex;
        		 $('#date').jqxDateTimeInput({ disabled: false}); 
        			$('#frmVehicleDisposal select').attr('disabled', false );
        			
           	document.getElementById("docno").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "doc_no");
           	document.getElementById("vocno").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "voc_no");
           	document.getElementById("trno").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "trno");
            $("#date").jqxDateTimeInput('val',$("#disposalSearch").jqxGrid('getcellvalue', row2, "date"));
            $('#cmbtype').val($("#disposalSearch").jqxGrid('getcellvalue', row2, "type")) ;
            document.getElementById("clientacno").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "acno");
            var temp="";
            temp=$('#disposalSearch').jqxGrid('getcellvalue', row2, "refname");
            temp=temp+",Address :"+$('#disposalSearch').jqxGrid('getcellvalue', row2, "address");
            temp=temp+",Mobile :"+$('#disposalSearch').jqxGrid('getcellvalue', row2, "per_mob");
            temp=temp+",Mail :"+$('#disposalSearch').jqxGrid('getcellvalue', row2, "mail1");
            document.getElementById("clientname").value=temp;
            document.getElementById("client").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "cldocno");
            document.getElementById("description").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "description");
            $('#date').jqxDateTimeInput({ disabled: true}); 
			$('#frmVehicleDisposal select').attr('disabled', true );
			document.getElementById("hidbranch").value=$('#disposalSearch').jqxGrid('getcellvalue', row2, "brhid");
			$('#disposaldiv').load('vehDisposalGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("brchName").value+'&id=1');
			$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("trno").value+'&id=1');
			$('#window').jqxWindow('close');
            }); 
        
        });
    </script>
    <div id="disposalSearch"></div>