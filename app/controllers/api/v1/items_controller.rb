class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_id]
      binding.pry
      render json: ItemSerializer.new(Item.joins(:invoice_items).where(invoice_items: {invoice_id: params[:invoice_id]}))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

end
