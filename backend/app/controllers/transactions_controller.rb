# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction

  def check
    if @transaction.approve?
      render json: { transaction_id: @transaction.transaction_id, recommendation: 'approve' }
    else
      render json: { transaction_id: @transaction.transaction_id, recommendation: 'deny' }
    end
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
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
