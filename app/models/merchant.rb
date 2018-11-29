class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:invoices, invoices: [:invoice_items, :transactions])
      .where(transactions: {result: "success"})
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end
end
