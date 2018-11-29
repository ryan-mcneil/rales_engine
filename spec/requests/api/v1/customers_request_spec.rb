require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  it 'can get a customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it 'can get a customer by id' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    customer_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer_data["data"]["attributes"]["id"]).to eq(customer.id)
  end

  it 'can get a customer by first_name' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    customer_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer_data["data"]["attributes"]["first_name"]).to eq(customer.first_name)
  end

  it 'can get a customer by last_name' do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    customer_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer_data["data"]["attributes"]["last_name"]).to eq(customer.last_name)
  end

  it 'can get a customer by created_at' do
    customer = create(:customer, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/customers/find?created_at=2012-03-27T14:54:05.000Z"

    customer_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer_data["data"]["attributes"]["id"]).to eq(customer.id)
  end

  it 'can get a customer by updated_at' do
    customer = create(:customer, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/customers/find?updated_at=2012-03-27T14:54:05.000Z"

    customer_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer_data["data"]["attributes"]["id"]).to eq(customer.id)
  end
end
