
 <%@page import="com.operations.agreement.leaseagmtformasteralmariah.*" %>
 <%
 ClsLeaseAgmtForMasterAlmariahDAO viewDAO= new ClsLeaseAgmtForMasterAlmariahDAO();
 
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
      						{name : 'description', type: 'String' },
      						{name : 'duration', type: 'String' },
      						{name : 'rate', type: 'String' },
      						{name : 'cdw', type: 'String' },
      						{name : 'pai', type: 'String' },
      						{name : 'excesskmrate', type: 'String' },
      						{name : 'duration',type:'number'},
      						{name : 'totalcostpermonth',type:'number'},
      						{name : 'drivercostpermonth',type:'number'},
      						{name : 'securitypass',type:'number'},
      						{name : 'fuel',type:'number'},
      						{name : 'salik',type:'number'},
      						{name : 'safetyacc',type:'number'},
      						{name : 'diw',type:'number'},
      						{name : 'hpd',type:'number'},
      						{name : 'rateperexhr',type:'number'},
      						{name : 'kmrestrict',type:'number'},
      						{name : 'masterrefsrno',type:'number'},
      						{name : 'projectno',type:'number'},
      						{name : 'project_name',type:'string'},
      						
     						{name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
      						{name : 'sal_name', type: 'String'  },
      						{name : 'slmdocno', type: 'String'  },
      						{name : 'advance', type: 'int' },
      						{name : 'invc_method', type: 'int' },
      						{name : 'method', type: 'int' },
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
					{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
					{ text: 'Lease Duration', datafield: 'duration', width: '20%',hidden:true },
					{ text: 'Total Cost per Month', datafield: 'totalcostpermonth', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Driver Cost per Month', datafield: 'drivercostpermonth', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Security Pass', datafield: 'securitypass', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Fuel', datafield: 'fuel', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Salik', datafield: 'salik', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Safety Accessories', datafield: 'safetyacc', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'DIW', datafield: 'diw', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'HPD', datafield: 'hpd', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Rate per Ex.Hr', datafield: 'rateperexhr', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Km Restriction', datafield: 'kmrestrict', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					{ text: 'Master Ref Srno', datafield: 'masterrefsrno', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2' ,hidden:true},
					]
            });
    
           /*  $("#masterrefnoSearchGrid").jqxGrid('addrow', null, {}); */
      
				            
           $('#masterrefnoSearchGrid').on('rowdoubleclick', function (event) 
           		{ 
              	var rowindex1=event.args.rowindex;
              	var temp="";
          	  temp=temp+" Contact Person : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "contactperson");
              temp=temp+","+" MOB : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
              temp=temp+","+" Email : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "mail1");
              temp=temp+","+" ADDRESS : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "address");
              temp=temp+","+" Tel NO : "+$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "per_tel");
             
              
          	 document.getElementById("cusaddress").value=temp; 
          	
             document.getElementById("clientid").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             document.getElementById("clientname").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "refname");
             
             document.getElementById("le_clacno").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "acno");
             document.getElementById("le_clcodeno").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             
             document.getElementById("salesman").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "sal_name");
             document.getElementById("le_salmanid").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "slmdocno");
        
			 document.getElementById("advchkval").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "advance");
             document.getElementById("invval").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "invc_method");
             
             
         //	advance,invc_method
         	 document.getElementById("configmethod").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "method");
     
         	if($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "method")>0)
		           
      	   {
      	   
      	   
             if(parseInt($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "advance"))==1)
	            {
	           	document.getElementById('advance_chk').checked=true;
	           	
	           	document.getElementById('advance_chk').value=1;
	            }
	            else
	            	{
	            	document.getElementById('advance_chk').checked=false;
	            	document.getElementById('advance_chk').value=0;
	            	
	            	}
      	   
      	   
			           if($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "invc_method")==1 || $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "invc_method")==2)
      	           {
	        	            document.getElementById("invoice").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "invc_method");
				           	
				         
				     
				           
				            
				              $('#advance_chk').attr('disabled', false);
			       	           $('#invoice').attr('disabled', false);
			       	           
			       	           
			       	           
      	           }
			           
			           else
			        	   {
			        	   
			        	  
			        	   $('#advance_chk').attr('disabled', false);
		       	           $('#invoice').attr('disabled', false)
			        	   }
			           
			           
		       	          
      	   }
         
         
         else
      	   {
      	   
      	   $('#advance_chk').attr('disabled', false);
 	           $('#invoice').attr('disabled', false);
 	           document.getElementById("configmethod").value=0;
      	   }
         
             $('#delivery_chk').attr('disabled', false);
 	           $('#radrivercheck').attr('disabled', false);
 	          
 	            $("table#tariffsub input").prop("disabled", false); 
         
            document.getElementById("errormsg").innerText="";
            
            $("#jqxgrid2").jqxGrid('clear');
		      $("#jqxgrid2").jqxGrid('addrow', null, {});
		      $("#jqxgrid2").jqxGrid('addrow', null, {});
            if(document.getElementById('ladrivercheck').checked==true) {
          
          	
			      $("#jqxgrid2").jqxGrid({ disabled: true});   
            }
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
               var duration=parseInt($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "duration"));
               $('#per_name').val("1");
               $('#per_value').val(duration/12);
               $('#masterrefno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "voc_no"));
               $('#hidmasterrefno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")); 
               $('#hidmasterrefsrno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "masterrefsrno")); 
               $('#masterrefnocldocno').val($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cldocno"));
               //$('#masterleasegriddiv').load('masterLeaseGrid.jsp?id=1&docno='+$('#docno').val());
               
                $("#rateGrid").jqxGrid('setcellvalue', 0, "rate", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "rate"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "cdw", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "cdw"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "pai", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "pai"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "kmrest", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "kmrestrict"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "exkmrte", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "excesskmrate"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "totalcostpermonth", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "totalcostpermonth"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "drivercostpermonth", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "drivercostpermonth"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "securitypass", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "securitypass"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "fuel", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "fuel"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "salik", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "salik"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "safetyacc", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "safetyacc"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "diw", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "diw"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "hpd", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "hpd"));
                $("#rateGrid").jqxGrid('setcellvalue', 0, "rateperexhr", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "rateperexhr"));
				$("#rateGrid").jqxGrid('setcellvalue', 0, "chaufchg", $('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "drivercostpermonth"));
				
				document.getElementById("leaseproject").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "project_name");
				document.getElementById("leaseprojectDoc").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "projectno");
				document.getElementById("leasePo").value=$('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "po");
                //alert($('#masterrefnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "rate"));
                
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
	            		        
	            		        //alert($('#totalmasterqty').val() +" = "+$('#totalagmtqty').val());
	            		        
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
