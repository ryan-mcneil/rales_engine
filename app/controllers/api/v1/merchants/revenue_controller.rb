class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantTotalRevenueSerializer.new(Merchant.revenue_by_date(params[:date]))
  end

  def show
    if params[:date]
      render json: MerchantRevenueSerializer.new(Merchant.total_revenue_for_successful_transactions_by_date(params[:id], params[:date]))
    else
      render json: MerchantRevenueSerializer.new(Merchant.total_revenue_for_successful_transactions(params[:id]))
    end
  end
end
