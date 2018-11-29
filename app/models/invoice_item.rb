class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :unit_price
  
  belongs_to :item
  belongs_to :invoice
  has_many :invoice_items
end
