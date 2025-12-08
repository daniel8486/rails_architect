# frozen_string_literal: true

require "thor"
require "colorize"

module RailsArchitect
  # Command-line interface for Rails Architect analysis tool
  class CLI < Thor
    desc "analyze [PROJECT_PATH]", "Analyze a Rails project for architecture, TDD, BDD, and SOLID principles"
    option :json, type: :boolean, desc: "Output results as JSON"
    option :output, type: :string, desc: "Save report to a file"

    def analyze(project_path = nil)
      project_path ||= Dir.pwd

      unless File.directory?(project_path)
        puts "❌ Project path does not exist: #{project_path}".colorize(:red)
        exit 1
      end

      results = RailsArchitect::Core.new(project_path).analyze

      if options[:json]
        output = RailsArchitect::Reporters::ReportGenerator.new(results).to_json
        if options[:output]
          File.write(options[:output], output)
          puts "✅ JSON report saved to: #{options[:output]}".colorize(:light_green)
        else
          puts output
        end
      elsif options[:output]
        File.open(options[:output], "w") do |f|
          # Redirect output to file
          original_stdout = $stdout
          $stdout = f
          RailsArchitect::Reporters::ReportGenerator.new(results).generate
          $stdout = original_stdout
        end
        puts "✅ Report saved to: #{options[:output]}".colorize(:light_green)
      else
        RailsArchitect::Reporters::ReportGenerator.new(results).generate
      end
    end

    desc "suggest [PROJECT_PATH]", "Get architecture suggestions for your Rails project"
    def suggest(project_path = nil)
      project_path ||= Dir.pwd

      unless File.directory?(project_path)
        puts "❌ Project path does not exist: #{project_path}".colorize(:red)
        exit 1
      end

      results = RailsArchitect::Core.new(project_path).analyze

      puts "\n#{'=' * 80}"
      puts "🎯 ARCHITECTURE SUGGESTIONS".colorize(:blue).bold
      puts "#{'=' * 80}\n"

      suggestions = (
        results[:architecture][:suggestions] +
        results[:tdd][:suggestions] +
        results[:bdd][:suggestions] +
        results[:solid][:suggestions]
      ).uniq

      if suggestions.any?
        suggestions.each_with_index do |suggestion, index|
          puts "#{index + 1}. #{suggestion}"
        end
      else
        puts "✅ Your project is well-structured!".colorize(:light_green)
      end

      puts "\n#{'=' * 80}\n"
    end

    desc "version", "Show the version of rails_architect"
    def version
      puts "Rails Architect #{RailsArchitect::VERSION}"
    end
  end
end
