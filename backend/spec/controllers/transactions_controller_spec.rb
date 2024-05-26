# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'POST #check' do
    subject { post :check, params: request_payload }

    let(:request_payload) do
      {
        transaction_id: 2_342_357,
        merchant_id: 29_744,
        user_id: 97_051,
        card_number: '434505******9116',
        transaction_date: '2019-11-31T23:16:32.812632',
        transaction_amount: 373,
        device_id: 285_475
      }
    end

    it 'returns http success' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct transaction_id' do
      subject

      expect(parsed_body_response['transaction_id']).to eq(2_342_357)
    end

    it 'returns the correct recommendation' do
      subject

      expect(parsed_body_response['recommendation']).to eq('approve')
    end

    context 'when the transaction already exists' do
      let!(:transaction) { create :transaction, request_payload }

      it 'does not create a new transaction' do
        expect { subject }.not_to change(Transaction, :count)
      end
    end
  end
end
