# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates_presence_of :card_number,
    :merchant_id,
    :user_id,
    :transaction_id,
    :transaction_amount,
    :transaction_date
end
