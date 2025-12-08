# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::Analyzers::TddAnalyzer do
  let(:project_path) { File.expand_path("../fixtures/sample_rails_app", __dir__) }
  let(:analyzer) { described_class.new(project_path) }

  describe "#analyze" do
    it "returns a hash with TDD analysis" do
      results = analyzer.analyze

      expect(results).to be_a(Hash)
      expect(results).to have_key(:score)
      expect(results).to have_key(:test_files)
      expect(results).to have_key(:suggestions)
    end

    it "includes spec files count" do
      results = analyzer.analyze
      expect(results).to have_key(:spec_files)
      expect(results[:spec_files]).to be_a(Integer)
    end

    it "calculates coverage percentage" do
      results = analyzer.analyze
      expect(results).to have_key(:coverage_percentage)
      expect(results[:coverage_percentage]).to be_a(Float).or be_a(Integer)
    end

    it "provides test structure analysis" do
      results = analyzer.analyze
      expect(results).to have_key(:test_structure)
      expect(results[:test_structure]).to be_a(Hash)
    end

    it "includes suggestions for improvement" do
      results = analyzer.analyze
      expect(results[:suggestions]).to be_a(Array)
    end
  end

  describe "#count_test_files" do
    it "returns an integer count" do
      count = analyzer.send(:count_test_files)
      expect(count).to be_a(Integer)
      expect(count).to be >= 0
    end
  end

  describe "#count_spec_files" do
    it "returns an integer count" do
      count = analyzer.send(:count_spec_files)
      expect(count).to be_a(Integer)
      expect(count).to be >= 0
    end
  end

  describe "#estimate_coverage" do
    it "returns a percentage value" do
      coverage = analyzer.send(:estimate_coverage)
      expect(coverage).to be_a(Float).or be_a(Integer)
      expect(coverage).to be >= 0
    end
  end

  describe "#analyze_test_structure" do
    it "returns a hash with test types" do
      structure = analyzer.send(:analyze_test_structure)

      expect(structure).to be_a(Hash)
      expect(structure).to have_key(:models)
      expect(structure).to have_key(:controllers)
      expect(structure).to have_key(:services)
      expect(structure).to have_key(:helpers)
    end
  end
end
