# frozen_string_literal: true

require 'rails_helper'
require 'rack/test'

RSpec.describe Rack::Attack do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  context 'throttle excessive requests by IP address' do
    let(:limit) { 100 }
    let(:period) { 300 }

    context 'number of requests is lower than the limit' do
      it 'does not change the request status' do
        limit.times do
          get 'status/check'
        end

        expect(last_response.status).not_to eq(429)
      end
    end

    context 'number of requests is higher than the limit' do
      it 'changes the request status to 429' do
        (limit + 1).times do
          get 'status/check'
        end

        expect(last_response.status).to eq(429)
      end
    end
  end
end
