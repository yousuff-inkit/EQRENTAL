<%
    String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
	try{	
		session.setAttribute("BRANCHID", brhid);            
		System.out.println("session===="+session.getAttribute("BRANCHID"));  
		response.getWriter().print(brhid);                        
	}
	catch(Exception e){
		e.printStackTrace();  
	}
%>