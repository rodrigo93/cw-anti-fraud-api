# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction

  def check
    render json: {
      transaction_id: 2_342_357,
      recommendation: 'approve'
    }, status: :ok
  end

  private

  def transaction_params
    params.permit(
      :transaction_id,
      :card_number,
      :device_id,
      :merchant_id,
      :transaction_amount,
      :transaction_date,
      :user_id
    )
  end

  def set_transaction
    @transaction = Transaction.find_or_create_by!(transaction_params)
  end
end
