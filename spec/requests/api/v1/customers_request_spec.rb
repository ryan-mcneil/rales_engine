require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
  end

  it 'can get a customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["id"]).to eq(id)
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

  it 'can find all customers by id' do
    customer_1, customer_2 = create_list(:customer, 2)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(1)
    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
  end

  it 'can find all customers by first_name' do
    customer_1, customer_2 = create_list(:customer, 2, first_name: "Bob")
    customer_3 = create(:customer, first_name: "Jim")

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
  end

  it 'can find all customers by last_name' do
    customer_1, customer_2 = create_list(:customer, 2, last_name: "Bob")
    customer_3 = create(:customer, last_name: "Jim")

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
  end

  it 'can find all customers by created_at' do
    customer_1, customer_2 = create_list(:customer, 2, created_at: "2012-03-27 14:54:05 UTC")
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?created_at=2012-03-27T14:54:05.000Z"

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
  end

  it 'can find all customers by updated_at' do
    customer_1, customer_2 = create_list(:customer, 2, updated_at: "2012-03-27 14:54:05 UTC")
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?updated_at=2012-03-27T14:54:05.000Z"

    customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["id"]).to eq(customer_1.id)
  end

  it 'can find a random customer' do
    customer_1, customer_2, customer_3 = create_list(:customer, 3)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer.count).to eq(1)
  end
end
