require 'rails_helper'

describe 'InvoiceItems API' do
  it 'sends a list of invoice_items' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end

  it 'can get an invoice_item by id' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can get an invoice_item by id' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["id"]).to eq(invoice_item.id)
  end

  it 'can get an invoice_item by item_id' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["item_id"]).to eq(invoice_item.item_id)
  end

  it 'can get an invoice_item by invoice_id' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["invoice_id"]).to eq(invoice_item.invoice_id)
  end

  it 'can get an invoice_item by quantity' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["quantity"]).to eq(invoice_item.quantity)
  end

  it 'can get an invoice_item by unit_price' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=#{(invoice_item.unit_price/100.00).to_s}"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["unit_price"]).to eq((invoice_item.unit_price/100.00).to_s)
  end

  it 'can get an invoice_item by created_at' do
    invoice_item = create(:invoice_item, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find?created_at=2012-03-27T14:54:05.000Z"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["id"]).to eq(invoice_item.id)
  end

  it 'can get an invoice_item by updated_at' do
    invoice_item = create(:invoice_item, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find?updated_at=2012-03-27T14:54:05.000Z"

    invoice_item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item_data["data"]["attributes"]["id"]).to eq(invoice_item.id)
  end

  it 'can find all invoice_items by id' do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(1)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by item_id' do
    item_1, item_2 = create_list(:item, 2)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, item: item_1)
    invoice_item_3 = create(:invoice_item, item: item_2)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by invoice_id' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, invoice: invoice_1)
    invoice_item_3 = create(:invoice_item, invoice: invoice_2)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by quantity' do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, quantity: 3)
    invoice_item_3 = create(:invoice_item, quantity: 4)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by unit_price' do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, unit_price: 300)
    invoice_item_3 = create(:invoice_item, unit_price: 200)

    get "/api/v1/invoice_items/find_all?unit_price=#{(invoice_item_1.unit_price/100.00).to_s}"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by created_at' do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, created_at: "2012-03-27 14:54:05 UTC")
    invoice_item_3 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?created_at=2012-03-27T14:54:05.000Z"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find all invoice_items by updated_at' do
    invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, updated_at: "2012-03-27 14:54:05 UTC")
    invoice_item_3 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?updated_at=2012-03-27T14:54:05.000Z"

    invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
  end

  it 'can find a random invoice_item' do
    invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item.count).to eq(1)
  end
end
