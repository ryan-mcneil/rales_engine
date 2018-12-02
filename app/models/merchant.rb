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

  def total_revenue_for_successful_tranactions
    invoices.select('sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})[0]
  end
end
