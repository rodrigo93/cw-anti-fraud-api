# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'POST #check' do
    subject { post :check, params: request_payload }

    let(:request_payload) do
      {
        transaction_id: transaction.transaction_id,
        merchant_id: transaction.merchant_id,
        user_id: transaction.user_id,
        card_number: transaction.card_number,
        transaction_date: transaction.transaction_date,
        transaction_amount: transaction.transaction_amount,
        device_id: transaction.device_id
      }
    end

    context "when it's not a fraudulent transaction" do
      let(:transaction) { create :transaction, has_cbk: false }

      it 'returns an approved response' do
        subject

        expect(response).to have_http_status :success
        expect(parsed_body_response).to eq({
                                             'transaction_id' => transaction.transaction_id,
                                             'recommendation' => 'approve'
                                           })
      end
    end

    context "when it's a fraudulent transaction" do
      let(:transaction) { create :transaction, has_cbk: true }

      it 'returns an approved response' do
        subject

        expect(response).to have_http_status :success
        expect(parsed_body_response).to eq({
                                             'transaction_id' => transaction.transaction_id,
                                             'recommendation' => 'deny'
                                           })
      end
    end

    context 'when the transaction already exists' do
      let!(:transaction) { create :transaction }

      it 'does not create a new transaction' do
        expect { subject }.not_to change(Transaction, :count)
      end
    end

    context 'when the transaction is invalid' do
      let(:transaction) { build :transaction, card_number: nil }

      it 'returns an error response' do
        subject

        expect(response).to have_http_status :unprocessable_entity
        expect(parsed_body_response).to eq({ 'error' => 'Validation failed: Card number can\'t be blank' })
      end
    end
  end
end
