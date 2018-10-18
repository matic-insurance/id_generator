RSpec.describe IdGenerator::Generator do
  let(:generator) { described_class.new }

  describe '#generate' do
    subject(:uniq_id) { generator.generate }

    before { sets_project_id(project_id) }

    context 'with valid project id' do
      let(:project_id) { 999 }

      it 'generates uniq id with correct size' do
        expect(uniq_id.size).to eq(34)
      end

      it 'generates uniq id that include projec id' do
        expect(uniq_id).to include("-#{project_id}-")
      end
    end

    context 'with invalid project id' do
      let(:project_id) { nil }

      it 'raises exception' do
        expect { uniq_id }.to raise_error(IdGenerator::Config::Error,
                                          'Invalid project id')
      end
    end

    def sets_project_id(id)
      IdGenerator::Config.project_id = id
    end
  end
end
