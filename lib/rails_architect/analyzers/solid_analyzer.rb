# frozen_string_literal: true

module RailsArchitect
  module Analyzers
    # Evaluates SOLID principles adherence in Rails projects
    class SolidAnalyzer
      attr_reader :project_path

      def initialize(project_path = Rails.root)
        @project_path = project_path
      end

      def analyze
        {
          score: calculate_solid_score,
          single_responsibility: analyze_single_responsibility,
          open_closed: analyze_open_closed,
          liskov_substitution: analyze_liskov,
          interface_segregation: analyze_interface_segregation,
          dependency_inversion: analyze_dependency_inversion,
          suggestions: generate_suggestions
        }
      end

      private

      def analyze_single_responsibility
        {
          description: "A class should have only one reason to change",
          issues: detect_srp_violations,
          status: detect_srp_violations.empty? ? "✅ Good" : "⚠️  Violations found"
        }
      end

      def analyze_open_closed
        {
          description: "Classes should be open for extension, closed for modification",
          has_concerns: concerns?,
          has_modules: modules?,
          has_inheritance: inheritance?,
          status: concerns? || inheritance? ? "✅ Some patterns found" : "⚠️  Consider using concerns or inheritance"
        }
      end

      def analyze_liskov
        chains = analyze_inheritance_chains
        {
          description: "Objects should be replaceable by their subtypes without breaking",
          inheritance_chains: chains,
          concerns_usage: count_concerns,
          status: chains < 3 ? "✅ Good" : "⚠️  Deep inheritance chains detected"
        }
      end

      def analyze_interface_segregation
        {
          description: "Clients should not depend on interfaces they don't use",
          fat_modules: detect_fat_modules,
          large_classes: detect_large_classes,
          status: (detect_fat_modules + detect_large_classes).empty? ? "✅ Good" : "⚠️  Violations found"
        }
      end

      def analyze_dependency_inversion
        {
          description: "Depend on abstractions, not concretions",
          service_layer: services?,
          dependency_injection: detect_dependency_injection,
          status: services? ? "✅ Service layer detected" : "⚠️  Consider implementing service layer"
        }
      end

      def calculate_solid_score
        srp = detect_srp_violations.empty? ? 20 : 10
        ocp = concerns? || inheritance? ? 20 : 10
        lsp = analyze_inheritance_chains < 3 ? 20 : 10
        isp = (detect_fat_modules + detect_large_classes).empty? ? 20 : 10
        dip = services? ? 20 : 10

        total = srp + ocp + lsp + isp + dip
        { score: total, rating: rating_from_score(total), color: color_from_score(total) }
      end

      def rating_from_score(score)
        case score
        when 0...30
          "❌ Poor"
        when 30...60
          "⚠️  Fair"
        when 60...80
          "✅ Good"
        else
          "🎉 Excellent"
        end
      end

      def color_from_score(score)
        case score
        when 0...30
          :red
        when 30...60
          :yellow
        when 60...80
          :light_green
        else
          :green
        end
      end

      def detect_srp_violations
        violations = []
        models_path = File.join(project_path, "app/models")
        return violations unless File.directory?(models_path)

        Dir.glob(File.join(models_path, "*.rb")).each do |file|
          content = File.read(file)
          # Simple heuristic: check for many associations and methods
          associations = content.scan(/has_many|belongs_to|has_one/).count
          methods = content.scan("def ").count

          violations << File.basename(file, ".rb") if associations > 5 && methods > 10
        end

        violations
      end

      def concerns?
        concerns_path = File.join(project_path, "app/concerns")
        File.directory?(concerns_path) && !Dir.glob(File.join(concerns_path, "*.rb")).empty?
      end

      def modules?
        lib_path = File.join(project_path, "lib")
        return false unless File.directory?(lib_path)

        Dir.glob(File.join(lib_path, "**/*.rb")).any? { |f| File.read(f).include?("module ") }
      end

      def inheritance?
        app_path = File.join(project_path, "app")
        return false unless File.directory?(app_path)

        Dir.glob(File.join(app_path, "**/*.rb")).any? { |f| File.read(f).match?(/class \w+ </) }
      end

      def analyze_inheritance_chains
        app_path = File.join(project_path, "app")
        return 0 unless File.directory?(app_path)

        max_depth = 0
        Dir.glob(File.join(app_path, "**/*.rb")).each do |file|
          content = File.read(file)
          depth = content.scan(/class \w+ </).count
          max_depth = depth if depth > max_depth
        end

        max_depth
      end

      def count_concerns
        concerns_path = File.join(project_path, "app/concerns")
        return 0 unless File.directory?(concerns_path)

        Dir.glob(File.join(concerns_path, "*.rb")).count
      end

      def detect_fat_modules
        modules = []
        lib_path = File.join(project_path, "lib")
        return modules unless File.directory?(lib_path)

        Dir.glob(File.join(lib_path, "**/*.rb")).each do |file|
          lines = File.readlines(file).count
          modules << File.basename(file, ".rb") if lines > 300
        end

        modules
      end

      def detect_large_classes
        classes = []
        app_path = File.join(project_path, "app")
        return classes unless File.directory?(app_path)

        Dir.glob(File.join(app_path, "**/*.rb")).each do |file|
          lines = File.readlines(file).count
          classes << File.basename(file, ".rb") if lines > 150
        end

        classes
      end

      def services?
        services_path = File.join(project_path, "app/services")
        File.directory?(services_path) && !Dir.glob(File.join(services_path, "*.rb")).empty?
      end

      def detect_dependency_injection
        app_path = File.join(project_path, "app")
        return 0 unless File.directory?(app_path)

        count = 0
        Dir.glob(File.join(app_path, "**/*.rb")).each do |file|
          content = File.read(file)
          # Look for initialize methods with parameters
          count += 1 if content.match?(/def initialize\([^)]+\)/)
        end

        count
      end

      def generate_suggestions
        suggestions = []

        unless detect_srp_violations.empty?
          suggestions << "⚠️  Classes with mixed responsibilities detected: #{detect_srp_violations.join(', ')}"
          suggestions << "Extract logic into service objects or concerns"
        end

        suggestions << "Consider creating app/concerns for shared behavior" unless concerns?

        suggestions << "Implement a service layer (app/services) for complex business logic" unless services?

        if analyze_inheritance_chains >= 3
          suggestions << "⚠️  Deep inheritance chains detected. Consider using composition or concerns"
        end

        unless detect_large_classes.empty?
          suggestions << "⚠️  Large classes detected: #{detect_large_classes.first(3).join(', ')}"
          suggestions << "Break them down using SRP (Single Responsibility Principle)"
        end

        suggestions << "Use dependency injection to reduce tight coupling" if detect_dependency_injection < 10

        suggestions
      end
    end
  end
end
