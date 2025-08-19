<%@page import="com.dashboard.leaseagreement.lacreateeasy.*" %>
<%
ClsLACreateEasyDAO viewDAO= new ClsLACreateEasyDAO();
String clname = request.getParameter("clname")==null?"":request.getParameter("clname");
String mob = request.getParameter("mob")==null?"":request.getParameter("mob");
String lcno = request.getParameter("lcno")==null?"":request.getParameter("lcno");
String passno = request.getParameter("passno")==null?"":request.getParameter("passno");
String nation = request.getParameter("nation")==null?"":request.getParameter("nation");
String dob = request.getParameter("dob")==null?"":request.getParameter("dob");
String masterrefnocldocno=request.getParameter("masterrefnocldocno")==null?"":request.getParameter("masterrefnocldocno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%> 

 <script type="text/javascript">
var clientdata=[];
var id='<%=id%>';
if(id=="1"){
	clientdata='<%=viewDAO.clientSearch(branch,clname,mob,lcno,passno,nation,dob,masterrefnocldocno,"",id)%>';	
}

        $(document).ready(function () { 

            var source = 
            {
                datatype: "json",
                datafields: [

     					     						
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'acno', type: 'String'  }, 
      						{name : 'codeno', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						{name : 'contactperson', type: 'String'},
     						{name : 'mail1', type: 'String'  },
     						{name : 'per_tel', type: 'String'  },
     						{name : 'dob', type: 'date' },
     						{name : 'dlno', type: 'String'  }, 
      						{name : 'nation', type: 'String' },
      						{name : 'drname', type: 'String' },
      						{name : 'advance', type: 'int' },
      						{name : 'invc_method', type: 'int' },
      						{name : 'method', type: 'int' },
                          	],
                          	localdata: clientdata,
                        
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            $("#jqxclientsearch").on("bindingcomplete", function (event) {$("#overlay, #PleaseWait").hide();}); 
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					
						{ text: 'CLIENT NO', datafield: 'cldocno', width: '7%' },
						{ text: 'NAME', datafield: 'refname', width: '16%' },
						{ text: 'DRIVER NAME', datafield: 'drname', width: '14%' },
		 				{ text: 'DOB', datafield: 'dob', width: '7%', cellsformat: 'dd.MM.yyyy' },
						{ text: 'MOB', datafield: 'per_mob', width: '9%' },
			 			{ text: 'TEL', datafield: 'per_tel', width: '8%' },
						{ text: 'LICENCE', datafield: 'dlno', width: '9%' },
						{ text: 'NATION', datafield: 'nation', width: '9%' },
						{ text: 'ADDRESS', datafield: 'address', width: '21%' }, 
		 				{ text: 'Acno', datafield: 'acno', width: '20%',hidden:true },
		 				{ text: 'Codeno', datafield: 'codeno', width: '20%',hidden:true },
		 				{ text: 'SALESMAN', datafield: 'sal_name', width: '20%',hidden:true },
		 				{ text: 'SAL_ID', datafield: 'doc_no', width: '20%',hidden:true },
		 				{ text: 'contactPerson', datafield: 'contactperson', width: '20%',hidden:true },
		 				{ text: 'mail1', datafield: 'mail1', width: '20%',hidden:true },
		 				{ text: 'advance', datafield: 'advance', width: '20%',hidden:true},
		 				{ text: 'invc_method', datafield: 'invc_method', width: '20%',hidden:true},
		 				{ text: 'method', datafield: 'method', width: '20%',hidden:true},
	 
					
					]
            });
    $('#jqxclientsearch').on('rowdoubleclick', function (event) 
	{ 
		var rowindex1=event.args.rowindex;
		document.getElementById("cldocno").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
		document.getElementById("clientname").value=$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
		$('#clientwindow').jqxWindow('close');
	}); 	 
}); 
</script>
<div id="jqxclientsearch"></div>
