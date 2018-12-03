require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'Relationships' do
    it { should have_many(:invoices) }
  end

  describe 'Single Merchant Class Methods' do
    it 'should return merchant with most successful transactions' do
      @customer = create(:customer)
      @m_1, @m_2, @m_3 = create_list(:merchant, 3)
      @inv_1 = create(:invoice, status: "shipped", merchant: @m_1, customer: @customer, created_at: "2018-12-01")
      @i_1 = create(:item, merchant: @m_1)
      @t_1 = create(:transaction, invoice: @inv_1)
      @ii_1 = create(:invoice_item, unit_price: 200, quantity: 3, item: @i_1, invoice: @inv_1)
      @inv_2 = create(:invoice, status: "shipped", merchant: @m_1, customer: @customer, created_at: "2018-12-02")
      @i_2 = create(:item, merchant: @m_1)
      @t_2 = create(:transaction, invoice: @inv_2)
      @ii_2 = create(:invoice_item, unit_price: 300, quantity: 4, item: @i_2, invoice: @inv_2)
      @inv_3 = create(:invoice, status: "shipped", merchant: @m_2, customer: @customer, created_at: "2018-12-01")
      @i_3 = create(:item, merchant: @m_2)
      @t_3 = create(:transaction, invoice: @inv_3)
      @ii_3 = create(:invoice_item, unit_price: 100, quantity: 4, item: @i_3, invoice: @inv_3)
      @inv_4 = create(:invoice, status: "shipped", merchant: @m_3, customer: @customer, created_at: "2018-12-03")
      @i_4 = create(:item, merchant: @m_2)
      @t_4 = create(:transaction, invoice: @inv_4, result: "failed")
      @ii_4 = create(:invoice_item, unit_price: 100, quantity: 6, item: @i_4, invoice: @inv_4)

      merchant = Customer.favorite_merchant(@customer.id)
      expect(merchant.id).to eq (@m_1.id)

    end
  end
end
