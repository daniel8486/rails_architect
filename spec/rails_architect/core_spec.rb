# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::Core do
  let(:project_path) { File.expand_path("../fixtures/sample_rails_app", __dir__) }
  let(:core) { described_class.new(project_path) }

  describe "#initialize" do
    it "initializes with project path" do
      expect(core.project_path).to eq(project_path)
    end

    it "initializes results hash as empty" do
      expect(core.results).to eq({})
    end
  end

  describe "#analyze" do
    it "returns a hash with all analysis results" do
      results = core.analyze

      expect(results).to be_a(Hash)
      expect(results).to have_key(:architecture)
      expect(results).to have_key(:tdd)
      expect(results).to have_key(:bdd)
      expect(results).to have_key(:solid)
    end

    it "populates architecture results" do
      results = core.analyze

      expect(results[:architecture]).to be_a(Hash)
      expect(results[:architecture]).to have_key(:score)
    end

    it "populates TDD results" do
      results = core.analyze

      expect(results[:tdd]).to be_a(Hash)
      expect(results[:tdd]).to have_key(:score)
    end

    it "populates BDD results" do
      results = core.analyze

      expect(results[:bdd]).to be_a(Hash)
      expect(results[:bdd]).to have_key(:score)
    end

    it "populates SOLID results" do
      results = core.analyze

      expect(results[:solid]).to be_a(Hash)
      expect(results[:solid]).to have_key(:score)
    end
  end
end
