# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::UnusualDeviceRule, type: :model do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    let(:user_id) { 345 }
    let(:transaction) { create :transaction, user_id: }

    context 'when transaction device is not present' do
      let(:transaction) { create :transaction, user_id:, device_id: nil }

      it { is_expected.to be_truthy }
    end

    context 'when user has no other transactions' do
      let(:transaction) { create :transaction, user_id: }

      it { is_expected.to be_truthy }
    end

    context 'when user has other transactions with different devices' do
      before { create :transaction, user_id:, device_id: 'other_device' }

      let(:transaction) { create :transaction, user_id: }

      it { is_expected.to be_falsey }
    end

    context 'when user has other transactions with the same device' do
      before { create :transaction, user_id:, device_id: transaction.device_id }

      it { is_expected.to be_truthy }
    end

    context 'when user has other transactions with the same device but different transaction_id' do
      before { create :transaction, user_id:, device_id: 'device1' }

      let(:transaction) { create :transaction, user_id:, device_id: 'device1' }

      it { is_expected.to be_truthy }
    end
  end
end
