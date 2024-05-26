# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'csv'

# Seed transactions
current_transactions_amount = Transaction.count
puts "Seeding transactions. Current transactions amount: #{current_transactions_amount}."

CSV.foreach('spec/fixtures/transactional-sample.csv', headers: true) do |row|
  Transaction.find_or_create_by(
    transaction_id: row[0],
    merchant_id: row[1],
    user_id: row[2],
    card_number: row[3],
    transaction_date: row[4],
    transaction_amount: row[5],
    device_id: row[6],
    has_cbk: row[7] == 'TRUE'
  )
end

new_transactions_amount = Transaction.count - current_transactions_amount
puts "Created #{new_transactions_amount} new transactions."
