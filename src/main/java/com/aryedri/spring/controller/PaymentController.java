package com.aryedri.spring.controller;


import java.io.IOException;
import java.util.Arrays;

//import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.supercsv.io.CsvBeanWriter;
import org.supercsv.io.ICsvBeanWriter;
import org.supercsv.prefs.CsvPreference;

import com.aryedri.spring.entity.Book;
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
		
		// add the customers to the model
		theModel.addAttribute("customers", theCustomers);
		
		return "payment-form";
	}
	
	@PostMapping("/savePayment")
	public String savePayment (@ModelAttribute("payment") Payment thePayment) {
		// get customers from the service

		// save the payment using our service*/
		paymentService.savePayment(thePayment);	//if no -> no save
		
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
	
	@RequestMapping(value = "/downloadPayments")
	public void downloadPaymentsCSV(HttpServletResponse response) throws IOException {

		String csvFileName = "payments.csv";

		response.setContentType("text/csv");

		// creates mock data
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				csvFileName);
		response.setHeader(headerKey, headerValue);

		// uses the Super CSV API to generate CSV data from the model data 
		ICsvBeanWriter csvWriter = new CsvBeanWriter(response.getWriter(),
				CsvPreference.STANDARD_PREFERENCE);

		List<Payment> thePayments = paymentService.getPayments();
		
		String[] header = { "id", "id_customer", "date", "money",
				"coin" };

		csvWriter.writeHeader(header);

		for (Payment aPayment : thePayments) {
			csvWriter.write(aPayment, header);
		}

		csvWriter.close();
	}
	
	@RequestMapping(value = "/downloadCSV")
	public void downloadCSV(HttpServletResponse response) throws IOException {

		String csvFileName = "books.csv";

		response.setContentType("text/csv");

		// creates mock data
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				csvFileName);
		response.setHeader(headerKey, headerValue);

		Book book1 = new Book("Effective Java", "Java Best Practices",
				"Joshua Bloch", "Addision-Wesley", "0321356683", "05/08/2008",
				38);

		Book book2 = new Book("Head First Java", "Java for Beginners",
				"Kathy Sierra & Bert Bates", "O'Reilly Media", "0321356683",
				"02/09/2005", 30);

		Book book3 = new Book("Thinking in Java", "Java Core In-depth",
				"Bruce Eckel", "Prentice Hall", "0131872486", "02/26/2006", 45);

		Book book4 = new Book("Java Generics and Collections",
				"Comprehensive guide to generics and collections",
				"Naftalin & Philip Wadler", "O'Reilly Media", "0596527756",
				"10/24/2006", 27);

		List<Book> listBooks = Arrays.asList(book1, book2, book3, book4);

		// uses the Super CSV API to generate CSV data from the model data 
		ICsvBeanWriter csvWriter = new CsvBeanWriter(response.getWriter(),
				CsvPreference.STANDARD_PREFERENCE);

		String[] header = { "Title", "Description", "Author", "Publisher",
				"isbn", "PublishedDate", "Price" };

		csvWriter.writeHeader(header);

		for (Book aBook : listBooks) {
			csvWriter.write(aBook, header);
		}

		csvWriter.close();
	}
}










