package com.aryedri.spring.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.aryedri.spring.entity.Payment;

@Repository
public class PaymentDAOImpl implements PaymentDAO {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;
			
	@Override
	public List<Payment> getPayments() {
		
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
				
		// create a query  ... sort by date
		Query<Payment> theQuery = 
				currentSession.createQuery("from Payment order by date",
						Payment.class);
		
		// execute query and get result list
		List<Payment> payments = theQuery.getResultList();

		// return the results		
		return payments;
	}

	@Override
	public void savePayment(Payment thePayment) {

		// get current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// save/upate the payment ... finally LOL
		currentSession.saveOrUpdate(thePayment);
		
	}

	@Override
	public Payment getPayment(int theId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// now retrieve/read from database using the primary key
		Payment thePayment = currentSession.get(Payment.class, theId);
		
		return thePayment;
	}

	@Override
	public void deletePayment(int theId) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();
		
		// delete object with primary key
		@SuppressWarnings("rawtypes")
		Query theQuery = 
				currentSession.createQuery("delete from Payment where id=:paymentId");
		theQuery.setParameter("paymentId", theId);
		
		theQuery.executeUpdate();		
	}

}











