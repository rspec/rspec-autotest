# coding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'rspec/autotest/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-autotest'
  spec.version       = RSpec::Autotest::VERSION
  spec.authors       = ['Steven Baker', 'David Chelimsky', 'Chad Humphries']
  spec.email         = 'rspec-users@rubyforge.org'
  spec.homepage      = 'https://github.com/rspec/rspec-autotest'
  spec.summary       = "rspec-autotest-#{spec.version}"
  spec.description   = 'RSpec Autotest integration'
  spec.license       = 'MIT'

  spec.metadata = {
    'bug_tracker_uri'   => 'https://github.com/rspec/rspec-autotest/issues',
    'changelog_uri'     => "https://github.com/rspec/rspec-autotest/blob/v#{spec.version}/Changelog.md",
    'documentation_uri' => 'https://rspec.info/documentation/',
    'mailing_list_uri'  => 'https://groups.google.com/forum/#!forum/rspec',
    'source_code_uri'   => 'https://github.com/rspec/rspec-autotest',
  }

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.rdoc_options  = ['--charset=UTF-8']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_dependency 'rspec-core', '>= 2.99.0.beta1', '< 4.0.0'

  spec.add_development_dependency 'bundler',        '>= 1.3'
  if RUBY_VERSION.to_f < 2.0
    spec.add_development_dependency 'rake',           '~> 10.0'
    spec.add_development_dependency 'activesupport',  '~> 3.0'
  else
    spec.add_development_dependency 'rake',           '>= 10.0.0'
    spec.add_development_dependency 'activesupport',  '~> 4.1', '>= 4.1.11'
  end
  spec.add_development_dependency 'ZenTest',        '>= 4.6'
end
