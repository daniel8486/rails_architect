module RailsArchitect
  module Analyzers
    class TddAnalyzer
      attr_reader :project_path

      def initialize(project_path = Rails.root)
        @project_path = project_path
      end

      def analyze
        {
          score: calculate_coverage_score,
          test_files: count_test_files,
          spec_files: count_spec_files,
          coverage_percentage: estimate_coverage,
          suggestions: generate_suggestions,
          test_structure: analyze_test_structure
        }
      end

      private

      def count_test_files
        test_path = File.join(project_path, 'test')
        return 0 unless File.directory?(test_path)
        Dir.glob(File.join(test_path, '**/*_test.rb')).count
      end

      def count_spec_files
        spec_path = File.join(project_path, 'spec')
        return 0 unless File.directory?(spec_path)
        Dir.glob(File.join(spec_path, '**/*_spec.rb')).count
      end

      def estimate_coverage
        spec_files = count_spec_files
        test_files = count_test_files
        code_files = count_code_files

        return 0 if code_files.zero?

        total_tests = spec_files + test_files
        ((total_tests.to_f / code_files) * 100).round(2)
      end

      def count_code_files
        app_path = File.join(project_path, 'app')
        return 0 unless File.directory?(app_path)
        Dir.glob(File.join(app_path, '**/*.rb')).count
      end

      def calculate_coverage_score
        coverage = estimate_coverage
        case coverage
        when 0...20
          { score: coverage, rating: "❌ Poor", color: :red }
        when 20...50
          { score: coverage, rating: "⚠️  Fair", color: :yellow }
        when 50...80
          { score: coverage, rating: "✅ Good", color: :green }
        else
          { score: coverage, rating: "🎉 Excellent", color: :light_green }
        end
      end

      def analyze_test_structure
        {
          models: analyze_test_type('models'),
          controllers: analyze_test_type('controllers'),
          services: analyze_test_type('services'),
          helpers: analyze_test_type('helpers'),
          requests: analyze_test_type('requests')
        }
      end

      def analyze_test_type(type)
        spec_path = File.join(project_path, 'spec', type)
        test_path = File.join(project_path, 'test', type)

        spec_count = File.directory?(spec_path) ? Dir.glob(File.join(spec_path, '**/*.rb')).count : 0
        test_count = File.directory?(test_path) ? Dir.glob(File.join(test_path, '**/*.rb')).count : 0

        {
          spec: spec_count,
          test: test_count,
          total: spec_count + test_count
        }
      end

      def generate_suggestions
        suggestions = []

        if count_spec_files.zero? && count_test_files.zero?
          suggestions << "❌ No tests found! Start by creating specs using RSpec or Minitest"
        end

        coverage = estimate_coverage
        if coverage < 50 && coverage > 0
          suggestions << "⚠️  Test coverage is low (#{coverage.round(2)}%). Aim for at least 80%"
        end

        if analyze_test_structure[:models][:total].zero?
          suggestions << "Add model specs/tests to ensure data validation logic"
        end

        if analyze_test_structure[:controllers][:total].zero?
          suggestions << "Add controller specs/tests for request/response handling"
        end

        if analyze_test_structure[:services][:total].zero? && has_services?
          suggestions << "Create tests for service objects"
        end

        suggestions << "Use factories (FactoryBot) for test data creation" if using_minitest_only?

        suggestions
      end

      def has_services?
        services_path = File.join(project_path, 'app/services')
        File.directory?(services_path) && !Dir.glob(File.join(services_path, '*.rb')).empty?
      end

      def using_minitest_only?
        spec_files = count_spec_files
        has_gemfile = File.exist?(File.join(project_path, 'Gemfile'))

        spec_files.zero? && has_gemfile
      end
    end
  end
end
