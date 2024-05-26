# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates_presence_of :card_number,
    :merchant_id,
    :user_id,
    :transaction_id,
    :transaction_amount,
    :transaction_date

  validates_uniqueness_of :transaction_id
end
