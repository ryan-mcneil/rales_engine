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
      @inv_1 = create(:invoice, status: "shipped", merchant: @m_1)
      @i_1 = create(:item, merchant: @m_1)
      @t_1 = create(:transaction, invoice: @inv_1)
      @ii_1 = create(:invoice_item, unit_price: 200, quantity: 3, item: @i_1, invoice: @inv_1)
      @inv_2 = create(:invoice, status: "shipped", merchant: @m_1)
      @i_2 = create(:item, merchant: @m_1)
      @t_2 = create(:transaction, invoice: @inv_2)
      @ii_2 = create(:invoice_item, unit_price: 300, quantity: 4, item: @i_2, invoice: @inv_2)
      @inv_3 = create(:invoice, status: "shipped", merchant: @m_2)
      @i_3 = create(:item, merchant: @m_2)
      @t_3 = create(:transaction, invoice: @inv_3)
      @ii_3 = create(:invoice_item, unit_price: 100, quantity: 4, item: @i_3, invoice: @inv_3)
      @inv_4 = create(:invoice, status: "shipped", merchant: @m_3)
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
  end
end
