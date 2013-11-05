# rspec-autotest [![Build Status](https://secure.travis-ci.org/rspec/rspec-autotest.png?branch=master)](http://travis-ci.org/rspec/rspec-autotest) [![Code Climate](https://codeclimate.com/github/rspec/rspec-autotest.png)](https://codeclimate.com/github/rspec/rspec-autotest) [![Coverage Status](https://coveralls.io/repos/rspec/rspec-autotest/badge.png?branch=master)](https://coveralls.io/r/rspec/rspec-autotest?branch=master)

rspec-autotest provides integration between autotest and RSpec

## Usage

RSpec ships with a specialized subclass of Autotest. To use it, just add a
`.rspec` file to your project's root directory, and run the `autotest` command
as normal:

    $ autotest

## Bundler

The `autotest` command generates a shell command that runs your specs. If you
are using Bundler, and you want the shell command to include `bundle exec`,
require the Autotest bundler plugin in a `.autotest` file in the project's root
directory or your home directory:

    # in .autotest
    require "autotest/bundler"

## Rails

To use RSpec and Rails with autotest, bring in the `autotest-rails` gem:

```ruby
# Gemfile
gem 'autotest-rails', :group => [:development, :test]
```

`autotest` will now autodetect RSpec and Rails after you run the `rails
generate rspec:install` command.

## Gotchas

### Invalid Option: --tty

The `--tty` option was [added in rspec-core-2.2.1](changelog), and is used
internally by RSpec. If you see an error citing it as an invalid option, you'll
probably see there are two or more versions of rspec-core in the backtrace: one
< 2.2.1 and one >= 2.2.1.

This usually happens because you have a newer rspec-core installed, and an
older rspec-core specified in a Bundler Gemfile. If this is the case, you can:

1. specify the newer version in the Gemfile (recommended)
2. prefix the `autotest` command with `bundle exec`


## Installation

Add this line to your application's Gemfile:

    gem 'rspec-autotest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-autotest

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
