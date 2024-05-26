# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  describe 'GET /check' do
    it 'returns http success' do
      get '/transactions/check'
      expect(response).to have_http_status(:success)
    end
  end
end
