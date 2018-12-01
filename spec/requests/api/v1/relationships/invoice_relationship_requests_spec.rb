require 'rails_helper'

describe 'nested invoice resources API' do
  it 'sends transactions specific to an invoice' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_2)

    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(2)
  end

  it 'sends invoice_items specific to an invoice' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, invoice: invoice_1)
    invoice_item_3 = create(:invoice_item, invoice: invoice_2)

    get "/api/v1/invoices/#{invoice_1.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(2)
  end

  it 'sends items specific to an invoice' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    item_1, item_2, item_3 = create_list(:item, 3)
    invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1)
    invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3)

    get "/api/v1/invoices/#{invoice_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end
end
