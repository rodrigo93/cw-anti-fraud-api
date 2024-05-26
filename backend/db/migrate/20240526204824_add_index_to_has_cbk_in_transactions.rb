# frozen_string_literal: true

class AddIndexToHasCbkInTransactions < ActiveRecord::Migration[7.1]
  def change
    add_index :transactions, :has_cbk
  end
end
