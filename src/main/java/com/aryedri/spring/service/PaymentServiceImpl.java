package com.aryedri.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aryedri.spring.dao.PaymentDAO;
import com.aryedri.spring.entity.Payment;

@Service
public class PaymentServiceImpl implements PaymentService {

	// need to inject customer dao
	@Autowired
	private PaymentDAO paymentDAO;
	
	@Override
	@Transactional
	public List<Payment> getPayments() {
		return paymentDAO.getPayments();
	}

	@Override
	@Transactional
	public void savePayment(Payment thePayment) {

		paymentDAO.savePayment(thePayment);
	}

	@Override
	@Transactional
	public Payment getPayment(int theId) {
		
		return paymentDAO.getPayment(theId);
	}

	@Override
	@Transactional
	public void deletePayment(int theId) {
		
		paymentDAO.deletePayment(theId);
	}
	
}





