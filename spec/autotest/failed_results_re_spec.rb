describe "failed_results_re for autotest" do
  def run_example
    group = RSpec::Core::ExampleGroup.describe("group")
    group.example("example") { yield }
    io = StringIO.new
    run_group(group, io)
    io.string
  end

  if RSpec::Core::Version::STRING.to_f >= 3
    def run_group(group, io)
      options = RSpec::Core::ConfigurationOptions.new([])
      config  = RSpec::Core::Configuration.new
      runner  = RSpec::Core::Runner.new(options, config)
      runner.setup(io, io)
      runner.run_specs([group])
    end
  else
    def run_group(group, io)
      formatter = RSpec::Core::Formatters::BaseTextFormatter.new(io)
      reporter = RSpec::Core::Reporter.new(formatter)
      group.run(reporter)
      reporter.report(1, nil) { }
    end
  end

  shared_examples "autotest failed_results_re" do
    it "matches a failure" do
      output = run_example { fail }
      expect(output).to match(Autotest::Rspec.new.failed_results_re)
      expect(output).to include(__FILE__.sub(File.expand_path('.'),'.'))
    end

    it "does not match when there are no failures" do
      output = run_example { } # pass
      expect(output).not_to match(Autotest::Rspec.new.failed_results_re)
      expect(output).not_to include(__FILE__.sub(File.expand_path('.'),'.'))
    end
  end

  context "with color enabled" do
    before do
      allow(RSpec.configuration).to receive(:color_enabled?).and_return(true)
    end

    include_examples "autotest failed_results_re"
  end

  context "with color disabled" do
    before do
      allow(RSpec.configuration).to receive(:color_enabled?).and_return(false)
    end

    include_examples "autotest failed_results_re"
  end
end
