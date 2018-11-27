class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: Merchant.find_by(name: params[:name]) if params[:name]
    render json: Merchant.find_by(id: params[:id]) if params[:id]
    render json: Merchant.find_by(created_at: params[:created_at]) if params[:created_at]
  end
end
