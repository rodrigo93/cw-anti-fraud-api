# frozen_string_literal: true

class AddTransactionIdToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :transaction_id, :integer
  end
end
