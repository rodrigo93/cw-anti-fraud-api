# frozen_string_literal: true

class Rules::PreviousChargebackRule < Rules::Base
  def apply
    !previous_chargeback?
  end

  private

  def previous_chargeback?
    Transaction.exists?(user_id: @transaction.user_id, has_cbk: true)
  end
end
