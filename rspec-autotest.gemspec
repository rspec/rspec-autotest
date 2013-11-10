# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/autotest/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-autotest"
  spec.version       = RSpec::Autotest::VERSION
  spec.authors       = ["Steven Baker", "David Chelimsky", "Chad Humphries"]
  spec.email         = "rspec-users@rubyforge.org"
  spec.homepage      = "https://github.com/rspec/rspec-autotest"
  spec.summary       = "rspec-autotest-#{RSpec::Autotest::VERSION}"
  spec.description   = "RSpec Autotest integration"
  spec.license       = "MIT"

  spec.rubyforge_project  = "rspec"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(spec|features)/})
  spec.rdoc_options  = ["--charset=UTF-8"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_dependency "rspec-core", ">= 2.99.0.beta1", "< 4.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake",    "~> 10.0.0"
  spec.add_development_dependency "aruba",   "~> 0.5"
  spec.add_development_dependency "ZenTest", "~> 4.6"

end
