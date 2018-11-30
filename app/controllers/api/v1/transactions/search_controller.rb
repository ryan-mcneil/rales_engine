class Api::V1::Transactions::SearchController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.where(invoice_params))
  end

  def show
    render json: TransactionSerializer.new(Transaction.find_by(invoice_params))
  end

  private

  def invoice_params
    params.permit(:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at)
  end
end
