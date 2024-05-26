# frozen_string_literal: true

class Rules::Base
  def initialize(transaction)
    @transaction = transaction
  end

  def apply
    raise NotImplementedError, 'You must implement the `apply` method'
  end
end
