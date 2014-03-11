require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera-puppet-helper'

HERE = File.expand_path(File.dirname(__FILE__))
fixture_path = File.join(HERE, 'spec', 'fixtures')

RSpec.configure do |config|
  config.module_path  = "."
  config.manifest     = File.join(fixture_path, 'manifests')
end

