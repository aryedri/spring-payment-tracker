<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<!DOCTYPE html>
<html>

<head>
	<title>Save Payment</title>
	<jsp:directive.page contentType="text/html;charset=UTF-8"/>
	
	  <style>
  		.custom-id_customer {
 		   position: relative;
 		   display: inline-block;
 		   background-color: #ffffff;
		  }
		  .custom-id_customer-toggle {
		    position: absolute;
		    top: 0;
		    bottom: 0;
		    margin-left: -1px;
		    padding: 0;
		    background-color: #ffffff;
 		 }
		 .custom-id_customer-input {
   			 margin: 0;
    		 padding: 5px 10px;
    		 background-color: #ffffff;
  		}
  	</style>
	
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
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-3.3.1.slim.min.js"></script>
		  
    <script>
  				$( function() {
   			 	$( "#date" ).datepicker({ dateFormat: "yy-mm-dd"}); 
   			 } );
    </script>
	
	  <script>
  $( function() {
    $.widget( "custom.id_customer", {
      _create: function() {
        this.wrapper = $( "<span>" )
          .addClass( "custom-id_customer" )
          .insertAfter( this.element );
 
        this.element.hide();
        this._createAutocomplete();
        this._createShowAllButton();
      },
 
      _createAutocomplete: function() {
        var selected = this.element.children( ":selected" ),
          value = selected.val() ? selected.text() : "";
 
        this.input = $( "<input>" )
          .appendTo( this.wrapper )
          .val( value )
          .attr( "title", "" )
          .addClass( "custom-id_customer-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
          .autocomplete({
            delay: 0,
            minLength: 0,
            source: $.proxy( this, "_source" )
          })
          .tooltip({
            classes: {
              "ui-tooltip": "ui-state-highlight"
            }
          });
 
        this._on( this.input, {
          autocompleteselect: function( event, ui ) {
            ui.item.option.selected = true;
            this._trigger( "select", event, {
              item: ui.item.option
            });
          },
 
          autocompletechange: "_removeIfInvalid"
        });
      },
 
      _createShowAllButton: function() {
        var input = this.input,
          wasOpen = false;
 
        $( "<a>" )
          .attr( "tabIndex", -1 )
          .attr( "title", "Show All Items" )
          .tooltip()
          .appendTo( this.wrapper )
          .button({
            icons: {
              primary: "ui-icon-triangle-1-s"
            },
            text: false
          })
          .removeClass( "ui-corner-all" )
          .addClass( "custom-id_customer-toggle ui-corner-right" )
          .on( "mousedown", function() {
            wasOpen = input.autocomplete( "widget" ).is( ":visible" );
          })
          .on( "click", function() {
            input.trigger( "focus" );
 
            // Close if already visible
            if ( wasOpen ) {
              return;
            }
 
            // Pass empty string as value to search for, displaying all results
            input.autocomplete( "search", "" );
          });
      },
 
      _source: function( request, response ) {
        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
        response( this.element.children( "option" ).map(function() {
          var text = $( this ).text();
          if ( this.value && ( !request.term || matcher.test(text) ) )
            return {
              label: text,
              value: text,
              option: this
            };
        }) );
      },
 
      _removeIfInvalid: function( event, ui ) {
 
        // Selected an item, nothing to do
        if ( ui.item ) {
          return;
        }
 
        // Search for a match (case-insensitive)
        var value = this.input.val(),
          valueLowerCase = value.toLowerCase(),
          valid = false;
        this.element.children( "option" ).each(function() {
          if ( $( this ).text().toLowerCase() === valueLowerCase ) {
            this.selected = valid = true;
            return false;
          }
        });
 
        // Found a match, nothing to do
        if ( valid ) {
          return;
        }
 
        // Remove invalid value
        this.input
          .val( "" )
          .attr( "title", value + " didn't match any item" )
          .tooltip( "open" );
        this.element.val( "" );
        this._delay(function() {
          this.input.tooltip( "close" ).attr( "title", "" );
        }, 2500 );
        this.input.autocomplete( "instance" ).term = "";
      },
 
      _destroy: function() {
        this.wrapper.remove();
        this.element.show();
      }
    });
 
    $( "#id_customer" ).id_customer();
    $( "#toggle" ).on( "click", function() {
      $( "#id_customer" ).toggle();
    });
  } );
  </script>  
	
</head>

<body >
	
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
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}//report/download">Report<span class="sr-only">(current)</span></a>
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
						<td><label>Name:</label></td>
						<!-- <td><form:input path="id_customer" name="id_customer" id="id_customer"/></td>-->
						<td><div class="ui-widget">
							<select name="id_customer" id="id_customer" form="id_customer" class="custom-select" >
								<c:set var="numId" value="${payment.id_customer}"/>
								<c:forEach var="tempCustomer" items="${customers}">
									<c:if test="${numId == tempCustomer.id}">
										<option value="${tempCustomer.id}" selected>${tempCustomer.firstName} ${tempCustomer.lastName}</option>
									</c:if>								
									<c:if test="${numId != tempCustomer.id}">
										<option value="${tempCustomer.id}" >${tempCustomer.firstName} ${tempCustomer.lastName}</option>
									</c:if>										
								</c:forEach>	
							</select>
							<c:remove var="numId"/>
						</div></td> 
					</tr>
				
					<tr>
						<td><label>Date:</label></td>
						<td><form:input path="date" name="date2" id="date"/></td>
					</tr>

					<tr>
						<td><label>Money:</label></td>
						<td><form:input  path="money" name="money" id="money" /></td>
					</tr>

					<tr>
						<td><label>For:</label></td>						
						<td>
							<select name="coin" id="coin" >
								<c:set var="coinP" value="${payment.coin}"/>
								<c:set var="donation" value="תרומה"/>
								<c:set var="builder" value="קרן בנין"/>
								<c:set var="member" value="דמי חבר"/>
								<c:if test = "${coinP != null}" ><option value="${payment.coin}">${payment.coin}</option>
								</c:if>										
								<option value="${donation}">תרומה</option>
								<option value="${builder}">קרן בנין</option>
								<option value="${member}">דמי חבר</option>								
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
   		 function isEmail(date) {
    	  
        		var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        		return regex.test(email);        
    		}
                       
            function validateForm() {
                
                var errorMessage = "";
                var fieldsMissing = "";
                
                if ($("#id_customer").val() < 1) {
                    
                    fieldsMissing += "<br>Name";
                    
                }
                
                if ($("#date").val() == "") {
                    
                    fieldsMissing += "<br>Date";
                    
                }
                
                if ($("#money").val() == "") {
                    
                    fieldsMissing += "<br>Money";
                    
                }
                
                if (fieldsMissing != "") {
                    
                    errorMessage += "<p>The following field(s) are missing:" + fieldsMissing;
                    
                }
                
                if ((jQuery.isNumeric($("#money").val())==false)||(isNaN($("#money").val()))
                		||($("#money").val().indexOf("e")!=-1)||($("#money").val().indexOf("x")!=-1)	) { 
                    
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
            
  			$( function() {
    		var availableTags = ${listName};
    		$( "#tags" ).autocomplete({source: availableTags });
  			} );
  	</script>

</body>

</html>










