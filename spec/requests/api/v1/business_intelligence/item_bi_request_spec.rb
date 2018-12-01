require 'rails_helper'

describe 'Item Business Intelligence' do
  describe 'All Items' do

    it 'should send top x items by revenue generated' do
      get '/api/v1/items/most_revenue?quantity=2'

      expect(response).to be_successful
      total_revenue = JSON.parse(response.body)
    end

    it 'should send top x items by number sold' do
      get '/api/v1/items/most_items?quantity=2'

      expect(response).to be_successful
      top_items = JSON.parse(response.body)
    end
  end

  describe 'single Item' do

    before(:each) do
      @item = create(:item)
    end

    it 'should return date with the most sales by invoice date' do
      get "/api/v1/items/#{@item.id}/best_day"

      expect(response).to be_successful
      best_day = JSON.parse(response.body)
    end

  end

end
