RSpec.describe IdGenerator::Generators::TimestampedRandom do
  let(:generator) { described_class.new(configuration) }
  let(:context_id) { rand(255) }
  let(:configuration) { IdGenerator::Configuration.new(context_id: context_id) }

  describe 'id format' do
    let(:parts) { uniq_id.split('-') }

    it 'has correct size' do
      expect(uniq_id.size).to eq(36)
    end

    # Palantir::ValidationPatterns::GUID
    it 'has correct format' do
      expect(uniq_id).to match(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i)
    end

    it 'has 4 separators' do
      expect(uniq_id.count('-')).to eq(4)
    end

    it 'has 5 parts' do
      expect(parts.size).to eq(5)
    end

    it 'has correct timestamp size' do
      expect(parts[0].size).to eq(8)
    end

    it 'has correct project id size' do
      expect(parts[1].size).to eq(4)
    end

    it 'has correct random part 1 size' do
      expect(parts[2].size).to eq(4)
    end

    it 'has correct random part 2 size' do
      expect(parts[3].size).to eq(4)
    end

    it 'has correct random part 3 size' do
      expect(parts[4].size).to eq(12)
    end

    it 'includes timestamp' do
      timestamp = Time.now.to_i - Time.new(2000).to_i
      id_timestamp = uniq_id.split('-').first.to_i(16)
      expect(id_timestamp).to be_between(timestamp, timestamp + 2)
    end

    it 'include project id' do
      expect(uniq_id).to include(format('-%04x-', context_id))
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
