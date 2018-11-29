class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(x)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:items)
      .joins('join invoice_items on items.id=invoice_items.item_id')
      .joins('join invoices on invoices.id=invoice_items.invoice_id')
      .group('merchants.id')
      .order('revenue DESC')
      .limit(x)
  end
end
