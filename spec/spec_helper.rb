require 'rubygems'
require 'rspec/autorun'
require 'rspec/autotest'
require 'aruba/api'

unless ENV['NO_COVERALLS']
  require 'simplecov' if RUBY_VERSION.to_f > 1.8
  require 'coveralls'
  Coveralls.wear! do
    add_filter '/bundle/'
    add_filter '/spec/'
    add_filter '/tmp/'
  end
end

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
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run :focus
  c.run_all_when_everything_filtered = true
end
