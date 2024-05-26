# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :merchant_id
      t.integer :user_id
      t.string :card_number
      t.datetime :transaction_date
      t.decimal :transaction_amount
      t.string :device_id
      t.boolean :has_cbk, default: false

      t.timestamps
    end
  end
end
