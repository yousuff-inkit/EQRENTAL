<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="com.dashboard.salik.*" %>
<%ClsSalikDAO ctd=new ClsSalikDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String flno = request.getParameter("flno")==null?"0":request.getParameter("flno");
 String sregno = request.getParameter("sregno")==null?"0":request.getParameter("sregno");
 String smra = request.getParameter("smra")==null?"0":request.getParameter("smra");
 String brc = request.getParameter("brc")==null?"0":request.getParameter("brc");
 String id = request.getParameter("id")==null?"":request.getParameter("id");
%> 
 <script type="text/javascript">
var id='<%=id%>';
var ragdata;
if(id=="1"){
	ragdata='<%=ctd.ramainSrearch(session,sclname,smob,rno,flno,sregno,smra,brc,id) %>';
}
else{
	ragdata=[];
}        
        $(document).ready(function () { 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                 		
     						{name : 'refname', type: 'String'},
     						{name : 'per_mob', type: 'String'},
     						 {name : 'fleet_no', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						 {name : 'mrano ', type: 'string'}, 
      						{name : 'doc_no', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						
      						{name : 'mrnumber', type: 'String'  },
      						{name : 'gid', type: 'String'  },
      						{name : 'voc_no', type: 'String'  }
      						
      						
                          	],
                          	localdata: ragdata,
                          	       
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
             
               
                //Add row method
     					
     					
                columns: [
							{ text: 'RDOC NO', datafield: 'voc_no', width: '10%' },
							{ text: 'FLEET NO', datafield: 'fleet_no', width: '10%' },
							{ text: 'NAME', datafield: 'refname', width: '28%' }, 
							{ text: 'MOB', datafield: 'per_mob', width: '22%' },
							{ text: 'REG NO', datafield: 'reg_no', width: '15%'},
							{ text: 'MRA', datafield: 'mrnumber', width: '15%'},
							 { text: 'Cldoc', datafield: 'cldocno', width: '15%',hidden:true },
							 { text: 'Gid', datafield: 'gid', width: '15%',hidden:true },
							 { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true }, 
			
					
					
					]
            });
    		$('#jqxmainsearch').on('rowdoubleclick', function (event) 
			{ 
				var rowindex1=event.args.rowindex;
				document.getElementById("typesearch").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname"); 
				document.getElementById("rentaldoc").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				$('#commonwindow1').jqxWindow('close');
			});
		}); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
