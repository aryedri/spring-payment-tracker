package com.aryedri.spring.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.supercsv.io.CsvBeanWriter;
import org.supercsv.io.ICsvBeanWriter;
import org.supercsv.prefs.CsvPreference;

import com.aryedri.spring.entity.Customer;
import com.aryedri.spring.entity.Payment;
import com.aryedri.spring.entity.PaymentFull;
import com.aryedri.spring.service.CustomerService;
import com.aryedri.spring.service.PaymentService;

@Controller
@RequestMapping("/report")
public class ReportingController {
	
	// need to inject our payment service
	@Autowired
	private PaymentService paymentService;
	// need to inject our customer service
	@Autowired
	private CustomerService customerService;
	
	@GetMapping("/download")
	public String showMyLoginPage() {
		
		return "download";
		
	}
	
	@RequestMapping(value = "/downloadPayments")
	public void downloadPaymentsCSV(HttpServletResponse response) throws IOException {

		String csvFileName = "payments.csv";

		response.setContentType("text/csv;charset=UTF-8");

		// creates mock data
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				csvFileName);
		response.setHeader(headerKey, headerValue);
		response.setCharacterEncoding("UTF-8");

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
	
	@RequestMapping(value = "/downloadCustomers")
	public void downloadCustomersCSV(HttpServletResponse response) throws IOException {

		String csvFileName = "customers.csv";

		response.setContentType("text/csv;charset=UTF-8");

		// creates mock data
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				csvFileName);
		response.setHeader(headerKey, headerValue);
		response.setCharacterEncoding("UTF-8");

		// uses the Super CSV API to generate CSV data from the model data 
		ICsvBeanWriter csvWriter = new CsvBeanWriter(response.getWriter(),
				CsvPreference.STANDARD_PREFERENCE);

		List<Customer> theCustomers = customerService.getCustomers();
		
		String[] header = { "id", "firstName", "lastName", "email" };

		csvWriter.writeHeader(header);

		for (Customer aCustomer : theCustomers) {
			csvWriter.write(aCustomer, header);
		}

		csvWriter.close();
	}
	
	
	@RequestMapping(value = "/downloadPaymentsFull")
	public void downloadPaymentsFullCSV(HttpServletResponse response) throws IOException {

		String csvFileName = "payments-full.csv";

		response.setContentType("text/csv;charset=UTF-8");

		// creates mock data
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				csvFileName);
		response.setHeader(headerKey, headerValue);
		response.setCharacterEncoding("UTF-8");

		// uses the Super CSV API to generate CSV data from the model data 
		ICsvBeanWriter csvWriter = new CsvBeanWriter(response.getWriter(),
				CsvPreference.STANDARD_PREFERENCE);

		List<Customer> theCustomers = customerService.getCustomers();
		List<Payment> thePayments = paymentService.getPayments();
		ArrayList<PaymentFull> thePaymentsFull = new ArrayList<PaymentFull>();
		HashMap<Integer,String> names =new HashMap<Integer,String>(); 
		
		for (Customer aCustomer : theCustomers) {
			names.put(aCustomer.getId(), aCustomer.getFirstName()+" "
						+aCustomer.getLastName());
		}
		String[] header = { "name", "date", "money","coin" };
		String name = null;		
		for (Payment aPayment : thePayments) {
			for (Customer aCustomer : theCustomers) {
				if (aPayment.getId_customer()==aCustomer.getId())
					name =aCustomer.getFirstName()+" "+aCustomer.getLastName();
			}
			thePaymentsFull.add(new PaymentFull(name, 
					aPayment.getDate(),aPayment.getMoney(),aPayment.getCoin()));
		}
		
		csvWriter.writeHeader(header);

		for (PaymentFull aPaymentFull : thePaymentsFull) {
			csvWriter.write(aPaymentFull, header);
		}

		csvWriter.close();
	}
 

}