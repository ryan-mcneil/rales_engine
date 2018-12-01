class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.all
    # render json: MerchantSerializer.new(Merchant.revenue(params[:date]))
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
