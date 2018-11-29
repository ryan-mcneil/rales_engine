require 'rails_helper'

describe 'Items API' do
  xit 'sends a list of items' do
    create_list(:items, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end
end
