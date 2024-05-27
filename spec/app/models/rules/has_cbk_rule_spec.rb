# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::HasCbkRule do
  describe '#apply' do
    subject { described_class.new(transaction).apply }

    context 'when Transaction "has_cbk" is true' do
      let(:transaction) { create :transaction, has_cbk: true }

      it { is_expected.to be_falsey }
    end

    context 'when Transaction "has_cbk" is false' do
      let(:transaction) { create :transaction, has_cbk: false }

      it { is_expected.to be_truthy }
    end
  end
end
