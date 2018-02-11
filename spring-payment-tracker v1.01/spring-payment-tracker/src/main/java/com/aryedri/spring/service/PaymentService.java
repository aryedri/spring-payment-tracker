package com.aryedri.spring.service;

import java.util.List;

import com.aryedri.spring.entity.Payment;

public interface PaymentService {

	public List<Payment> getPayments();

	public void savePayment(Payment thePayment);

	public Payment getPayment(int theId);

	public void deletePayment(int theId);
}
