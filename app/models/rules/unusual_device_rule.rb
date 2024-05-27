# frozen_string_literal: true

class Rules::UnusualDeviceRule < Rules::Base
  def apply
    return true if @transaction.device_id.blank?

    user_devices = Transaction
                   .where(user_id: @transaction.user_id)
                   .where.not(id: @transaction.id)
                   .pluck(:device_id)
                   .uniq

    return true if user_devices.empty?

    user_devices.include? @transaction.device_id
  end
end
