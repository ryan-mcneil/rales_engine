require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'Relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe 'Class Methods' do

    before(:each) do
      @m_1, @m_2, @m_3 = create_list(:merchant, 3)
      @inv_1 = create(:invoice, status: "shipped", merchant: @m_1, created_at: "2018-12-01")
      @i_1 = create(:item, merchant: @m_1)
      @t_1 = create(:transaction, invoice: @inv_1)
      @ii_1 = create(:invoice_item, unit_price: 200, quantity: 3, item: @i_1, invoice: @inv_1)
      @inv_2 = create(:invoice, status: "shipped", merchant: @m_1, created_at: "2018-12-02")
      @i_2 = create(:item, merchant: @m_1)
      @t_2 = create(:transaction, invoice: @inv_2)
      @ii_2 = create(:invoice_item, unit_price: 300, quantity: 4, item: @i_2, invoice: @inv_2)
      @inv_3 = create(:invoice, status: "shipped", merchant: @m_2, created_at: "2018-12-01")
      @i_3 = create(:item, merchant: @m_2)
      @t_3 = create(:transaction, invoice: @inv_3)
      @ii_3 = create(:invoice_item, unit_price: 100, quantity: 4, item: @i_3, invoice: @inv_3)
      @inv_4 = create(:invoice, status: "shipped", merchant: @m_3, created_at: "2018-12-03")
      @i_4 = create(:item, merchant: @m_3)
      @t_4 = create(:transaction, invoice: @inv_4)
      @ii_4 = create(:invoice_item, unit_price: 100, quantity: 6, item: @i_4, invoice: @inv_4)
    end

    it 'returns top x merchants ranked by total revenue' do
      top_merchants = Merchant.most_revenue(2).to_a
      expect(top_merchants.size).to eq(2)
      expect(top_merchants[0].id).to eq(@m_1.id)
      expect(top_merchants[1].id).to eq(@m_3.id)
    end

    it 'returns top x merchants ranked by total items sold' do
      top_merchants = Merchant.most_items(2).to_a
      expect(top_merchants.size).to eq(2)
      expect(top_merchants[0].id).to eq(@m_1.id)
      expect(top_merchants[1].id).to eq(@m_3.id)
    end

    it 'returns total revenue from date x across all merchants' do
      total_revenue = Merchant.revenue_by_date("2018-12-01").total_revenue
      expect(total_revenue).to eq(1000)
    end
  end

  describe 'instance methods' do

    before(:each) do
      @merchant = create(:merchant)
      @c_1, @c_2, @c_3 = create_list(:customer, 3)
      @inv_1 = create(:invoice, status: "shipped", customer: @c_1, merchant: @merchant, created_at: "2018-12-01")
      @i_1 = create(:item, merchant: @merchant)
      @t_1 = create(:transaction, invoice: @inv_1)
      @ii_1 = create(:invoice_item, unit_price: 200, quantity: 3, item: @i_1, invoice: @inv_1)
      @inv_2 = create(:invoice, status: "shipped", customer: @c_1, merchant: @merchant, created_at: "2018-12-02")
      @i_2 = create(:item, merchant: @merchant)
      @t_2 = create(:transaction, invoice: @inv_2)
      @ii_2 = create(:invoice_item, unit_price: 300, quantity: 4, item: @i_2, invoice: @inv_2)
      @inv_3 = create(:invoice, status: "shipped", customer: @c_2, merchant: @merchant, created_at: "2018-12-01")
      @i_3 = create(:item, merchant: @merchant)
      @t_3 = create(:transaction, invoice: @inv_3)
      @ii_3 = create(:invoice_item, unit_price: 100, quantity: 4, item: @i_3, invoice: @inv_3)
      @inv_4 = create(:invoice, status: "shipped", customer: @c_3, merchant: @merchant, created_at: "2018-12-03")
      @i_4 = create(:item, merchant: @merchant)
      @t_4 = create(:transaction, invoice: @inv_4, result: "failed")
      @ii_4 = create(:invoice_item, unit_price: 100, quantity: 6, item: @i_4, invoice: @inv_4)
    end

    it 'should return total revenue for successful transactions' do
      total_revenue = Merchant.total_revenue_for_successful_transactions(@merchant.id).revenue
      expect(total_revenue).to eq (2200)

    end

    it 'should return total revenue for successful transactions for specific date' do
      total_revenue = Merchant.total_revenue_for_successful_transactions_by_date(@merchant.id, "2018-12-01").revenue
      expect(total_revenue).to eq (1000)
    end

    it 'should return customer with most successful transactions' do
      customer = Merchant.favorite_customer(@merchant.id)
      expect(customer.id).to eq (@c_1.id)

    end
  end
end
