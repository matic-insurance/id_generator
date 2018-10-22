RSpec.describe IdGenerator do
  let(:generator) { described_class.new(context_id) }

  describe 'id format' do
    let(:context_id) { 999 }

    it 'has correct size' do
      expect(uniq_id.size).to eq(34)
    end

    it 'includes timestamp' do
      timestamp = Time.now.to_i - Time.new(2014).to_i
      id_timestamp = uniq_id.split('-').first.to_i(16)
      expect(id_timestamp).to be_between(timestamp, timestamp+2)
    end

    it 'include project id' do
      expect(uniq_id).to include("-#{context_id}-")
    end
  end

  describe '#generate' do
    context 'with valid project id' do
      let(:context_id) { 999 }

      it 'generates random id every time' do
        expect(uniq_id).to_not eq(uniq_id)
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

  protected

  def uniq_id
    generator.generate
  end
end
