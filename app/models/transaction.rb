# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :card_number,
            :merchant_id,
            :user_id,
            :transaction_amount,
            :transaction_date,
            :transaction_id, presence: true

  validates :transaction_id, uniqueness: true

  def approve?
    rules.all?(&:apply)
  end

  private

  def rules
    [
      Rules::HasCbkRule.new(self),
      Rules::MultipleTransactionsRule.new(self),
      Rules::RepeatedCardNumberRule.new(self),
      Rules::TransactionAmountAndTimeRule.new(self),
      Rules::UnusualDeviceRule.new(self),
      Rules::PreviousChargebackRule.new(self)
    ]
  end
end
