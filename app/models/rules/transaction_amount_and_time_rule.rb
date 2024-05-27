# frozen_string_literal: true

class Rules::TransactionAmountAndTimeRule < Rules::Base
  TRANSACTION_AMOUNT_LIMIT = 2_000

  def apply
    !(transaction_amount_exceeds_limit? && transaction_time_in_range?)
  end

  private

  def transaction_amount_exceeds_limit?
    @transaction.transaction_amount > TRANSACTION_AMOUNT_LIMIT
  end

  def transaction_time_in_range?
    transaction_time = @transaction.transaction_date.to_time
    transaction_time.between?(transaction_time.change(hour: 20), transaction_time.change(hour: 7) + 1.day)
  end
end
