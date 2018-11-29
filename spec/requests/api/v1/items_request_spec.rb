require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it 'sends a single item by id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find an item by id' do
    id = create(:item).id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find an item by name' do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it 'can find an item by description' do
    description = create(:item).description

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["description"]).to eq(description)
  end

  it 'can find an item by unit_price' do
    unit_price = create(:item).unit_price

    get "/api/v1/items/find?unit_price=#{unit_price}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["unit_price"]).to eq(unit_price.to_f/100)
  end

  it 'can find an item by merchant_id' do
    merchant_id = create(:item).merchant_id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it 'can find an item by created_at' do
    item = create(:item, created_at: "2012-03-27 14:54:05 UTC")
    get "/api/v1/items/find?created_at=2012-03-27T14:54:05.000Z"

    item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item_data["data"]["attributes"]["id"]).to eq(item.id)
  end

  it 'can find an item by updated_at' do
    item = create(:item, updated_at: "2012-03-27 14:54:05 UTC")
    get "/api/v1/items/find?updated_at=2012-03-27T14:54:05.000Z"

    item_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item_data["data"]["attributes"]["id"]).to eq(item.id)
  end

  it 'can find all items by id' do
    item_1, item_2 = create_list(:item, 2)

    get "/api/v1/items/find_all?id=#{item_1.id}"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(1)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by name' do
    item_1, item_2 = create_list(:item, 2, name: "Bob")
    item_3 = create(:item, name: "Jim")

    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by description' do
    item_1, item_2 = create_list(:item, 2, description: "Bob")
    item_3 = create(:item, description: "Jim")

    get "/api/v1/items/find_all?description=#{item_1.description}"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by unit_price' do
    item_1, item_2 = create_list(:item, 2, unit_price: 300)
    item_3 = create(:item, unit_price: 200)

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by merchant_id' do
    merchant_1, merchant_2 = create_list(:merchant, 2)
    item_1, item_2 = create_list(:item, 2, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_2)

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by created_at' do
    item_1, item_2 = create_list(:item, 2, created_at: "2012-03-27 14:54:05 UTC")
    item_3 = create(:item)

    get "/api/v1/items/find_all?created_at=2012-03-27T14:54:05.000Z"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find all items by updated_at' do
    item_1, item_2 = create_list(:item, 2, updated_at: "2012-03-27 14:54:05 UTC")
    item_3 = create(:item)

    get "/api/v1/items/find_all?updated_at=2012-03-27T14:54:05.000Z"

    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
  end

  it 'can find a random item' do
    item_1, item_2, item_3 = create_list(:item, 3)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item.count).to eq(1)
  end

end
