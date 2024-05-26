# frozen_string_literal: true

class Rules::MultipleTransactionsRule < Rules::Base
  TRANSACTION_LIMIT = 5
  TIME_PERIOD = 1.hour

  def apply
    user_transactions = Transaction.where(
      user_id: @transaction.user_id,
      created_at: (Time.zone.now - TIME_PERIOD)..Time.zone.now
    )

    user_transactions.count <= TRANSACTION_LIMIT
  end
end
