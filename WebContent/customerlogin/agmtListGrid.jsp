<%@ page import="customerlogin.*"  %>
 <%

   String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String acno= request.getParameter("acno")==null?"NA":request.getParameter("acno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String group = request.getParameter("group")==null?"NA":request.getParameter("group").trim();
  	String brand = request.getParameter("brand")==null?"NA":request.getParameter("brand").trim();
  	String model = request.getParameter("model")==null?"NA":request.getParameter("model").trim();

  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	String id= request.getParameter("id")==null?"0":request.getParameter("id").trim();
  	
 	String catid = request.getParameter("catid")==null?"NA":request.getParameter("catid").trim(); 
 	String chkbetweendates = request.getParameter("chkbetweendates")==null?"":request.getParameter("chkbetweendates").trim();  
 	ClsCustomerLoginDAO cad=new ClsCustomerLoginDAO();
  	
 %> 
 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
       
    .whiteClass
    {
        background-color: #FFF;
    }
    
</style>
 
 
 <script type="text/javascript">
 
var id='<%=id%>';
var agmtlistdata=[];
if(id=='1')
{ 
	agmtlistdata='<%=cad.detailsgrid(branch,fromdate,todate,acno,status,fleet,group,brand,model,type,outchk,inchk,catid,id,chkbetweendates)%>';

}
$(document).ready(function () { 
	var source = 
    {
    	datatype: "json",
        	datafields: [
				{name : 'doc', type: 'String'  },   //this is the agreement
     			{name : 'refname', type: 'String'},
				{name : 'fleet_no', type: 'String'}, 
     			{name : 'vehdetails', type: 'String'}, 
     			{name : 'cldocno', type: 'String'  },
     			{name : 'odate', type: 'date'  },
     			{name : 'otime', type: 'String'  },
								
				{name : 'ddate', type: 'date'  },
				{name : 'dtime', type: 'String'  },
				{name : 'rentaltype', type: 'String'  },
				{name : 'per_mob', type: 'String'  },
				{name : 'contactperson', type: 'String'  },
				{name : 'brhid', type: 'string'  },
				
				{name : 'reg_no', type: 'string'  },
				{name : 'ofno', type: 'string'  },
				{name : 'oreg_no', type: 'string'  },
				{name : 'drname', type: 'String'  },
				{name : 'mrno', type: 'String'  },
				{name : 'rent', type: 'number'  },
				{name : 'cdw', type: 'number'  },
				{name : 'refnos', type: 'string'  },
				
				{name : 'indate', type: 'date'  },
				{name : 'intime', type: 'String'  },
				
				{name : 'invdate', type: 'date'  },
				{name : 'invrental', type: 'number'  },
				{name : 'invcdw', type: 'number'  },
				{name : 'project',type:'string'},
				{name : 'originalfleet',type:'string'},
				{name : 'originalchase',type:'String'},
				{name : 'replacefleet',type:'String'},
				{name : 'replacechase',type:'String'} ,
				{name : 'sal_name', type: 'string'  },
				{name : 'brch', type: 'string'  },
				{name : 'crdp', type: 'string'  },
				{name : 'invr', type: 'string'  },
				{name : 'yom', type: 'string'  },
				{name : 'rltype', type: 'string'  },
				{name : 'locname', type: 'string'  },
				{name : 'pai', type: 'number'  },
				{name : 'user_name', type: 'string'  },
				{name : 'closeuser', type: 'string'  },
				{name : 'cur_km', type: 'number'  },
				{name : 'authority',type:'string'},
				{name : 'platecode',type:'string'},
				{name : 'contractauthority',type:'string'},
				{name : 'contractplatecode',type:'string'},
				{name : 'agmtdate',type:'date'},
				{name : 'rtaremarks',type:'string'},
				{name : 'branchcode',type:'string'},
			],
            localdata:agmtlistdata,
            pager: function (pagenum, pagesize, oldpagenum) {
                   
            }
		};
        var cellclassname = function (row, column, value, data) {
        	if (data.rltype == 'Rent') {
            	return "redClass";
			} 
            else {
            	return "whiteClass";
        	}
		};
            
        var dataAdapter = new $.jqx.dataAdapter(source,
        {
        	loadError: function (xhr, status, error) {
	        	alert(error);    
	        }
		});
        
        $("#detailsgrid").jqxGrid(
        {
	    	width: '100%',
	        height: 400,
	        source: dataAdapter,
	        showaggregates:true,
	        enableAnimations: true,
	        filtermode:'excel',
	        filterable: true,
	        sortable:true,
	        selectionmode: 'singlerow',
	        pagermode: 'default',
	        editable:false,
	        columns: [
				{ text: 'SL#', sortable: false, filterable: false, editable: false,   
					groupable: false, draggable: false, resizable: false,
					datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
					cellsrenderer: function (row, column, value) {
						return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}  
				},
				{ text: 'RA NO', datafield: 'doc', width: '6%' ,cellclassname: cellclassname },   //voc no
				{ text: 'Branch Code', datafield: 'branchcode', width: '10%',cellclassname: cellclassname},
				{ text: 'Date', datafield: 'agmtdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
				{ text: 'Fleet', datafield: 'fleet_no', width: '6%',cellclassname: cellclassname },
				{ text: 'Fleet Name', datafield: 'vehdetails', width: '13%',cellclassname: cellclassname },
				{ text: 'Reg NO', datafield: 'reg_no', width: '8%',cellclassname: cellclassname },
				{ text: 'Authority', datafield: 'authority', width: '8%',cellclassname: cellclassname },
				{ text: 'Plate Code', datafield: 'platecode', width: '8%',cellclassname: cellclassname },
				{ text: 'Contract Fleet', datafield: 'ofno', width: '8%',cellclassname: cellclassname },
				{ text: 'Contract Reg No', datafield: 'oreg_no', width: '8%',cellclassname: cellclassname },
				{ text: 'Authority', datafield: 'contractauthority', width: '8%',cellclassname: cellclassname },
				{ text: 'Plate Code', datafield: 'contractplatecode', width: '8%',cellclassname: cellclassname },
				{ text: 'Current User', datafield: 'drname', width: '10%',cellclassname: cellclassname},
				{ text: 'Mob NO', datafield: 'per_mob', width: '10%',cellclassname: cellclassname},
				{ text: 'Rental Type', datafield: 'rentaltype', width: '7%' ,cellclassname: cellclassname},
				{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
				{ text: 'Out Time', datafield: 'otime', width: '5%' ,cellclassname: cellclassname}, 
				{ text: 'Due Date', datafield: 'ddate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
				{ text: 'DueTime', datafield: 'dtime', width: '5%',cellclassname: cellclassname },
				{ text: 'Manual RA', datafield: 'mrno', width: '6%',cellclassname: cellclassname},
				{ text: 'Rent', datafield: 'rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
				{ text: 'CDW', datafield: 'cdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
				{ text: 'PAI', datafield: 'pai', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname},
				{ text: 'Project', datafield: 'project', width: '12%',cellclassname: cellclassname},
				{ text: 'Original Engine No.',datafield:'originalfleet',width:'10%',cellclassname: cellclassname},
				{ text: 'Original Chassis',datafield:'originalchase',width:'10%',cellclassname: cellclassname},
				{ text: 'Branch Name', datafield: 'brch', width: '10%',cellclassname: cellclassname,hidden:true },
				
				{ text: 'Location', datafield: 'locname', width: '10%',cellclassname: cellclassname,hidden:true },
				
				
				
				
				
				{ text: 'Client #', datafield: 'cldocno', width: '6%',cellclassname: cellclassname ,hidden:true},
				{ text: 'Client Name', datafield: 'refname', width: '18%',cellclassname: cellclassname ,hidden:true},
				{ text: 'Contact Person', datafield: 'contactperson', width: '12%',cellclassname: cellclassname,hidden:true},
				
				
				
				{ text: 'Ref No', datafield: 'refnos', width: '6%',hidden:true,cellclassname: cellclassname,hidden:true},
				
				{ text: 'In Date', datafield: 'indate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname,hidden:true},
					
				{ text: 'In Time', datafield: 'intime', width: '5%',cellclassname: cellclassname ,hidden:true},
				
				{ text: 'Inv Date', datafield: 'invdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname,hidden:true},
				{ text: 'Inv Rent', datafield: 'invrental', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname,hidden:true},
				{ text: 'Inv CDW', datafield: 'invcdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right',cellclassname: cellclassname,hidden:true},		
				
				{ text: 'Replaced Fleet',datafield:'replacefleet',width:'8%',cellclassname: cellclassname,hidden:true},
				{ text: 'Replaced Chassis',datafield:'replacechase',width:'10%',cellclassname: cellclassname,hidden:true},
				{ text: 'RTA Remarks', datafield: 'rtaremarks', width: '10%',cellclassname: cellclassname,hidden:true},
				
				{ text: 'Open User', datafield: 'user_name', width: '15%',cellclassname: cellclassname,hidden:true},
				{ text: 'Close User', datafield: 'closeuser', width: '12%',cellclassname: cellclassname,hidden:true},
				{ text: 'Salesman', datafield: 'sal_name', width: '15%',cellclassname: cellclassname,hidden:true},
				{ text: 'Credit Period', datafield: 'crdp', width: '8%',cellclassname: cellclassname ,hidden:true},
				{ text: 'Inv Rule', datafield: 'invr', width: '8%',cellclassname: cellclassname ,hidden:true},
				{ text: 'YOM', datafield: 'yom', width: '8%' ,cellclassname: cellclassname,hidden:true},
				{ text: 'Mileage', datafield: 'cur_km', width: '8%' ,cellclassname: cellclassname,hidden:true},
				{ text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
				{ text: 'RL Type', datafield: 'rltype', width: '10%',hidden:true },
			]
		});
        $(".page-loader").hide(); 
	});
</script>
<div id="detailsgrid"></div>