<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>

<html>

<head>
	<title>List Customers</title>
	<jsp:directive.page contentType="text/html;charset=UTF-8"/>
	<!-- reference our style sheet -->

	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/style.css" />
		  	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/jquery-ui.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
		  
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
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
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}/customer/list">CRM - Customer <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/payment/list">PRM - Payment</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/report/download">Report<span class="sr-only">(current)</span></a>
          </li>
        </ul>
        
        <ul class="nav justify-content-end">
				<!-- Add a logout button -->
  			<li class="nav-item">
   				<form:form action="${pageContext.request.contextPath}/logout" method="POST">
	
					<input type="submit" value="Logout"  class="btn btn-danger" />
	
				</form:form>
		</ul>
      </div>
    </nav>
    		
  </div>
  
	 <br>
	<div id="wrapper">

		<div id="header">
			<h2>CRM - Customer Relationship Manager</h2>
		</div>
	</div>
	
	<div id="container">
	
		<div id="content">
		
			<p>
				User: <security:authentication property="principal.username" />, Role(s): <security:authentication property="principal.authorities" />
			</p>
		

			<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
			
				<!-- put new button: Add Customer -->
			
				<input type="button" value="Add Customer"
					   onclick="window.location.href='showFormForAdd'; return false;"
					   class="add-button"
				/>
			
			</security:authorize>
			
			<!--  add a search box -->
            <form:form action="search" method="POST">
                Search customer: <input type="text" name="theSearchName" />
                
                <input type="submit" value="Search" class="add-button" />
            </form:form>
		
			<!--  add our html table here -->
		
			<table>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Action</th>
				</tr>
				
				<!-- loop over and print our customers -->
				<c:forEach var="tempCustomer" items="${customers}">
				
					<!-- construct an "update" link with customer id -->
					<c:url var="updateLink" value="/customer/showFormForUpdate">
						<c:param name="customerId" value="${tempCustomer.id}" />
					</c:url>					

					<!-- construct an "delete" link with customer id -->
					<c:url var="deleteLink" value="/customer/delete">
						<c:param name="customerId" value="${tempCustomer.id}" />
					</c:url>					
					
					<tr>
						<td> ${tempCustomer.firstName} </td>
						<td> ${tempCustomer.lastName} </td>
						<td> ${tempCustomer.email} </td>
						
						<td>
							<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
								<!-- display the update link -->
								<a href="${updateLink}">Update</a>
							</security:authorize>

							<security:authorize access="hasAnyRole('ADMIN')">
								<c:set var = "flag" scope = "session" value = "false"/>
								<c:forEach var="tempPayment" items="${payments}">																	 					
									<c:if test = "${tempCustomer.id == tempPayment.id_customer}" >
										<c:remove var="flag"/>
										<c:set var = "flag" scope = "session" value = "true"/>					
									</c:if>
								</c:forEach>
								<c:if test = "${not flag}" >
									<a href="${deleteLink}"
								  onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Delete</a>												
								</c:if>
								<c:remove var="flag"/>
							</security:authorize>
						</td>
						
					</tr>
				
				</c:forEach>
						
			</table>
				
		</div>
	
	</div>

</body>

</html>









