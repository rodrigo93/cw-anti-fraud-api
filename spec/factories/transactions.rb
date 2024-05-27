# frozen_string_literal: true

# spec/factories/transactions.rb

FactoryBot.define do
  factory :transaction do
    transaction_id { Faker::Number.number(digits: 5) }
    merchant_id { Faker::Number.number(digits: 5) }
    user_id { Faker::Number.number(digits: 5) }
    card_number { Faker::Finance.credit_card.gsub(/.(?=....)/, '*') }
    transaction_date { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    transaction_amount { Faker::Number.decimal(l_digits: 2) }
    device_id { Faker::Number.number(digits: 5) }
    has_cbk { false }
  end
end
