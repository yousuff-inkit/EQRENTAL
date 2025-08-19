<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<style>
		.select2-selection__placeholder{
 			font-size:10px !important;
		}
		.select2-selection__rendered {
  			font-size: 10px !important;
		}
		.form-control{
			display: block;
		    width: 100%;
		    height: 34px;
		    padding: 6px 12px;
		    font-size: 14px;
		    line-height: 1.42857143;
		    color: #555;
		    background-color: #fff;
		    background-image: none;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
		    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
		    -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		}
		.input-sm {
    		height: 30px !important;
    		padding: 5px 10px;
    		font-size: 12px;
    		line-height: 1.5;
    		border-radius: 3px;
		}
	</style>
</head>

<body onload="getBranch();">
    <form id="frmLimoImportData" method="post">
        <div id="mainBG" class="homeContent" data-type="background">
            <div class='hidden-scrollbar'>
                <table width="100%">
                    <tr>
                        <td width="20%">
                            <fieldset style="background: #ECF8E0;">
                                <table width="100%">
                                    <jsp:include page="../../heading.jsp"></jsp:include>
                                    <tr>
                                        <td width="41%" align="right">
                                            <label class="branch">Client</label>
                                        </td>
                                        <td colspan="2">
                                        	<select name="cmbclient" id="cmbclient" class="" style="width:100px;">
                                        		<option value="">--Select--</option>
                                        	</select>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td align="right">
                                        	<label class="branch">Airport</label>
                                        </td>
                                        <td>
                                            <select name="cmblocation" id="cmblocation" class="">
                                        		<option value="">--Select--</option>
                                        	</select>
                                        </td>
                                    </tr>
									<tr>
                                        <td align="right">
                                        	<label class="branch">Amount</label>
                                        </td>
                                        <td>
                                            <input class="form-control input-sm" type="text" name="amount" id="amount" style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
                                        </td>
                                    </tr>
                                    <tr><td colspan="2"><hr></td></tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <button type="button" name="btnupdate" id="btnupdate" class="myButton">Update</button>
                                            <button type="button" name="btnclear" id="btnclear" class="myButton" onclick="funClearData();">Clear</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                            <br>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td width="80%">
                            <table width="100%">
                                <tr>
                                    <td rowspan="2">
                                        <div id="parkingfeediv">
                                            <jsp:include page="parkingFeeGrid.jsp"></jsp:include>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                    </tr>
                </table>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
            </div>
            <div id="clientwindow">
                <div></div>
            </div>
            <div id="locationwindow">
                <div></div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function() {
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
                $("#cmbclient").select2({
			    	placeholder: "Select Client",
			    	allowClear: true,
			    	width: '200px'
				});
				$("#cmblocation").select2({
			    	placeholder: "Select Airport",
			    	allowClear: true,
			    	width: '200px'
				});
                $.ajax({url: "getInitData.jsp", success: function(result){
    				result=JSON.parse(result);
    				var htmldata='<option value="">--Select--</option>';
    				$.each(result.clientdata, function( index, value ) {
	  					htmldata+='<option value="'+value.value+'">'+value.name+'</option>';
					});
  					$('#cmbclient').html($.parseHTML(htmldata));
  					
  					htmldata='<option value="">--Select--</option>';
    				$.each(result.locdata, function( index, value ) {
	  					htmldata+='<option value="'+value.value+'">'+value.name+'</option>';
					});
  					$('#cmblocation').html($.parseHTML(htmldata));
  				}});
  				$('#btnupdate').click(function(){
  					if($('#cmbclient').val()==''){
  						$.messager.alert('Warning','Please select client','Warning');
  						return false;
  					}
  					else if($('#cmblocation').val()==''){
  						$.messager.alert('Warning','Please select location','Warning');
  						return false;
  					}
  					else if($('#amount').val()==''){
  						$.messager.alert('Warning','Please type in amount','Warning');
  						return false;
  					}
  					else{
  						$('#overlay,#PleaseWait').show();
  						$.ajax({
  							url: "saveData.jsp",
  							type: "get", //send it through get method
  							data: { 
    							client: $('#cmbclient').val(), 
    							location: $('#cmblocation').val(), 
    							amount: $('#amount').val()
  							},
  							success: function(response) {
    							//Do Something
    							if(response.trim()=="0"){
									$('#overlay,#PleaseWait').hide();
	    							$.messager.alert('Message','Successfully Saved','Message');
	  								funClearData();
	  								funreload("");
    							}
    							else{
    								$('#overlay,#PleaseWait').hide();
    								$.messager.alert('Warnring','Not Saved','Warning');
    							}
  							},
 	 						error: function(xhr) {
    							//Do Something to handle error
    							$('#overlay,#PleaseWait').hide();
    							$.messager.alert('Warnring','Not Saved','Warning');
  							}
						});
  					}
  				});
            });

            function funreload(event) {
                var cldocno = $('#cmbclient').val();
                var location = $('#cmblocation').val();
                var branch = $('#cmbbranch').val();
                $('#parkingfeediv').load('parkingFeeGrid.jsp?cldocno='+cldocno+'&location='+location+'&branch='+branch+'&id=1');
            }

			function isNumber(evt,id) {
				//Function to restrict characters and enter number only
			  	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		        {
		        	$.messager.alert('Warning','Enter Numbers Only');
		           	$("#"+id+"").focus();
		            return false;
		        }
		        return true;
		    }
		    function funClearData(){
		    	$('input[type=text]').val('');
		    	$('#cmbclient,#cmblocation').val('').trigger('change');
		    	$('#parkingFeeGrid').jqxGrid('clear');
		    }
		    
		    function funExportBtn(){
		    	var rows=$('#parkingFeeGrid').jqxGrid('getrows');
		    	if(rows.length==0){
		    		$.messager.alert('Warning','Please submit');
		    		return false;
		    	}
		    	else{
		    		JSONToCSVCon(exceldata, 'Parking Fee List', true);	
		    	}
				
		 	}
        </script>
    </form>
</body>

</html>