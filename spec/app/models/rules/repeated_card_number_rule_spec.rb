# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::RepeatedCardNumberRule, type: :model do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    let(:user_id) { 678 }
    let(:transaction) { create :transaction, user_id:, card_number: '1234567890' }
    let(:transaction_limit) { described_class::TRANSACTION_LIMIT }

    context 'when there are no recent transactions with the same card number' do
      it { is_expected.to be_truthy }
    end

    context 'when there are less than TRANSACTION_LIMIT recent transactions with the same card number' do
      before { create_list :transaction, transaction_limit - 2, user_id:, card_number: '1234567890' }

      it { is_expected.to be_truthy }
    end

    context 'when there are exactly TRANSACTION_LIMIT recent transactions with the same card number' do
      before { create_list :transaction, transaction_limit - 1, user_id:, card_number: '1234567890' }

      it { is_expected.to be_truthy }
    end

    context 'when there are more than TRANSACTION_LIMIT recent transactions with the same card number' do
      before { create_list :transaction, transaction_limit + 1, user_id:, card_number: '1234567890' }

      it { is_expected.to be_falsey }
    end
  end
end
