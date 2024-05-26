# frozen_string_literal: true

module Rack
  class Attack
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    throttle(
      'req/ip',
      limit: ENV.fetch('THROTTLE_LIMIT', 100).to_i,
      period: ENV.fetch('THROTTLE_PERIOD_SECONDS', 60).to_i.seconds,
      &:ip
    )
  end
end
