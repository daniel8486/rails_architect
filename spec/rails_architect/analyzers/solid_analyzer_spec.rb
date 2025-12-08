# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::Analyzers::SolidAnalyzer do
  let(:project_path) { File.expand_path("../fixtures/sample_rails_app", __dir__) }
  let(:analyzer) { described_class.new(project_path) }

  describe "#analyze" do
    it "returns a hash with SOLID analysis" do
      results = analyzer.analyze

      expect(results).to be_a(Hash)
      expect(results).to have_key(:score)
      expect(results).to have_key(:suggestions)
    end

    it "evaluates all 5 SOLID principles" do
      results = analyzer.analyze

      expect(results).to have_key(:single_responsibility)
      expect(results).to have_key(:open_closed)
      expect(results).to have_key(:liskov_substitution)
      expect(results).to have_key(:interface_segregation)
      expect(results).to have_key(:dependency_inversion)
    end

    it "provides a summary score" do
      results = analyzer.analyze
      expect(results[:score]).to be_a(Hash)
      expect(results[:score]).to have_key(:score)
    end

    it "includes suggestions for SOLID improvement" do
      results = analyzer.analyze
      expect(results[:suggestions]).to be_a(Array)
    end
  end

  describe "#analyze_single_responsibility" do
    it "returns a hash with SR analysis" do
      result = analyzer.send(:analyze_single_responsibility)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:status)
      expect(result).to have_key(:description)
    end
  end

  describe "#analyze_open_closed" do
    it "returns a hash with OC analysis" do
      result = analyzer.send(:analyze_open_closed)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:status)
      expect(result).to have_key(:description)
    end
  end

  describe "#analyze_liskov" do
    it "returns a hash with LS analysis" do
      result = analyzer.send(:analyze_liskov)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:status)
      expect(result).to have_key(:description)
    end
  end

  describe "#analyze_interface_segregation" do
    it "returns a hash with IS analysis" do
      result = analyzer.send(:analyze_interface_segregation)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:status)
      expect(result).to have_key(:description)
    end
  end

  describe "#analyze_dependency_inversion" do
    it "returns a hash with DI analysis" do
      result = analyzer.send(:analyze_dependency_inversion)
      expect(result).to be_a(Hash)
      expect(result).to have_key(:status)
      expect(result).to have_key(:description)
    end
  end
end
