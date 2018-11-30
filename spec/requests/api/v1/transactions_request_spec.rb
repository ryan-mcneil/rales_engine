require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end

  it 'can get an transaction by id' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can get an transaction by id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["id"]).to eq(transaction.id)
  end

  it 'can get an transaction by invoice_id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["invoice_id"]).to eq(transaction.invoice_id)
  end

  it 'can get an transaction by credit_card_number' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["credit_card_number"]).to eq(transaction.credit_card_number)
  end

  it 'can get an transaction by result' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{transaction.result}"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["result"]).to eq(transaction.result)
  end

  it 'can get an transaction by created_at' do
    transaction = create(:transaction, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/transactions/find?created_at=2012-03-27T14:54:05.000Z"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["id"]).to eq(transaction.id)
  end

  it 'can get an transaction by updated_at' do
    transaction = create(:transaction, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/transactions/find?updated_at=2012-03-27T14:54:05.000Z"

    transaction_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction_data["data"]["attributes"]["id"]).to eq(transaction.id)
  end

  it 'can find all transactions by id' do
    transaction_1, transaction_2 = create_list(:transaction, 2)

    get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find all transactions by invoice_id' do
    invoice_1, invoice_2 = create_list(:invoice, 2)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_2)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find all transactions by credit_card_number' do
    transaction_1, transaction_2 = create_list(:transaction, 2, credit_card_number: "1234123412341234")
    transaction_3 = create(:transaction, credit_card_number: "1234123412341235")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find all transactions by result' do
    transaction_1, transaction_2 = create_list(:transaction, 2)
    transaction_3 = create(:transaction, result: "failed")

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find all transactions by created_at' do
    transaction_1, transaction_2 = create_list(:transaction, 2, created_at: "2012-03-27 14:54:05 UTC")
    transaction_3 = create(:transaction)

    get "/api/v1/transactions/find_all?created_at=2012-03-27T14:54:05.000Z"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find all transactions by updated_at' do
    transaction_1, transaction_2 = create_list(:transaction, 2, updated_at: "2012-03-27 14:54:05 UTC")
    transaction_3 = create(:transaction)

    get "/api/v1/transactions/find_all?updated_at=2012-03-27T14:54:05.000Z"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
  end

  it 'can find a random transaction' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(transaction.count).to eq(1)
  end
end
