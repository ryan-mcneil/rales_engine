class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices

  def self.favorite_merchant(id)
    Merchant.select('merchants.*, count(transactions.id) as merchant_transactions')
              .joins(:invoices, invoices: :transactions)
              .where(invoices: {customer_id: id})
              .where(transactions: {result: "success"})
              .group(:id)
              .order('merchant_transactions DESC')
              .limit(1)[0]
  end
end
