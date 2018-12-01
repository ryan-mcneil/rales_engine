require 'rails_helper'

describe 'nested invoice_item resource API' do

    it 'sends the invoice specific to an invoice_item' do
      invoice_1, invoice_2 = create_list(:invoice, 2)
      invoice_item = create(:invoice_item, invoice: invoice_1)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)
      expect(invoice["data"]["attributes"]["id"]).to eq(invoice_1.id)
    end

    it 'sends the item specific to an invoice_item' do
      item_1, item_2 = create_list(:item, 2)
      invoice_item = create(:invoice_item, item: item_1)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      expect(response).to be_successful

      item = JSON.parse(response.body)
      expect(item["data"]["attributes"]["id"]).to eq(item_1.id)
    end
end
