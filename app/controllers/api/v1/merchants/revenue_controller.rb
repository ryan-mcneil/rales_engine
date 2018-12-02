class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantTotalRevenueSerializer.new(Merchant.revenue_by_date(params[:date]))
  end

  def show
    if params[:date]

    else
      render json: MerchantRevenueSerializer.new(Merchant.find(params[:id]).total_revenue_for_successful_tranactions)
    end
  end
end
