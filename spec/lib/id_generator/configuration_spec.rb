require 'spec_helper'

RSpec.describe IdGenerator::Configuration do
  describe '#context_id' do
    let(:configuration) { described_class.new(context_id: context_id) }
    let(:context_id) { rand(255) }

    it 'returns initialized value' do
      expect(configuration.context_id).to eq(context_id)
    end

    describe 'validation' do
      let(:error) { IdGenerator::Errors::InvalidContextId }

      it 'allows empty' do
        expect { described_class.new }.not_to raise_error
      end

      it 'allows 0' do
        expect { described_class.new(context_id: 0) }.not_to raise_error
      end

      it 'allows 255' do
        expect { described_class.new(context_id: 255) }.not_to raise_error
      end

      it 'rejects negative values' do
        expect { described_class.new(context_id: -1) }.to raise_error(error, 'Invalid context id')
      end

      it 'rejects large values' do
        expect { described_class.new(context_id: rand(256..1000)) }.to raise_error(error, 'Invalid context id')
      end

      it 'rejects empty values' do
        expect { described_class.new(context_id: nil) }.to raise_error(error, 'Invalid context id')
      end

      it 'rejects invalid values' do
        expect { described_class.new(context_id: 'id') }.to raise_error(error, 'Invalid context id')
      end
    end
  end
end
