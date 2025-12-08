# frozen_string_literal: true

require "rails_architect/version"
require "rails_architect/analyzers/architecture_analyzer"
require "rails_architect/analyzers/tdd_analyzer"
require "rails_architect/analyzers/bdd_analyzer"
require "rails_architect/analyzers/solid_analyzer"
require "rails_architect/reporters/report_generator"
require "rails_architect/cli"

# RailsArchitect gem provides comprehensive analysis of Rails projects
# across architecture, TDD, BDD, and SOLID principles
module RailsArchitect
  class Error < StandardError; end

  def self.analyze(project_path = Rails.root)
    RailsArchitect::Core.new(project_path).analyze
  end
end

module RailsArchitect
  # Core analyzer orchestrating all individual analyzers
  class Core
    attr_reader :project_path, :results

    def initialize(project_path = Rails.root)
      @project_path = project_path
      @results = {}
    end

    def analyze
      puts "🔍 Analyzing Rails Project Architecture...\n".colorize(:blue)

      run_analyzers
      generate_report

      @results
    end

    private

    def run_analyzers
      @results[:architecture] = RailsArchitect::Analyzers::ArchitectureAnalyzer.new(project_path).analyze
      @results[:tdd] = RailsArchitect::Analyzers::TddAnalyzer.new(project_path).analyze
      @results[:bdd] = RailsArchitect::Analyzers::BddAnalyzer.new(project_path).analyze
      @results[:solid] = RailsArchitect::Analyzers::SolidAnalyzer.new(project_path).analyze
    end

    def generate_report
      RailsArchitect::Reporters::ReportGenerator.new(@results).generate
    end
  end
end
