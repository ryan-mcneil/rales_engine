require 'rails_helper'

describe 'Customer Business Intelligence' do


  describe 'single Customer' do
    before(:each) do
      @customer = create(:customer)
    end

    it 'should return merchant with most successful transactions' do
      get "/api/v1/customers/#{@customer.id}/favorite_merchant"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)
    end
  end
end
