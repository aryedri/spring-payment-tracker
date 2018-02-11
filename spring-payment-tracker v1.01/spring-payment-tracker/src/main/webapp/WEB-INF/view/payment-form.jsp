<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!DOCTYPE html>
<html>

<head>
	<title>Save Payment</title>
	<jsp:directive.page contentType="text/html;charset=UTF-8"/>
	
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/style.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/add-customer-style.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/jquery-ui.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

		  
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

		  
            <script>
  				$( function() {
   			 	$( "#date" ).datepicker({ dateFormat: "yy-mm-dd"}); 
   			 } );
  			</script>
	
</head>

<body>
	
	 <div id="content">
	 
    <nav class="navbar navbar-expand-md navbar-dark bg-dark mb-4">
      <a class="btn btn-success btn-lg active"  role="button" aria-pressed="true" href="#"><b>Payment Tracker</b></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//customer/list">CRM - Customer <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}//payment/list">PRM - Payment</a>
          </li>
        </ul>
        
        <ul class="nav justify-content-end">
				<!-- Add a logout button -->
  			<li class="nav-item">
   				<form:form action="${pageContext.request.contextPath}/logout" method="POST">
	
					<input type="submit" value="Logout"  class="btn btn-danger" size="10px" />
	
				</form:form>
		</ul>
      </div>
    </nav>		
	 </div>
	 <br>	
	<div id="wrapper">
		<div id="header">
			<h2>PRM - Payment Relationship Manager</h2>
		</div>
	</div>
	
	<div id="container">
		<h3>Save Payment</h3>
		<form:form action="savePayment" modelAttribute="payment" method="POST" onSubmit="return validateForm()"  >
			<c:set var="number1" value="${payment.id_customer}"/>
		
			<!-- need to associate this data with payment id -->
			<form:hidden path="id" />
					
			<table>
				<tbody>
					<tr>
						<td><label>Id Customer:</label></td>
						<td>
							<select name="id_customer" id="id_customer" >
								<c:set var="numId" value="${payment.id_customer}"/>
								<c:if test = "${numId != 0}" >
								<c:forEach var="tempCustomer" items="${customers}">	
									<c:set var="numCustomer" value="${tempCustomer.id}"/>
									<c:if test = "${numCustomer == numId}" >							
										<option value="${payment.id_customer}" selected>${tempCustomer.firstName} ${tempCustomer.lastName}</option>
									</c:if>
									<c:if test = "${numCustomer != numId}" >							
										<option value="${payment.id_customer}">${tempCustomer.firstName} ${tempCustomer.lastName}</option>
									</c:if>
								</c:forEach>
								</c:if>	
								<c:if test = "${numId == 0}" >						
								  <c:forEach var="tempCustomer" items="${customers}">								
									<option value="${tempCustomer.id}">${tempCustomer.firstName} ${tempCustomer.lastName}</option>
								  </c:forEach>
								</c:if>	
							</select>
						</td>
					</tr>
				
					<tr>
						<td><label>Date:</label></td>
						<td><form:input path="date" name="date" id="date"/></td>
					</tr>

					<tr>
						<td><label>Money:</label></td>
						<td><form:input  path="money" name="money" id="money" /></td>
					</tr>

					<tr>
						<td><label>Coin:</label></td>						
						<td>
							<select name="coin" id="coin" >
								<c:set var="coinP" value="${payment.coin}"/>
								<c:if test = "${coinP != null}" ><option value="${payment.coin}">${payment.coin}</option>
								</c:if>
										
								<option value="NIS">NIS</option>
								<option value="DOL">DOL</option>
								<option value="EUR">EUR</option>								
							</select>
						</td>
					</tr>

					<tr>
						<td><label></label></td>
						<td><input type="submit" value="Save"  class="save" /></td>
					</tr>

				
				</tbody>
			</table>
		
		
		</form:form>
	
		<div style="clear; both;"></div>
		
		<p>
			<a href="${pageContext.request.contextPath}/payment/list">Back to List</a>
		</p>
	
	</div>
	<div id="errorMessage"></div>	
	
	<script type="text/javascript">
                       
            function validateForm() {
                
                var errorMessage = "";
                var fieldsMissing = "";
                
                if ($("#date").val() == "") {
                    
                    fieldsMissing += "<br>Date";
                    
                }
                
                if ($("#money").val() == "") {
                    
                    fieldsMissing += "<br>Money";
                    
                }
                
                if (fieldsMissing != "") {
                    
                    errorMessage += "<p>The following field(s) are missing:" + fieldsMissing;
                    
                }
               
                if (jQuery.isNumeric($("#money").val())==false) {
                    
                    errorMessage += "<p>Your money is not valid</p>";
                    
                }
                
                if (errorMessage != "") {
                    
                    $("#errorMessage").html(errorMessage);
                    return false;
                    
                } else {
                    
                    
                    $("#errorMessage").hide();
                    
                }

            }
			
            $( function() {
  	   			 	$( "#date" ).datepicker({ dateFormat: "yy-mm-dd"}); 
  	   		 } );
            </script>
</body>

</html>










