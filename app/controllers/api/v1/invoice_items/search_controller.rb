class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    if params[:unit_price]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: (params[:unit_price].to_f*100).to_s))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_params))
    end
  end

  def show
    if params[:unit_price]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: (params[:unit_price].to_f*100).to_s))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_params))
    end
  end

  private

  def invoice_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at)
  end
end
