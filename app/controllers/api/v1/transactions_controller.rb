class Api::V1::TransactionsController < ApplicationController
  def index
    if params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:invoice_id]))
    elsif params[:customer_id]
      render json: TransactionSerializer.new(Transaction.joins(:invoice).where(invoices: {customer_id: params[:customer_id]}))
    else
      render json: TransactionSerializer.new(Transaction.all)
    end
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end
end
