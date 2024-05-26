# frozen_string_literal: true


class Rules::HasCbkRule < Rules::Base
  def apply
    !@transaction.has_cbk
  end
end
