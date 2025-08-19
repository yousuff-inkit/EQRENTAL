<%@page import="com.dashboard.operations.ClsOperationsDAO" %>
<%ClsOperationsDAO cod=new ClsOperationsDAO(); %>

<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<style type="text/css">
        .salesManClass
        {
            background-color: #FFEBEB;
        }
        .salesAgentClass
        {
            background-color: #FFFFD1;
        }
        .rentalAgentClass
        {
           background-color: #FFFAFA;
        }
         .driverClass
        {
           background-color: #F0FFFF;
        }
         .staffClass
        {
           background-color: #F8E0F7;
        }
         .checkInClass
        {
           background-color: #F7F2E0;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">
	  	var data1;  
	  	var temp='<%=check%>';
	  	
	  	if(temp=='1'){
	  		data1='<%=cod.staffListGridLoading(type)%>';
	  	}
	  	
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#staffList").jqxGrid('exportdata', 'xls', 'StaffList');
    		});*/
        	
        	var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'salcode', type: 'String' },
						{ name: 'sal_name', type: 'String' },
						{ name: 'mobile', type: 'String' },
	                    { name: 'mail', type: 'String' },
	                    { name: 'salestype', type: 'String' },
                    	{name : 'dob', type: 'date' }, 
   						{name : 'nation1', type: 'string' },
   						{name : 'mobno', type: 'string' },
   						{name : 'dlno', type: 'string'  },
   						{name : 'ltype', type: 'string'  },  
   						{name : 'issdate', type: 'date'  },
   						{name : 'issfrm', type: 'string'  },
   						{name : 'led', type: 'date'    },
   						{name : 'passport_no', type: 'string' },
   						{name : 'pass_exp', type: 'date'    },
   						{name : 'visano', type: 'string'    },
   						{name : 'visa_exp', type: 'date'    },
   						{name : 'hiddob', type: 'string' },
 						{name : 'hidpassexp', type: 'string' },
 						{name : 'hidissdate', type: 'string' },
 						{name : 'hidled', type: 'string'    },
 						{name : 'hidvisaexp', type: 'string' },
                        { name: 'sal_type', type: 'String' }
	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.sal_type == 'SLM') {
                    return "salesManClass";
                } else if (data.sal_type == 'SLA') {
                    return "salesAgentClass";
                } else if (data.sal_type == 'RLA') {
                    return "rentalAgentClass";
                } else if (data.sal_type == 'DRV') {
                    return "driverClass";
                } else if (data.sal_type == 'CHK') {
                	 return "checkInClass";
                } else if (data.sal_type == 'STF') {
                    return "staffClass";
                }
                else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            $("#staffList").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Code', datafield: 'salcode', cellclassname: cellclassname, width: '8%' },
						{ text: 'Name', datafield: 'sal_name', cellclassname: cellclassname, width: '30%' },
						{ text: 'Mobile', datafield: 'mobile', cellclassname: cellclassname, width: '10%' },
	                    { text: 'E-Mail', datafield: 'mail', cellclassname: cellclassname, width: '32%' },
	                    { text: 'Sales Type', datafield: 'salestype', cellclassname: cellclassname, width: '20%' },
	                    { text: 'Type', datafield: 'sal_type', hidden: true, width: '10%' },
	                    { text: 'Date of Birth', datafield: 'dob', columntype: 'datetimeinput',cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy', width: '9%' },
					    { text: 'Nationality', datafield: 'nation1',cellclassname: cellclassname, width: '8%',editable:false },
					    { text: 'Mob No', datafield: 'mobno',cellclassname: cellclassname, width: '10%' },
					    { text: 'Licence#', datafield: 'dlno',cellclassname: cellclassname, width: '7%' },
					    { text: 'Lic Type', datafield: 'ltype',cellclassname: cellclassname, width: '8%' },
					    { text: 'Iss From', datafield: 'issfrm',cellclassname: cellclassname, width: '8%' },
					    { text: 'Lic Issued', datafield: 'issdate', columntype: 'datetimeinput',cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '9%' },
					    { text: 'Lic Expiry', datafield: 'led', columntype: 'datetimeinput',cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '9%' },
					    { text: 'Passport#', datafield: 'passport_no',cellclassname: cellclassname, width: '7%' },
					    { text: 'Pass Exp.', datafield: 'pass_exp', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',cellclassname: cellclassname, width: '9%' },
					    { text: 'Visa#', datafield: 'visano',cellclassname: cellclassname, width: '7%' },
					    { text: 'Visa Exp.', datafield: 'visa_exp', columntype: 'datetimeinput',cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy', width: '9%' },
					 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="staffList"></div>
