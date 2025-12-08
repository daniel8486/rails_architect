#!/bin/bash
cd /Users/danielmatos-pro/www/created_ruby_gem/rails_architect
bundle exec rspec --version
echo "---"
bundle exec rspec --format progress
echo "---"
bundle exec rspec --format json > /tmp/rspec_output.json
echo "Resultado salvo em /tmp/rspec_output.json"
cat /tmp/rspec_output.json | grep -o '"example_count":[0-9]*' 
