# frozen_string_literal: true

class Rules::RepeatedCardNumberRule < Rules::Base
  TRANSACTION_LIMIT = 5
  TIME_PERIOD = 1.hour

  def apply
    recent_transactions = Transaction.where(
      'card_number = ? AND created_at > ?',
      @transaction.card_number,
      Time.zone.now - TIME_PERIOD
    )

    recent_transactions.count <= TRANSACTION_LIMIT
  end
end
