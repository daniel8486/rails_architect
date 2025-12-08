require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Open an IRB session with the gem loaded'
task :console do
  require 'irb'
  require 'rails_architect'
  IRB.start(__FILE__)
end
