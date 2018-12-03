class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.revenue_by_date(date)
    select('sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .where(invoices: {created_at: DateTime.parse(date).beginning_of_day..DateTime.parse(date).end_of_day})[0]

  end

  def self.total_revenue_for_successful_transactions(id)
    select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .where(invoices: {merchant_id: id})[0]
  end

  def self.total_revenue_for_successful_transactions_by_date(id, date)
    select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .where(invoices: {merchant_id: id})
      .where(invoices: {created_at: DateTime.parse(date).beginning_of_day..DateTime.parse(date).end_of_day})[0]
  end

  def self.favorite_customer(id)
    Customer.select('customers.*, count(transactions.id) as customer_transactions')
              .joins(:invoices, invoices: :transactions)
              .where(invoices: {merchant_id: id})
              .where(transactions: {result: "success"})
              .group(:id)
              .order('customer_transactions DESC')
              .limit(1)[0]
  end

end
