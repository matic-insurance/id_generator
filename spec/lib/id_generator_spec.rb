RSpec.describe IdGenerator do
  let(:context_error) { IdGenerator::Errors::InvalidContextId }

  after { described_class.configuration.context_id = 0 }

  describe '#generate' do
    it 'generates random id every time' do
      expect(uniq_id).not_to eq(uniq_id)
    end

    it 'using default context id' do
      expect(uniq_id).to include('-00-')
    end
  end

  describe '#configure' do
    it 'setting context id' do
      described_class.configure { |c| c.context_id = 15 }
      expect(uniq_id).to include('-0f-')
    end

    it 'validating context id' do
      expect { described_class.configure { |c| c.context_id = -1 } }.to raise_error(context_error)
    end
  end

  describe '#configuration' do
    it 'setting context id' do
      described_class.configuration.context_id = 15
      expect(uniq_id).to include('-0f-')
    end

    it 'validating context id' do
      expect { described_class.configuration.context_id = -1 }.to raise_error(context_error)
    end
  end

  protected

  def uniq_id
    described_class.generate
  end
end
