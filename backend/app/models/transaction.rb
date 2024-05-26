# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :card_number,
            :merchant_id,
            :user_id,
            :transaction_amount,
            :transaction_date,
            :transaction_id, presence: true

  validates :transaction_id, uniqueness: true
end
