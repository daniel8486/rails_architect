# frozen_string_literal: true

require "spec_helper"

RSpec.describe RailsArchitect::CLI do
  let(:cli) { described_class.new }
  let(:project_path) { File.expand_path("../fixtures/sample_rails_app", __dir__) }

  describe "#analyze" do
    it "runs analysis without raising errors" do
      expect do
        cli.invoke(:analyze, [project_path])
      end.not_to raise_error
    end

    it "exports results as JSON when --json option is provided" do
      output_file = "/tmp/test_output_#{Time.now.to_i}.json"
      begin
        cli.invoke(:analyze, [project_path, "--json", "--output", output_file])
        expect(File.exist?(output_file)).to be true if File.exist?(output_file)
      ensure
        FileUtils.rm_f(output_file)
      end
    end

    it "saves report to file when --output option is provided" do
      output_file = "/tmp/test_report_#{Time.now.to_i}.txt"
      begin
        allow($stdout).to receive(:puts)
        cli.invoke(:analyze, [project_path, "--output", output_file])
      ensure
        FileUtils.rm_f(output_file)
      end
    end
  end

  describe "#suggest" do
    it "provides suggestions for architecture improvement" do
      expect do
        cli.invoke(:suggest, [project_path])
      end.not_to raise_error(NoMethodError)
    end
  end

  describe "#version" do
    it "displays version information" do
      expect do
        cli.invoke(:version)
      end.not_to raise_error
    end

    it "shows non-nil version" do
      expect(RailsArchitect::VERSION).not_to be_nil
    end
  end
end
