# frozen_string_literal: true

class AddIndexesToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_index :transactions, :user_id
    add_index :transactions, :created_at
    add_index :transactions, :card_number
  end
end
