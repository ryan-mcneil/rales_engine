class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(x)
    select('distinct merchants.*, sum(invoice_items.quantity * invoice_items.price) as revenue')
      .joins(:items)
      .joins('join invoice_items on items.id=invoice_items.item_id')
      .joins('join invoices on invoices.id=invoice_items.invoice_id')
      .group('merchants.id, invoice_items.id')
      .order('revenue DESC')
      .limit(x)

  end
end
