module RailsArchitect
  module Analyzers
    class BddAnalyzer
      attr_reader :project_path

      def initialize(project_path = Rails.root)
        @project_path = project_path
      end

      def analyze
        {
          has_cucumber: has_cucumber?,
          has_rspec: has_rspec?,
          feature_files_count: count_feature_files,
          step_definitions_count: count_step_definitions,
          score: calculate_bdd_score,
          suggestions: generate_suggestions,
          practices: check_bdd_practices
        }
      end

      private

      def has_cucumber?
        gemfile_path = File.join(project_path, 'Gemfile')
        return false unless File.exist?(gemfile_path)
        File.read(gemfile_path).include?('cucumber')
      end

      def has_rspec?
        gemfile_path = File.join(project_path, 'Gemfile')
        return false unless File.exist?(gemfile_path)
        File.read(gemfile_path).include?('rspec')
      end

      def count_feature_files
        features_path = File.join(project_path, 'features')
        return 0 unless File.directory?(features_path)
        Dir.glob(File.join(features_path, '**/*.feature')).count
      end

      def count_step_definitions
        steps_path = File.join(project_path, 'features/step_definitions')
        return 0 unless File.directory?(steps_path)
        Dir.glob(File.join(steps_path, '**/*.rb')).count
      end

      def calculate_bdd_score
        features = count_feature_files
        steps = count_step_definitions

        case features
        when 0
          { score: 0, rating: "❌ No BDD implemented", color: :red }
        when 1...5
          { score: 25, rating: "⚠️  Minimal BDD coverage", color: :yellow }
        when 5...15
          { score: 50, rating: "✅ Some BDD coverage", color: :light_yellow }
        else
          { score: 100, rating: "🎉 Strong BDD practices", color: :light_green }
        end
      end

      def check_bdd_practices
        {
          user_stories: has_user_stories?,
          readable_scenarios: check_readable_scenarios,
          step_reusability: analyze_step_reusability,
          integration_tests: check_integration_tests
        }
      end

      def has_user_stories?
        features_path = File.join(project_path, 'features')
        return false unless File.directory?(features_path)

        Dir.glob(File.join(features_path, '**/*.feature')).any? do |file|
          content = File.read(file)
          content.include?('Feature:') && (content.include?('As a') || content.include?('Scenario'))
        end
      end

      def check_readable_scenarios
        features_path = File.join(project_path, 'features')
        return { present: false, count: 0 } unless File.directory?(features_path)

        readable = Dir.glob(File.join(features_path, '**/*.feature')).count do |file|
          content = File.read(file)
          content.match?(/Given|When|Then/)
        end

        { present: readable > 0, count: readable }
      end

      def analyze_step_reusability
        steps_path = File.join(project_path, 'features/step_definitions')
        return { score: 0, recommendation: "Create step definitions" } unless File.directory?(steps_path)

        step_files = Dir.glob(File.join(steps_path, '*.rb'))
        return { score: 0, recommendation: "Create step definitions" } if step_files.empty?

        avg_lines = step_files.map { |f| File.readlines(f).count }.sum / step_files.count
        
        {
          score: avg_lines,
          recommendation: avg_lines > 200 ? "Refactor steps - they're getting too large" : "Steps are well-organized"
        }
      end

      def check_integration_tests
        {
          request_specs: count_request_specs,
          feature_tests: count_feature_files,
          integration_test_files: count_integration_test_files
        }
      end

      def count_request_specs
        specs_path = File.join(project_path, 'spec/requests')
        return 0 unless File.directory?(specs_path)
        Dir.glob(File.join(specs_path, '**/*_spec.rb')).count
      end

      def count_integration_test_files
        integration_path = File.join(project_path, 'test/integration')
        return 0 unless File.directory?(integration_path)
        Dir.glob(File.join(integration_path, '**/*_test.rb')).count
      end

      def generate_suggestions
        suggestions = []

        unless has_cucumber?
          suggestions << "Consider adding Cucumber for BDD with human-readable scenarios"
        end

        if count_feature_files.zero? && has_cucumber?
          suggestions << "No feature files found. Start writing user stories in features/"
        end

        unless has_rspec?
          suggestions << "Consider using RSpec for more expressive tests"
        end

        unless has_user_stories?
          suggestions << "Write user stories using 'As a... I want... So that...' format in feature files"
        end

        unless check_readable_scenarios[:present]
          suggestions << "Structure your scenarios using Given/When/Then format"
        end

        suggestions
      end
    end
  end
end
