 <%@ page import="com.dashboard.android.user_editprofile.ClsProfileEditDAO" %>
<% ClsProfileEditDAO cped=new ClsProfileEditDAO(); %>
 
 <%
 	String idd=request.getParameter("id");
 %>
 
 
<style type="text/css">

  .yellowClass
     {
        background-color: #A4A4A4; 
     }
</style>

<script type="text/javascript">

var id='<%=idd%>';
var ssss;
if(id=="1")
{
	ssss='<%=cped.registerUser()%>';
}

 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		/* {name : 'branch', type: 'int'    }, */
						{name : 'doc_no', type: 'string'  },
						{name : 'name', type: 'string'  },
						{name : 'email', type: 'string'  },
						{name : 'mobile_no', type: 'string'  },
						{name : 'user_name', type: 'string'  },
						
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
    
    
    $("#profileEditGrid").jqxGrid(
    {
        width: '100%',
        height: 515,
        source: dataAdapter,
        //showaggregates:true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
						{ text: 'Doc No', datafield: 'doc_no',width: '10%' },
						{ text: 'Name', datafield: 'name', width: '20%'},
						{ text: 'Email Id', datafield: 'email',width: '25%' },
						{ text: 'Mobile Number', datafield: 'mobile_no',width: '25%' },
						{ text: 'Username', datafield: 'user_name',width: '20%' },
						
				]
    
    });
    
    

    $('#profileEditGrid').on('rowdoubleclick', function (event) 
	{ 
  		var rowindex1=event.args.rowindex;
  
 		var doc=$('#profileEditGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
		var name=$('#profileEditGrid').jqxGrid('getcellvalue', rowindex1, "name");
		var email=$('#profileEditGrid').jqxGrid('getcellvalue', rowindex1, "email");
		var mob=$('#profileEditGrid').jqxGrid('getcellvalue', rowindex1, "mobile_no");
		var uname=$('#profileEditGrid').jqxGrid('getcellvalue', rowindex1, "user_name");

		//alert(doc+":"+name+":"+email+":"+mob+":"+uname);

		document.getElementById("sdocno").value = doc;
		document.getElementById("name").value = name;
		document.getElementById("email").value=email;
		document.getElementById("mobile").value=mob;
		document.getElementById("uname").value=uname;
		



	}); 
    
    	  

});

	
	
</script>
<div id="profileEditGrid"></div>
<input type="hidden" name="hidbranch" id="hidbranch">
<input type="hidden" name="temprow" id="temprow">