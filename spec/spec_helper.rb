# Setup Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require File.expand_path("../../lib/image_factory/image_factory.rb",  __FILE__)
require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
