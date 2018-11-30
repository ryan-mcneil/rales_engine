require 'rails_helper'

describe 'Invoices API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end

  it 'can get an invoice by id' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can get an invoice by id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["id"]).to eq(invoice.id)
  end

  it 'can get an invoice by merchant_id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["merchant_id"]).to eq(invoice.merchant_id)
  end

  it 'can get an invoice by customer_id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["customer_id"]).to eq(invoice.customer_id)
  end

  it 'can get an invoice by status' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["status"]).to eq(invoice.status)
  end

  it 'can get an invoice by created_at' do
    invoice = create(:invoice, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find?created_at=2012-03-27T14:54:05.000Z"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["id"]).to eq(invoice.id)
  end

  it 'can get an invoice by updated_at' do
    invoice = create(:invoice, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find?updated_at=2012-03-27T14:54:05.000Z"

    invoice_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_data["data"]["attributes"]["id"]).to eq(invoice.id)
  end

  it 'can find all invoices by id' do
    invoice_1, invoice_2 = create_list(:invoice, 2)

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(1)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find all invoices by merchant_id' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    invoice_1, invoice_2 = create_list(:invoice, 2, merchant: merchant_1)
    invoice_3 = create(:invoice, merchant: merchant_2)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice_1.merchant_id}"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find all invoices by customer_id' do
    customer_1, customer_2 = create_list(:customer, 2)
    invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer_1)
    invoice_3 = create(:invoice, customer: customer_2)

    get "/api/v1/invoices/find_all?customer_id=#{invoice_1.customer_id}"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find all invoices by status' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    invoice_3 = create(:invoice, status: "shipped")

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find all invoices by created_at' do
    invoice_1, invoice_2 = create_list(:invoice, 2, created_at: "2012-03-27 14:54:05 UTC")
    invoice_3 = create(:invoice)

    get "/api/v1/invoices/find_all?created_at=2012-03-27T14:54:05.000Z"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find all invoices by updated_at' do
    invoice_1, invoice_2 = create_list(:invoice, 2, updated_at: "2012-03-27 14:54:05 UTC")
    invoice_3 = create(:invoice)

    get "/api/v1/invoices/find_all?updated_at=2012-03-27T14:54:05.000Z"

    invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["id"]).to eq(invoice_1.id)
  end

  it 'can find a random invoice' do
    invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice.count).to eq(1)
  end
end
