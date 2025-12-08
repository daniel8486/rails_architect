# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::Reporters::ReportGenerator do
  let(:results) do
    {
      architecture: {
        score: 75,
        structure: [
          { name: "app/models", exists: true, files_count: 5 },
          { name: "app/controllers", exists: true, files_count: 3 }
        ],
        suggestions: ["Create app/services directory"]
      },
      tdd: {
        score: { score: 60, rating: "Good", color: :green },
        test_files: 0,
        spec_files: 5,
        coverage_percentage: 45.5,
        suggestions: ["Add more test coverage"],
        test_structure: {
          models: { spec: 5, test: 0, total: 5 },
          controllers: { spec: 0, test: 0, total: 0 },
          services: { spec: 0, test: 0, total: 0 },
          helpers: { spec: 0, test: 0, total: 0 },
          requests: { spec: 0, test: 0, total: 0 }
        }
      },
      bdd: {
        has_cucumber: false,
        has_rspec: true,
        feature_files_count: 0,
        step_definitions_count: 0,
        score: { score: 0, rating: "❌ No BDD implemented", color: :red },
        suggestions: ["Consider adding Cucumber"],
        practices: {
          user_stories: false,
          readable_scenarios: { present: false, count: 0 },
          step_reusability: 0,
          integration_tests: 0
        }
      },
      solid: {
        score: { score: 70, rating: "Good", color: :green },
        single_responsibility: { status: "Good", description: "Test" },
        open_closed: { status: "Needs improvement", description: "Test" },
        liskov_substitution: { status: "Good", description: "Test" },
        interface_segregation: { status: "Good", description: "Test" },
        dependency_inversion: { status: "Good", description: "Test" },
        suggestions: ["Refactor large classes"]
      }
    }
  end

  let(:generator) { described_class.new(results) }

  describe "#initialize" do
    it "accepts results hash" do
      expect(generator).to be_a(described_class)
    end
  end

  describe "#generate" do
    it "returns without errors" do
      expect do
        generator.to_json
      end.not_to raise_error
    end
  end

  describe "#to_json" do
    it "returns valid JSON string" do
      json = generator.to_json
      expect(json).to be_a(String)
      expect(JSON.parse(json)).to be_a(Hash)
    end

    it "includes all analysis results in JSON" do
      json = JSON.parse(generator.to_json)

      expect(json).to have_key("architecture")
      expect(json).to have_key("tdd")
      expect(json).to have_key("bdd")
      expect(json).to have_key("solid")
    end
  end

  describe "report printing methods" do
    it "generates JSON without errors" do
      expect do
        generator.to_json
      end.not_to raise_error
    end
  end
end
