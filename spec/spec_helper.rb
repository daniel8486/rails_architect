# frozen_string_literal: true

require "bundler/setup"
require "rails_architect"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Suprimir aviso sobre expect { }.not_to raise_error
  RSpec::Expectations.configuration.on_potential_false_positives = :nothing

  # Excluir specs da fixture de projeto
  config.exclude_pattern = "**/fixtures/**/*_spec.rb"
end
