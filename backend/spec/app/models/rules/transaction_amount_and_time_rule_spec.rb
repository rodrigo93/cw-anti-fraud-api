# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::TransactionAmountAndTimeRule, type: :model do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    let(:transaction_limit) { Rules::TransactionAmountAndTimeRule::TRANSACTION_AMOUNT_LIMIT }

    context 'when transaction amount is above limit' do
      context 'and transaction time is between 20:00 and 07:00' do
        let(:transaction) do
          create :transaction,
                 transaction_amount: transaction_limit + 1,
                 transaction_date: Time.zone.now.change(hour: 21)
        end

        it { is_expected.to be_falsey }
      end

      context 'and transaction time is NOT between 20:00 and 07:00' do
        let(:transaction) do
          create :transaction,
                 transaction_amount: transaction_limit + 1,
                 transaction_date: Time.zone.now.change(hour: 19)
        end

        it { is_expected.to be_truthy }
      end
    end

    context 'when transaction amount is <= 2000' do
      let(:transaction) do
        create :transaction,
               transaction_amount: transaction_limit - 1,
               transaction_date: Time.zone.now.change(hour: 19)
      end

      it { is_expected.to be_truthy }
    end
  end
end
