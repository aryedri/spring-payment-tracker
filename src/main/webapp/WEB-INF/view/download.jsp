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
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//customer/list">CRM - Customer <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//payment/list">PRM - Payment</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}//report/download">Report<span class="sr-only">(current)</span></a>
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
			<h2>Report Files</h2>
		</div>
	</div>
	
	<div id="container">
	
		<div id="content">
		
			<p>
				User: <security:authentication property="principal.username" />, Role(s): <security:authentication property="principal.authorities" />
			</p>
		

			<!-- <security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
			
				<!-- put new download -->
				<p><a href="downloadPayments">Download payment #1</a></p>
				
								<!-- put new download -->
				<p><a href="downloadCustomers">Download customer #1</a></p>
				
								<!-- put new download -->
				<p><a href="downloadPaymentsFull">Download payment full #1</a></p>
		<!--</security:authorize>-->
			

		</div>
	
	</div>

</body>

</html>









