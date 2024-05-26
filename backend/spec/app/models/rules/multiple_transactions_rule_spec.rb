# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::MultipleTransactionsRule, type: :model do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    let(:user_id) { 123 }
    let(:transaction) { create :transaction, user_id: 123 }
    let(:transaction_limit) { described_class::TRANSACTION_LIMIT }

    context 'when user has made less than the limit transactions in the given time period' do
      before { create_list :transaction, transaction_limit - 2, user_id: }

      it { is_expected.to be_truthy }
    end

    context 'when user has made exactly the limit transactions in the given time period' do
      # Minus 1 as it creates another transaction in the subject
      before { create_list :transaction, transaction_limit - 1, user_id: }

      it { is_expected.to be_truthy }
    end

    context 'when user has made more than the limit transactions in the given time period' do
      before { create_list :transaction, transaction_limit + 1, user_id: }

      it { is_expected.to be_falsey }
    end

    context 'when user has made transactions in the past, but not within the given time period' do
      before do
        travel_to (described_class::TIME_PERIOD + 1.minute).from_now do
          create_list :transaction, transaction_limit + 1, user_id:
        end
      end

      it { is_expected.to be_truthy }
    end
  end
end
