RSpec.describe IdGenerator::Generators::TimestampedRandom do
  let(:generator) { described_class.new(context_id) }
  let(:context_id) { rand(255) }
  let(:configuration) { IdGenerator::Configuration.new(context_id: context_id) }

  describe 'id format' do
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

  describe 'context_id' do
    it 'allows 0' do
      expect { described_class.new(0) }.not_to raise_error
    end

    it 'allows 255' do
      expect { described_class.new(255) }.not_to raise_error
    end

    it 'rejects negative values' do
      expect { described_class.new(-1) }.to raise_error(IdGenerator::Errors::InvalidContextId, 'Invalid project id')
    end

    it 'rejects large values' do
      expect { described_class.new(rand(256..1000)) }.to raise_error(IdGenerator::Errors::InvalidContextId, 'Invalid project id')
    end

    it 'rejects empty values' do
      expect { described_class.new(nil) }.to raise_error(IdGenerator::Errors::InvalidContextId, 'Invalid project id')
    end

    it 'rejects invalid values' do
      expect { described_class.new('id') }.to raise_error(IdGenerator::Errors::InvalidContextId, 'Invalid project id')
    end
  end

  describe '#generate' do
    it 'generates random id every time' do
      expect(uniq_id).not_to eq(uniq_id)
    end
  end

  protected

  def uniq_id
    generator.generate
  end
end
