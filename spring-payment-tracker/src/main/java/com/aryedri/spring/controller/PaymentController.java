package com.aryedri.spring.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aryedri.spring.entity.Customer;
import com.aryedri.spring.entity.Payment;

import com.aryedri.spring.service.CustomerService;
import com.aryedri.spring.service.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	// need to inject our payment service
	@Autowired
	private PaymentService paymentService;
	
	// need to inject our customer service
	@Autowired
	private CustomerService customerService;
	
	@GetMapping("/list")
	public String listPayments(Model theModel) {
		
		// get payments from the service
		List<Payment> thePayments = paymentService.getPayments();
				
		// add the payments to the model
		theModel.addAttribute("payments", thePayments);
		
		// get customers from the service
		List<Customer> theCustomers = customerService.getCustomers();
				
		// add the customers to the model
		theModel.addAttribute("customers", theCustomers);

		return "list-payments";
	}
	
	@GetMapping("/showFormForAdd")
	public String showFormForAdd(Model theModel) {
		
		// create model attribute to bind form data
		Payment thePayment = new Payment();
		
		theModel.addAttribute("payment", thePayment);
		
		// get customers from the service
		List<Customer> theCustomers = customerService.getCustomers();
				
		// add the customers to the model
		theModel.addAttribute("customers", theCustomers);
		
		return "payment-form";
	}
	
	@PostMapping("/savePayment")
	public String savePayment (@ModelAttribute("payment") Payment thePayment) {
		
		// save the payment using our service
		paymentService.savePayment(thePayment);	
		
		return "redirect:/payment/list";
	}
	
	@GetMapping("/showFormForUpdate")
	public String showFormForUpdate(@RequestParam("paymentId") int theId,
									Model theModel) {
		
		// get the payment from our service
		Payment thePayment = paymentService.getPayment(theId);	
		
		// set payment as a model attribute to pre-populate the form
		theModel.addAttribute("payment", thePayment);
		
		// get customers from the service
		List<Customer> theCustomers = customerService.getCustomers();
				
		// add the customers to the model
		theModel.addAttribute("customers", theCustomers);
		
		// send over to our form		
		return "payment-form";
	}
	
	@GetMapping("/delete")
	public String deleteCustomer(@RequestParam("paymentId") int theId) {
		
		// delete the payment
		paymentService.deletePayment(theId);
		
		return "redirect:/payment/list";
	}
}










