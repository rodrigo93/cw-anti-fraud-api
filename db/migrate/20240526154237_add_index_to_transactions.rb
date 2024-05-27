# frozen_string_literal: true

class AddIndexToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_index :transactions, :transaction_id, unique: true
  end
end
