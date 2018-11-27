require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe 'Instance Methods' do

    before(:each) do
      
    end
  end
end
