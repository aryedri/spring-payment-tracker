package com.aryedri.spring.dao;

import java.util.List;

import com.aryedri.spring.entity.Payment;

public interface PaymentDAO {

	public List<Payment> getPayments();

	public void savePayment(Payment thePayment);

	public Payment getPayment(int theId);

	public void deletePayment(int theId);
	
}
