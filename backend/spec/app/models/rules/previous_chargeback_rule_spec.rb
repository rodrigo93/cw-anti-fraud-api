# frozen_string_literal: true

# spec/models/rules/previous_chargeback_rule_spec.rb

require 'rails_helper'

RSpec.describe Rules::PreviousChargebackRule, type: :model do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    let(:user_id) { 4567 }
    let(:transaction) { create :transaction, user_id: }

    context 'when the user has a previous chargeback' do
      before { create :transaction, user_id:, has_cbk: true }

      it { is_expected.to be_falsey }
    end

    context 'when the user does not have a previous chargeback' do
      it { is_expected.to be_truthy }
    end
  end
end
