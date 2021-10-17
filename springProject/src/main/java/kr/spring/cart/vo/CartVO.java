package kr.spring.cart.vo;

public class CartVO {
	private int cart_num;
	private int prod_num;
	private int mem_num;
	private int cart_quan;
	private String mem_name;
	private String prod_name;
	private int prod_price;
	private int money;

	
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getCart_quan() {
		return cart_quan;
	}
	public void setCart_quan(int cart_quan) {
		this.cart_quan = cart_quan;
	}
	@Override
	public String toString() {
		return "CartVO [cart_num=" + cart_num + ", prod_num=" + prod_num + ", mem_num=" + mem_num + ", cart_quan="
				+ cart_quan + ", mem_name=" + mem_name + ", prod_name=" + prod_name + ", prod_price=" + prod_price
				+ ", money=" + money + "]";
	}
	

	
}