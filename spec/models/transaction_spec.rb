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

    let(:transaction) { create :transaction }

    context 'when all rules apply' do
      before { allow_any_instance_of(Rules::Base).to receive(:apply).and_return(true) }

      it { is_expected.to be_truthy }
    end

    context 'when any rule does not apply' do
      before { allow_any_instance_of(Rules::HasCbkRule).to receive(:apply).and_return(false) }

      it { is_expected.to be_falsey }
    end
  end
end
