RSpec.describe IdGenerator do
  let(:generator) { described_class.new(context_id) }

  describe '#generate' do
    subject(:uniq_id) { generator.generate }

    context 'with valid project id' do
      let(:context_id) { 999 }

      it 'generates uniq id with correct size' do
        expect(uniq_id.size).to eq(34)
      end

      it 'generates uniq id that include projec id' do
        expect(uniq_id).to include("-#{context_id}-")
      end
    end

    context 'with invalid project id' do
      let(:context_id) { nil }

      it 'raises exception' do
        expect { uniq_id }.to raise_error(IdGenerator::Error,
                                          'Invalid project id')
      end
    end
  end
end
