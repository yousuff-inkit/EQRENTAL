 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 
String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno");
String regno = request.getParameter("regno")==null?"NA":request.getParameter("regno");
String flname = request.getParameter("flname")==null?"NA":request.getParameter("flname");
String color = request.getParameter("color")==null?"NA":request.getParameter("color");
String group = request.getParameter("group")==null?"NA":request.getParameter("group");

String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");

%>


<%@ page import="com.operations.vehicletransactions.maintenanceworkorderepic.ClsmaintWorkorderDAO" %>
<%ClsmaintWorkorderDAO cmwd=new ClsmaintWorkorderDAO(); %>
 
 <script type="text/javascript">


	var mtufleet='<%=cmwd.searchfleet(session,fleetno,regno,flname,color,group,aa) %>';
	
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          
     						{name : 'rfleet', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'color', type: 'String'  },
     						{name : 'gname', type: 'String'  },
     						{name : 'currkm', type: 'String'  },
     						{name : 'serduekm', type: 'String'  },
                          	],
             
                          	localdata: mtufleet,
                
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
            $("#mainupfleetsearch").jqxGrid(
            {
                width: '99.9%',
                height: 346,
                source: dataAdapter,
            
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [
					
					{ text: 'FLEET NO', datafield: 'rfleet', width: '15%' },
					{ text: 'NAME', datafield: 'flname', width: '35%'  },
					{ text: 'Reg NO', datafield: 'reg_no', width: '12%' },
					{ text: 'COLOR', datafield: 'color', width: '13%'  },
					{ text: 'GROUP', datafield: 'gname', width: '25%'},
					{ text: 'currkm', datafield: 'currkm', width: '25%',hidden:true},
					{ text: 'serduekm', datafield: 'serduekm', width: '25%',hidden:true},
					
					]
            });
            
            $('#mainupfleetsearch').on('rowdoubleclick', function (event){ 
            	  var rowBoundIndex = event.args.rowindex;   
            	  document.getElementById("mtfleetno").value= $('#mainupfleetsearch').jqxGrid('getcelltext', rowBoundIndex, "rfleet");
            	  document.getElementById("mtflname").value= $('#mainupfleetsearch').jqxGrid('getcelltext', rowBoundIndex, "flname");
            	  if($("#currkm").val()==""){
            		document.getElementById("currkm").value= $('#mainupfleetsearch').jqxGrid('getcelltext', rowBoundIndex, "currkm");
            	  }
            	  if($("#nextserdue").val()==""){   
            		document.getElementById("nextserdue").value= $('#mainupfleetsearch').jqxGrid('getcelltext', rowBoundIndex, "serduekm");
            	  }
                  var fleet=$('#mainupfleetsearch').jqxGrid('getcelltext', rowBoundIndex, "rfleet");
                    $("#maingrid").load("maintGrid.jsp?fleet="+fleet);
                  $('#fleetsearchwindow').jqxWindow('close');
            	});    
        });
    </script>
    <div id="mainupfleetsearch"></div>