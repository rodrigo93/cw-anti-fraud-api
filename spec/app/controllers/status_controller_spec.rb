# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusController, type: :controller do
  describe 'GET #check' do
    subject { get :check }

    it 'returns 200' do
      subject

      expect(response).to have_http_status :ok
      expect(parsed_body_response).to eq({ 'status' => 'ok' })
    end
  end
end
