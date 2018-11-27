class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :invoice_items
end
