# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect do
  it "has a version number" do
    expect(RailsArchitect::VERSION).not_to be nil
  end

  describe ".analyze" do
    it "returns a hash with analysis results" do
      project_path = File.expand_path("../fixtures/sample_rails_app", __dir__)
      results = RailsArchitect.analyze(project_path)

      expect(results).to be_a(Hash)
      expect(results).to have_key(:architecture)
      expect(results).to have_key(:tdd)
      expect(results).to have_key(:bdd)
      expect(results).to have_key(:solid)
    end
  end
end
