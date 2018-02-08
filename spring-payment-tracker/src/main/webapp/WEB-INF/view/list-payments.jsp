<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html>

<head>
	<title>List Payments</title>
	<jsp:directive.page contentType="text/html;charset=UTF-8"/>
	<!-- reference our style sheet -->

	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/style.css" />
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
		  	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/jquery-ui.css">

</head>

<body>
	 <div id="content">	
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
  			<a class="navbar-brand" href="#">Payment Tracker</a>
  				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    				<span class="navbar-toggler-icon"></span>
  				</button>
 				 <div class="collapse navbar-collapse" id="navbarNav">
				<ul class="nav nav-tabs">
  					<li class="nav-item">
    					<a class="nav-link" href="${pageContext.request.contextPath}//customer/list">CRM - Customer</a>
  					</li>
  					<li class="nav-item active">
    					<a class="nav-link active" href="${pageContext.request.contextPath}//payment/list">PRM - Payment</a>
  					</li>
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
	
		<div id="content">
		
			<p>
				User: <security:authentication property="principal.username" />, Role(s): <security:authentication property="principal.authorities" />
			</p>
		

			<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
			
				<!-- put new button: Add Payment -->
			
				<input type="button" value="Add Payment"
					   onclick="window.location.href='showFormForAdd'; return false;"
					   class="add-button"
				/>
			
			</security:authorize>
		
			<!--  add our html table here -->
		
			<table>
				<tr>
					<th>Id Customer</th>
					<th>Date</th>
					<th>Money</th>
					<th>Coin</th>
					<th>Action</th>
				</tr>
				
				<!-- loop over and print our payments -->
				<c:forEach var="tempPayment" items="${payments}">
				
					<!-- construct an "update" link with payment id -->
					<c:url var="updateLink" value="/payment/showFormForUpdate">
						<c:param name="paymentId" value="${tempPayment.id}" />
					</c:url>					

					<!-- construct an "delete" link with payment id -->
					<c:url var="deleteLink" value="/payment/delete">
						<c:param name="paymentId" value="${tempPayment.id}" />
					</c:url>
					

					<tr>
						<td> 
					<c:remove var="numId"/>					
					<c:set var="numId" value="${tempPayment.id}" />
					<c:forEach var="tempCustomer" items="${customers}">
						<c:remove var="numCustomer"/>	
						<c:set var="numCustomer" value="${tempCustomer.id}" />								 					
							<c:if test = "${tempCustomer.id == tempPayment.id_customer}" >
								${tempCustomer.firstName} ${tempCustomer.lastName}													
							</c:if>
							<c:remove var="numCustomer"/>
					</c:forEach> </td>
						<td> ${tempPayment.date} </td>
						<td> ${tempPayment.money} </td>
						<td> ${tempPayment.coin} </td>
						<td>
							<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
								<!-- display the update link -->
								<a href="${updateLink}">Update</a>
							</security:authorize>

							<security:authorize access="hasAnyRole('ADMIN')">
								<a href="${deleteLink}"
								   onclick="if (!(confirm('Are you sure you want to delete this payment?'))) return false">Delete</a>
							</security:authorize>
						</td>
						
					</tr>
					<c:remove var="fullName"/>
					<c:remove var="numId"/>
				</c:forEach>
						
			</table>
				
		</div>
	
	</div>
	
	<hr>
	
	
	<!-- Add a logout button -->
	<form:form action="${pageContext.request.contextPath}/logout" 
			   method="POST">
	
		<input type="submit" value="Logout" class="add-button" />
	
	</form:form>
	
</body>

</html>









