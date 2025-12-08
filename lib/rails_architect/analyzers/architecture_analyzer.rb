# frozen_string_literal: true

require "fileutils"

module RailsArchitect
  module Analyzers
    # Analyzes Rails project architecture, structure, and design patterns
    class ArchitectureAnalyzer
      STANDARD_DIRS = %w[
        app/models
        app/controllers
        app/views
        app/helpers
        app/services
        app/decorators
        app/policies
        app/validators
        config
        lib
        spec
      ].freeze

      attr_reader :project_path

      def initialize(project_path = Rails.root)
        @project_path = project_path
      end

      def analyze
        {
          score: calculate_score,
          structure: check_structure,
          suggestions: generate_suggestions,
          missing_dirs: missing_directories,
          optional_dirs: check_optional_dirs
        }
      end

      private

      def calculate_score
        existing = existing_directories.count
        total = STANDARD_DIRS.count
        ((existing.to_f / total) * 100).round(2)
      end

      def check_structure
        STANDARD_DIRS.map do |dir|
          full_path = File.join(project_path, dir)
          {
            name: dir,
            exists: File.directory?(full_path),
            files_count: count_files(full_path)
          }
        end
      end

      def missing_directories
        STANDARD_DIRS.reject { |dir| File.directory?(File.join(project_path, dir)) }
      end

      def existing_directories
        STANDARD_DIRS.select { |dir| File.directory?(File.join(project_path, dir)) }
      end

      def check_optional_dirs
        optional = {
          "app/services" => "Service Objects",
          "app/decorators" => "Decorator Pattern",
          "app/policies" => "Authorization Policies",
          "app/validators" => "Custom Validators",
          "app/presenters" => "Presenter Pattern",
          "app/interactors" => "Interactors/Use Cases",
          "app/concerns" => "Shared Concerns"
        }

        optional.map do |dir, description|
          full_path = File.join(project_path, dir)
          {
            name: dir,
            description: description,
            exists: File.directory?(full_path)
          }
        end
      end

      def generate_suggestions
        suggestions = []

        if missing_directories.include?("app/services")
          suggestions << "Consider creating 'app/services' directory for business logic"
        end

        if missing_directories.include?("app/decorators")
          suggestions << "Create 'app/decorators' for separating presentation logic from models"
        end

        if missing_directories.include?("app/policies")
          suggestions << "Implement 'app/policies' directory for authorization logic (using Pundit)"
        end

        suggestions << "⚠️  Detected fat models. Consider extracting logic to services or concerns" if fat_models?

        suggestions << "⚠️  Detected fat controllers. Move business logic to services" if fat_controllers?

        if poorly_organized_helpers?
          suggestions << "Refactor helpers - consider moving logic to presenters or decorators"
        end

        suggestions
      end

      def fat_models?
        models_path = File.join(project_path, "app/models")
        return false unless File.directory?(models_path)

        Dir.glob(File.join(models_path, "*.rb")).any? do |file|
          File.readlines(file).count > 200
        end
      end

      def fat_controllers?
        controllers_path = File.join(project_path, "app/controllers")
        return false unless File.directory?(controllers_path)

        Dir.glob(File.join(controllers_path, "**/*.rb")).any? do |file|
          File.readlines(file).count > 150
        end
      end

      def poorly_organized_helpers?
        helpers_path = File.join(project_path, "app/helpers")
        return false unless File.directory?(helpers_path)

        helper_files = Dir.glob(File.join(helpers_path, "*.rb"))
        helper_files.any? do |file|
          File.readlines(file).count > 100
        end
      end

      def count_files(path)
        return 0 unless File.directory?(path)

        Dir.glob(File.join(path, "**/*.rb")).count
      end
    end
  end
end
