class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:unit_price]
      render json: ItemSerializer.new(Item.where(unit_price: (params[:unit_price].to_f*100).to_s))
    else
      render json: ItemSerializer.new(Item.where(item_params))
    end
  end

  def show
    if params[:unit_price]
      render json: ItemSerializer.new(Item.find_by(unit_price: (params[:unit_price].to_f*100).to_s))
    else
      render json: ItemSerializer.new(Item.find_by(item_params))
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
