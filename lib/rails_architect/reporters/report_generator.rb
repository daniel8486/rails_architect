require 'json'
require 'colorize'

module RailsArchitect
  module Reporters
    class ReportGenerator
      attr_reader :results

      def initialize(results)
        @results = results
      end

      def generate
        print_header
        print_architecture_report
        print_tdd_report
        print_bdd_report
        print_solid_report
        print_summary
        print_recommendations
      end

      def to_json
        @results.to_json
      end

      private

      def print_header
        puts "\n" + "=" * 80
        puts "🏗️  RAILS ARCHITECT - PROJECT ANALYSIS REPORT".colorize(:blue).bold
        puts "=" * 80 + "\n"
      end

      def print_architecture_report
        arch = @results[:architecture]
        puts "📐 ARCHITECTURE ANALYSIS".colorize(:cyan).bold
        puts "-" * 80
        puts "Overall Score: #{arch[:score]}%".colorize(:yellow)
        
        puts "\n✓ Existing Directories (#{arch[:structure].count { |d| d[:exists] }}/#{arch[:structure].count}):"
        arch[:structure].each do |dir|
          status = dir[:exists] ? "✅" : "❌"
          count = dir[:exists] ? " (#{dir[:files_count]} files)" : ""
          puts "  #{status} #{dir[:name]}#{count}"
        end

        unless arch[:missing_dirs].empty?
          puts "\n⚠️  Missing Important Directories:"
          arch[:missing_dirs].each { |dir| puts "  • #{dir}" }
        end

        puts "\n📦 Optional Patterns Available:"
        arch[:optional_dirs].each do |dir|
          status = dir[:exists] ? "✅ Implemented" : "❌ Not used"
          puts "  #{status} - #{dir[:description]} (#{dir[:name]})"
        end

        if arch[:suggestions].any?
          puts "\n💡 Suggestions:"
          arch[:suggestions].each { |suggestion| puts "  • #{suggestion}" }
        end

        puts "\n"
      end

      def print_tdd_report
        tdd = @results[:tdd]
        puts "🧪 TEST-DRIVEN DEVELOPMENT (TDD) ANALYSIS".colorize(:cyan).bold
        puts "-" * 80

        score_data = tdd[:score]
        puts "Coverage Score: #{score_data[:score].round(2)}% #{score_data[:rating]}".colorize(score_data[:color])

        puts "\nTest Files:"
        puts "  • Spec files: #{tdd[:spec_files]}"
        puts "  • Test files: #{tdd[:test_files]}"
        puts "  • Total: #{tdd[:spec_files] + tdd[:test_files]}"

        puts "\nTest Structure Breakdown:"
        tdd[:test_structure].each do |type, counts|
          puts "  • #{type.capitalize}: #{counts[:total]} files (#{counts[:spec]} specs, #{counts[:test]} tests)"
        end

        if tdd[:suggestions].any?
          puts "\n💡 Suggestions:"
          tdd[:suggestions].each { |suggestion| puts "  • #{suggestion}" }
        end

        puts "\n"
      end

      def print_bdd_report
        bdd = @results[:bdd]
        puts "🎯 BEHAVIOR-DRIVEN DEVELOPMENT (BDD) ANALYSIS".colorize(:cyan).bold
        puts "-" * 80

        score_data = bdd[:score]
        puts "BDD Score: #{score_data[:rating]}".colorize(score_data[:color])

        puts "\nFrameworks:"
        puts "  • Cucumber: #{bdd[:has_cucumber] ? '✅ Installed' : '❌ Not installed'}"
        puts "  • RSpec: #{bdd[:has_rspec] ? '✅ Installed' : '❌ Not installed'}"

        puts "\nFeatures & Scenarios:"
        puts "  • Feature files: #{bdd[:feature_files_count]}"
        puts "  • Step definitions: #{bdd[:step_definitions_count]}"

        puts "\nBDD Practices:"
        practices = bdd[:practices]
        puts "  • User Stories: #{practices[:user_stories] ? '✅ Found' : '❌ Not found'}"
        puts "  • Readable Scenarios: #{practices[:readable_scenarios][:present] ? "✅ #{practices[:readable_scenarios][:count]} found" : '❌ Not found'}"
        puts "  • Integration Tests: #{practices[:integration_tests][:request_specs] + practices[:integration_tests][:integration_test_files]} files"

        if bdd[:suggestions].any?
          puts "\n💡 Suggestions:"
          bdd[:suggestions].each { |suggestion| puts "  • #{suggestion}" }
        end

        puts "\n"
      end

      def print_solid_report
        solid = @results[:solid]
        puts "⚡ SOLID PRINCIPLES ANALYSIS".colorize(:cyan).bold
        puts "-" * 80

        score_data = solid[:score]
        puts "SOLID Score: #{score_data[:score]}/100 #{score_data[:rating]}".colorize(score_data[:color])

        puts "\nPrinciple Analysis:"

        srp = solid[:single_responsibility]
        puts "\n1. Single Responsibility Principle (SRP)"
        puts "   Status: #{srp[:status]}".colorize(srp[:status].include?('✅') ? :light_green : :yellow)
        unless srp[:issues].empty?
          puts "   Issues found in: #{srp[:issues].join(', ')}"
        end

        ocp = solid[:open_closed]
        puts "\n2. Open/Closed Principle (OCP)"
        puts "   Status: #{ocp[:status]}".colorize(ocp[:status].include?('✅') ? :light_green : :yellow)
        puts "   - Concerns: #{ocp[:has_concerns] ? '✅ Yes' : '❌ No'}"
        puts "   - Inheritance: #{ocp[:has_inheritance] ? '✅ Used' : '❌ Not used'}"

        lsp = solid[:liskov_substitution]
        puts "\n3. Liskov Substitution Principle (LSP)"
        puts "   Status: #{lsp[:status]}".colorize(lsp[:status].include?('✅') ? :light_green : :yellow)
        puts "   - Inheritance depth: #{lsp[:inheritance_chains]}"

        isp = solid[:interface_segregation]
        puts "\n4. Interface Segregation Principle (ISP)"
        puts "   Status: #{isp[:status]}".colorize(isp[:status].include?('✅') ? :light_green : :yellow)

        dip = solid[:dependency_inversion]
        puts "\n5. Dependency Inversion Principle (DIP)"
        puts "   Status: #{dip[:status]}".colorize(dip[:status].include?('✅') ? :light_green : :yellow)

        if solid[:suggestions].any?
          puts "\n💡 Suggestions:"
          solid[:suggestions].each { |suggestion| puts "  • #{suggestion}" }
        end

        puts "\n"
      end

      def print_summary
        puts "=" * 80
        puts "📊 OVERALL SUMMARY".colorize(:blue).bold
        puts "=" * 80
        puts "\nArchitecture:  #{@results[:architecture][:score]}%".colorize(:light_yellow)
        puts "TDD Coverage:  #{@results[:tdd][:score][:score].round(2)}% #{@results[:tdd][:score][:rating]}".colorize(@results[:tdd][:score][:color])
        puts "BDD Practices: #{@results[:bdd][:score][:rating]}".colorize(@results[:bdd][:score][:color])
        puts "SOLID Score:   #{@results[:solid][:score][:score]}/100 #{@results[:solid][:score][:rating]}".colorize(@results[:solid][:score][:color])
        puts "\n"
      end

      def print_recommendations
        puts "=" * 80
        puts "🚀 RECOMMENDATIONS FOR IMPROVEMENT".colorize(:green).bold
        puts "=" * 80 + "\n"

        all_suggestions = (
          @results[:architecture][:suggestions] +
          @results[:tdd][:suggestions] +
          @results[:bdd][:suggestions] +
          @results[:solid][:suggestions]
        ).uniq

        if all_suggestions.any?
          all_suggestions.each_with_index do |suggestion, index|
            puts "#{index + 1}. #{suggestion}"
          end
        else
          puts "✅ Excellent! Your project follows best practices.".colorize(:light_green)
        end

        puts "\n" + "=" * 80 + "\n"
      end
    end
  end
end
