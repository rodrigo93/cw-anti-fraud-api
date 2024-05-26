# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :merchant_id }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :card_number }
    it { is_expected.to validate_presence_of :transaction_id }
    it { is_expected.to validate_presence_of :transaction_date }
    it { is_expected.to validate_presence_of :transaction_amount }

    it { is_expected.to validate_uniqueness_of :transaction_id }
  end

  describe '#approve?' do
    subject { transaction.approve? }

    context 'when "has_cbk" is true' do
      let(:transaction) { create :transaction, has_cbk: true }

      it { is_expected.to be_falsey }
    end

    context 'when "has_cbk" is false' do
      let(:transaction) { create :transaction, has_cbk: false }

      it { is_expected.to be_truthy }
    end

    context 'when "transaction_amount" exceeds limit within night time' do
      let(:transaction) { create :transaction, transaction_amount: 2_001, transaction_date: '2024-05-26 21:00' }

      it { is_expected.to be_falsey }
    end

    context 'when "transaction_amount" exceeds limit outside night time' do
      let(:transaction) { create :transaction, transaction_amount: 2_001, transaction_date: '2024-05-26 08:00' }

      it { is_expected.to be_truthy }
    end
  end
end
