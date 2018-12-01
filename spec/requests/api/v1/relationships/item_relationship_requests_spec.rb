require 'rails_helper'

describe 'nested item resources API' do
  it 'sends invoice_items specific to an item' do
    item_1, item_2 = create_list(:item, 2)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, item: item_1)
    invoice_item_3 = create(:invoice_item, item: item_2)

    get "/api/v1/items/#{item_1.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(2)
  end

  it 'sends the merchant specific to an item' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    item = create(:item, merchant: merchant_1)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["id"]).to eq(merchant_1.id)
  end
end
