
 <%@page import="com.operations.agreement.leaseagmtformaster.*" %>
 <%
 ClsLeaseAgmtForMasterDAO viewDAO= new ClsLeaseAgmtForMasterDAO();
 
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String po=request.getParameter("po")==null?"":request.getParameter("po");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%> 

 <script type="text/javascript">
 var id='<%=id%>';
 var searchdata;
 if(id=="1"){
	 searchdata='<%=viewDAO.getMasterRefNoSearchData(cldocno,clientname,date,po,refno,vocno,id)%>';
 }

$(document).ready(function () { 
        
            var source = 
            {
                datatype: "json",
                datafields: [

     					    {name: 'doc_no',type:'number'},
     					    {name: 'voc_no',type:'number'},
     					    {name: 'cldocno',type:'number'},
     					    {name: 'po',type:'string'},
     					    {name: 'refno',type:'string'},
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'date', type: 'date' },
     						{name : 'startdate', type: 'String'  }, 
      						{name : 'enddate', type: 'String' },
      						{name : 'description', type: 'String' }
                          	],
                          	localdata: searchdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#masterrefnoSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
		
					{ text: 'Doc No Original',datafield:'doc_no',width:'10%',hidden:true},
					{ text: 'Doc No',datafield:'voc_no',width:'12%'},
					{ text: 'Date',datafield:'date',width:'15%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Start Date',datafield:'startdate',width:'10%',cellsformat:'dd.MM.yyyy',hidden:true},
					{ text: 'End Date',datafield:'enddate',width:'10%',cellsformat:'dd.MM.yyyy',hidden:true},
					{ text: 'Po',datafield:'po',width:'10%',width:'10%'},
					{ text: 'Ref No',datafield:'refno',width:'10%'},
					{ text: 'Description',datafield:'description',width:'10%',hidden:true},
					{ text: 'Client No', datafield: 'cldocno', width: '12%' },
					{ text: 'Client Name', datafield: 'refname', width: '41%' },
					{ text: 'MOB', datafield: 'per_mob', width: '9%',hidden:true  },
					{ text: 'TEL', datafield: 'per_tel', width: '8%',hidden:true  },
					{ text: 'ADDRESS', datafield: 'address', width: '21%',hidden:true  }, 
					{ text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
					{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true }
	 
					
					]
            });
    
           /*  $("#masterrefnoSearchGrid").jqxGrid('addrow', null, {}); */
      
				            
           $('#masterrefnoSearchGrid').on('rowdoubleclick', function (event) 
           		{ 
              	var rowindex1=event.args.rowindex;
            	var temp="";
            	temp+=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "refname");
            	temp=temp+" Contact Person : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "contactperson");
                temp=temp+","+" MOB : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
                temp=temp+","+" Email : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "mail1");
                temp=temp+","+" ADDRESS : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "address");
                temp=temp+","+" Tel NO : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_tel");
            	/* document.getElementById("clientdetails").value=temp; 
               document.getElementById("cldocno").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
               $('#docno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
               $('#vocno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no"));
               $('#po').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "po"));
               $('#refno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "refno"));
               $('#date').jqxDateTimeInput('val',$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "date"));
               $('#startdate').jqxDateTimeInput('val',$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "startdate"));
               $('#enddate').jqxDateTimeInput('val',$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "enddate"));
               $('#description').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "description")); */
               $('#masterrefno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no"));
               $('#hidmasterrefno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")); 
               $('#masterrefnocldocno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno"));
               //$('#masterleasegriddiv').load('masterLeaseGrid.jsp?id=1&docno='+$('#docno').val());
               getTotalMasterQty($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
               $('#masterrefnowindow').jqxWindow('close');
            		 }); 	 
				           
        
                  }); 
				       
              function getTotalMasterQty(masterdocno){
            		var x=new XMLHttpRequest();
            		x.onreadystatechange=function(){
	            		if (x.readyState==4 && x.status==200)
	            			{
	            				var items=x.responseText;
	            		        $('#totalmasterqty').val(items.trim().split("::")[0]);
	            		        $('#totalagmtqty').val(items.trim().split("::")[1]);
	            		        if(parseInt($('#totalmasterqty').val())==parseInt($('#totalagmtqty').val())){
	            		        	document.getElementById("errormsg").innerText="";
	            		        	document.getElementById("errormsg").innerText="Agreement Limit for Master Lease "+$('#masterrefno').val()+" Exceeded";
	            		        	return false;
	            		        }
	            			}
            		}
	            	x.open("GET","getTotalMasterQty.jsp?masterdocno="+masterdocno,true);
	            	x.send();
            			
            	}  
    </script>
    <div id="masterrefnoSearchGrid"></div>
