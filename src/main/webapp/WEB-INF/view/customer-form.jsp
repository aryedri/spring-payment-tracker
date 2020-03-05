<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>
	<title>Save Customer</title>
	<jsp:directive.page contentType="text/html;charset=UTF-8"/>

	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/style.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/add-customer-style.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
		  
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>		  
		  
		<script type="text/javascript">
            
            function isEmail(email) {
  
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  
                return regex.test(email);
                
            }
            
            function validateForm() {
                
                var errorMessage = "";
                var fieldsMissing = "";
                

                
                if ($("#firstName").val() == "") {
                    
                    fieldsMissing += "<br>firstName";
                    
                }
                
                if ($("#lastName").val() == "") {
                    
                    fieldsMissing += "<br>lastName";
                    
                }
                
                if (fieldsMissing != "") {
                    
                    errorMessage += "<p>The following field(s) are missing:" + fieldsMissing;
                    
                }
                
                if ((isEmail($("#email").val()) == false)&&($("#email").val() != "")) {
                    
                    errorMessage += "<p>Your email address is not valid</p>";
                    
                }
                
                if (errorMessage != "") {
                    
                    $("#errorMessage").html(errorMessage);
                    return false;
                    
                } else {
                    
                    
                    $("#errorMessage").hide();
                    
                }
                
            }
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
          <li class="nav-item active">
            <a class="nav-link" href="${pageContext.request.contextPath}//customer/list">CRM - Customer <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//payment/list">PRM - Payment</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//report/download">Report<span class="sr-only">(current)</span></a>
          </li>
        </ul>
        
        <ul class="nav justify-content-end">
				<!-- Add a logout button -->
  			<li class="nav-item">
   				<form:form action="${pageContext.request.contextPath}/logout" method="POST">
	
					<input type="submit" value="Logout"  class="btn btn-danger" />
	
				</form:form>
  			</li>  			
  			
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
		<h3>Save Customer</h3>
	
		<form:form action="saveCustomer" modelAttribute="customer" method="POST" onSubmit="return validateForm()" >

			<!-- need to associate this data with customer id -->
			<form:hidden path="id" />
					
			<table>
				<tbody>
					<tr>
						<td><label>First name:</label></td>
						<td><form:input path="firstName" name="firstName" id="firstName"/></td>
					</tr>
				
					<tr>
						<td><label>Last name:</label></td>
						<td><form:input path="lastName" name="lastName" id="lastName"/></td>
					</tr>

					<tr>
						<td><label>Email:</label></td>
						<td><form:input path="email" name="email" id="email" /></td>
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
			<a href="${pageContext.request.contextPath}/customer/list">Back to List</a>
		</p>
	
	</div>
	<div id="errorMessage"></div>	
</body>

</html>










