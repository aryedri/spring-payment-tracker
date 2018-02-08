package com.aryedri.spring.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="payment")
public class Payment {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="id_customer")
	private int id_customer;
	
	@Column(name="date")
	private String date;
	
	@Column(name="money")
	private String money;

	@Column(name="coin")
	private String coin;	
	
	public Payment() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getId_customer() {
		return id_customer;
	}

	public void setId_customer(int id_customer) {
		this.id_customer = id_customer;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getCoin() {
		return coin;
	}

	public void setCoin(String coin) {
		this.coin = coin;
	}

	@Override
	public String toString() {
		return "Payment [id=" + id + ", id_customer=" + id_customer + ", date=" + date + ", money=" + money + ", coin="
				+ coin + "]";
	}
		
}





