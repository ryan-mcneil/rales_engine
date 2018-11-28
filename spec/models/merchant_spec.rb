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
      m_1, m_2, m_3 = create_list(:merchant, 3)
      inv = create(:invoice, status: "shipped")
      i_1 = create(:item, merchant: m_1)
      ii_1 = create(:invoice_item, unit_price: 200, quantity: 3, item: i_1, invoice: inv)
      i_2 = create(:item, merchant: m_1)
      ii_2 = create(:invoice_item, unit_price: 300, quantity: 4, item: i_2, invoice: inv)
      i_3 = create(:item, merchant: m_2)
      ii_3 = create(:invoice_item, unit_price: 100, quantity: 4, item: i_3, invoice: inv)
      i_4 = create(:item, merchant: m_3)
      ii_4 = create(:invoice_item, unit_price: 100, quantity: 6, item: i_4, invoice: inv)
    end

    it 'returns top x merchants ranked by total revenue' do

      top_merchants = Merchant.most_revenue(2)

      expect(top_merchants.count).to eq(2)
      expect(top_merchants[0].id).to eq(i_1.id)
      expect(top_merchants[1].id).to eq(i_3.id)
    end
  end
end
