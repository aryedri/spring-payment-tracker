<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!doctype html>
<html lang="en">

<head>
	
	<title>Login Page</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Reference Bootstrap files -->
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/login.css">
		  
	<script src="${pageContext.request.contextPath}/resources/js/login.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>

<body>
	 <div class="container">
        <div class="card card-container">
            <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
            <p id="profile-name" class="profile-name-card"></p>
            <!-- Login Form -->
            <form class="form-signin"action="${pageContext.request.contextPath}/authenticateTheUser" 
						  method="POST" class="form-horizontal">
						  
					    <!-- Place for messages: error, alert etc ... -->
					    <div class="form-group">
					        <div class="col-xs-15">
					            <div>
								
									<!-- Check for login error -->
								
									<c:if test="${param.error != null}">
										
										<div class="alert alert-danger col-xs-offset-1 col-xs-10">
											Invalid username and password.
										</div>
		
									</c:if>
										
									<!-- Check for logout -->

									<c:if test="${param.logout != null}">
										            
										<div class="alert alert-success col-xs-offset-1 col-xs-10">
											You have been logged out.
										</div>
								    
									</c:if>
									
					            </div>
					        </div>
					    </div>
               			 <span id="reauth-email" class="reauth-email"></span>
                		<input  id="inputEmail" name="username" class="form-control" placeholder="username" required autofocus>
                		<input type="password" id="inputPassword" name="password" class="form-control" placeholder="password" required>
                		<button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Sign in</button>
                
                		<!-- I'm manually adding tokens ... Bro! -->

						<input type="hidden"
							   name="${_csrf.parameterName}"
							   value="${_csrf.token}" />
            </form><!-- /form -->

        </div><!-- /card-container -->
    </div><!-- /container -->

</body>
</html>