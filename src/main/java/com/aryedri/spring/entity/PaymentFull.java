package com.aryedri.spring.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="paymentfull")
public class PaymentFull {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="name")
	private String name;
	
	@Column(name="date")
	private String date;
	
	@Column(name="money")
	private String money;

	@Column(name="coin")
	private String coin;	
	
	public PaymentFull() {
		
	}

	public PaymentFull(String name, String date, String money, String coin) {
		super();
		this.name = name;
		this.date = date;
		this.money = money;
		this.coin = coin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
		return "PaymentFull [name=" + name + ", date=" + date + ", money=" + money + ", coin=" + coin + "]";
	}

}





