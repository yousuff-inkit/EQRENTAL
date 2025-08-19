<%@page import="com.limousine.limosetup.location2.*"%>
<% ClsLocation2DAO objloc=new ClsLocation2DAO();%>
    <script type="text/javascript">
    var data= '<%=objloc.getSearchData()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'location', type: 'String'  },
                          	{name : 'latitude', type: 'String'  },
                          	{name : 'longitude',type:'String'},
                          	{name : 'date',type:'date'},
                          	{name : 'chkairport',type:'string'}
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
		            }		
            );
            $("#location2Search").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '6%' },
						{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Location', datafield: 'location', width: '28%' },
						{ text: 'Latitude',datafield:'latitude',width:'20%'},
						{ text: 'Longitude', datafield: 'longitude', width: '20%' },
						{ text: 'Airport', datafield: 'chkairport', width: '16%',columntype:'checkbox' },
				]
            });
           
            $('#location2Search').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#location2Search').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("location").value=$('#location2Search').jqxGrid('getcellvalue', rowindex1, "location");
                document.getElementById("latitude").value=$('#location2Search').jqxGrid('getcellvalue', rowindex1, "latitude");
                document.getElementById("longitude").value=$('#location2Search').jqxGrid('getcellvalue', rowindex1, "longitude");   
                document.getElementById("hidchkairport").value=$('#location2Search').jqxGrid('getcellvalue', rowindex1, "chkairport");             
				$('#date').jqxDateTimeInput('val',$('#location2Search').jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
                if(document.getElementById("location").value!=""){
       			 document.getElementById("pac-input").value=document.getElementById("location").value;
                }
       			document.getElementById("mode").value="view";
       			document.getElementById("frmlocation2").submit();
                /*  map=null;
       			$('#mapdiv').load('map.jsp?latitude='+document.getElementById("latitude").value+'&longitude='+document.getElementById("longitude").value); */
       		 	
            		 }); 
      
        });
    </script>
    <div id="location2Search"></div>
