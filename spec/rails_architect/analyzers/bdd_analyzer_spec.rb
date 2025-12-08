# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::Analyzers::BddAnalyzer do
  let(:project_path) { File.expand_path("../fixtures/sample_rails_app", __dir__) }
  let(:analyzer) { described_class.new(project_path) }

  describe "#analyze" do
    it "returns a hash with BDD analysis" do
      results = analyzer.analyze

      expect(results).to be_a(Hash)
      expect(results).to have_key(:score)
      expect(results).to have_key(:suggestions)
      expect(results).to have_key(:practices)
    end

    it "includes Cucumber status" do
      results = analyzer.analyze
      expect(results).to have_key(:has_cucumber)
      expect(results[:has_cucumber]).to be(true).or be(false)
    end

    it "includes RSpec status" do
      results = analyzer.analyze
      expect(results).to have_key(:has_rspec)
      expect(results[:has_rspec]).to be(true).or be(false)
    end

    it "counts feature files" do
      results = analyzer.analyze
      expect(results).to have_key(:feature_files_count)
      expect(results[:feature_files_count]).to be_a(Integer)
    end

    it "includes practices evaluation" do
      results = analyzer.analyze
      expect(results[:practices]).to be_a(Hash)
      expect(results[:practices]).to have_key(:user_stories)
    end

    it "provides suggestions for BDD improvement" do
      results = analyzer.analyze
      expect(results[:suggestions]).to be_a(Array)
    end
  end

  describe "#cucumber?" do
    it "returns boolean" do
      result = analyzer.send(:cucumber?)
      expect(result).to be(true).or be(false)
    end
  end

  describe "#rspec?" do
    it "returns boolean" do
      result = analyzer.send(:rspec?)
      expect(result).to be(true).or be(false)
    end
  end

  describe "#user_stories?" do
    it "returns boolean" do
      result = analyzer.send(:user_stories?)
      expect(result).to be(true).or be(false)
    end
  end

  describe "#count_feature_files" do
    it "returns an integer" do
      count = analyzer.send(:count_feature_files)
      expect(count).to be_a(Integer)
      expect(count).to be >= 0
    end
  end

  describe "#check_bdd_practices" do
    it "returns hash with practice evaluations" do
      practices = analyzer.send(:check_bdd_practices)

      expect(practices).to be_a(Hash)
      expect(practices).to have_key(:user_stories)
      expect(practices).to have_key(:readable_scenarios)
      expect(practices).to have_key(:integration_tests)
    end
  end
end
