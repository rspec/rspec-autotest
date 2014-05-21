require 'rubygems'
require 'rspec/autotest'

if RUBY_PLATFORM == 'java'
  # Works around https://jira.codehaus.org/browse/JRUBY-5678
  require 'fileutils'
  ENV['TMPDIR'] = File.expand_path('../../tmp', __FILE__)
  FileUtils.mkdir_p(ENV['TMPDIR'])
end

Dir['./spec/support/**/*.rb'].map {|f| require f}

RSpec.configure do |c|
  c.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  # runtime options
  c.treat_symbols_as_metadata_keys_with_true_values = true if RSpec::Core::Version::STRING.to_f < 3
  c.filter_run :focus
  c.run_all_when_everything_filtered = true
end
