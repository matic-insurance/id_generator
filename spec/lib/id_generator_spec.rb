RSpec.describe IdGenerator do
  let(:generator) { described_class.new(context_id) }

  describe 'id format' do
    let(:context_id) { rand(255) }
    let(:parts) { uniq_id.split('-') }

    it 'has correct size' do
      expect(uniq_id.size).to eq(34)
    end

    it 'has correct format' do
      expect(uniq_id).to match(/^[a-z0-9\-]+$/)
    end

    it 'has 2 separators' do
      expect(parts.size).to eq(3)
    end

    it 'has correct timestamp size' do
      expect(parts[0].size).to eq(8)
    end

    it 'has correct project id size' do
      expect(parts[1].size).to eq(2)
    end

    it 'has correct random part size' do
      expect(parts[2].size).to eq(22)
    end

    it 'includes timestamp' do
      timestamp = Time.now.to_i - Time.new(2000).to_i
      id_timestamp = uniq_id.split('-').first.to_i(16)
      expect(id_timestamp).to be_between(timestamp, timestamp + 2)
    end

    it 'include project id' do
      expect(uniq_id).to include(format('-%02x-', context_id))
    end
  end

  describe '#generate' do
    context 'with valid context id' do
      let(:context_id) { rand(255) }

      it 'generates random id every time' do
        expect(uniq_id).not_to eq(uniq_id)
      end
    end

    context 'with empty context id' do
      let(:context_id) { nil }

      it 'raises exception' do
        expect { uniq_id }.to raise_error(IdGenerator::Error,
                                          'Invalid project id')
      end
    end

    context 'with invalid context id' do
      let(:context_id) { 'context' }

      it 'raises exception' do
        expect { uniq_id }.to raise_error(IdGenerator::Error,
                                          'Invalid project id')
      end
    end

    context 'with invalid too big context id' do
      let(:context_id) { 267 }

      it 'raises exception' do
        expect { uniq_id }.to raise_error(IdGenerator::Error,
                                          'Invalid project id')
      end
    end

    context 'with negative context id' do
      let(:context_id) { -5 }

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
