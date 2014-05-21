# (c) Copyright 2006 Nick Sieger <nicksieger@gmail.com>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

$:.push(*Dir['vendor/rails/*/lib'])

require 'active_support/core_ext'
require 'autotest/rspec'

class Autotest
  class RailsRspec < Autotest::Rspec
    IGNORED_FOLDERS = %w{coverage db doc log public script tmp vendor/rails vendor/plugins vendor/gems}

    def initialize
      super
      setup_rails_rspec_mappings
    end

    def setup_rails_rspec_mappings
      IGNORED_FOLDERS.each { |exception| add_exception(/^([\.\/]*)?#{exception}/) }

      clear_mappings

      add_mapping(%r{\A(test|spec)/fixtures/(.*).yml\z}) { |_, m|
        ["spec/models/#{m[2].singularize}_spec.rb"] + files_matching(%r{\Aspec\/views\/#{m[2]}/.*_spec\.rb\z})
      }
      add_mapping(%r{\Aspec/.*_spec\.rb\z}) { |filename, _|
        filename
      }
      add_mapping(%r{\Aapp/models/(.*)\.rb\z}) { |_, m|
        ["spec/models/#{m[1]}_spec.rb"]
      }
      add_mapping(%r{\Aapp/views/(.*)\z}) { |_, m|
        files_matching %r{\Aspec/views/#{m[1]}_spec.rb\z}
      }
      add_mapping(%r{\Aapp/controllers/(.*)\.rb\z}) { |_, m|
        if m[1] == 'application'
          files_matching %r{\Aspec/controllers/.*_spec\.rb\z}
        else
          ["spec/controllers/#{m[1]}_spec.rb"]
        end
      }
      add_mapping(%r{\Aapp/helpers/(.*)_helper\.rb\z}) { |_, m|
        if m[1] == 'application'
          files_matching(%r{\Aspec/(views|helpers)/.*_spec\.rb\z})
        else
          ["spec/helpers/#{m[1]}_helper_spec.rb"] + files_matching(%r{\Aspec\/views\/#{m[1]}/.*_spec\.rb\z})
        end
      }
      add_mapping(%r{\Aconfig/routes\.rb\z}) {
        files_matching %r{\Aspec/(controllers|routing|views|helpers)/.*_spec\.rb\z}
      }
      add_mapping(%r{\Aconfig/database\.yml\z}) { |_, m|
        files_matching %r{\Aspec/models/.*_spec\.rb\z}
      }
      add_mapping(%r{\A(spec/(spec_helper|support/.*)|config/(boot|environment(s/test)?))\.rb\z}) {
        files_matching %r{\Aspec/(models|controllers|routing|views|helpers)/.*_spec\.rb\z}
      }
      add_mapping(%r{\Alib/(.*)\.rb\z}) { |_, m|
        ["spec/lib/#{m[1]}_spec.rb"]
      }
      add_mapping(%r{\Aapp/mailers/(.*)\.rb\z}) { |_, m|
        ["spec/mailers/#{m[1]}_spec.rb"]
      }
    end
  end
end
