require 'spec_helper'

RSpec.describe RailsArchitect::Analyzers::ArchitectureAnalyzer do
  let(:project_path) { File.expand_path('../fixtures/sample_rails_app', __dir__) }
  let(:analyzer) { described_class.new(project_path) }

  describe '#analyze' do
    it 'returns a hash with architecture analysis' do
      results = analyzer.analyze

      expect(results).to be_a(Hash)
      expect(results).to have_key(:score)
      expect(results).to have_key(:structure)
      expect(results).to have_key(:suggestions)
    end

    it 'calculates score as percentage' do
      results = analyzer.analyze
      expect(results[:score]).to be_between(0, 100)
    end

    it 'checks for standard directories' do
      results = analyzer.analyze
      expect(results[:structure]).to be_a(Array)
      expect(results[:structure].first).to include(:name, :exists, :files_count)
    end
  end

  describe '#missing_directories' do
    it 'identifies missing standard directories' do
      missing = analyzer.send(:missing_directories)
      expect(missing).to be_a(Array)
    end
  end
end
