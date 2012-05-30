# Setup Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require File.expand_path("../../lib/image_factory/image_factory.rb",  __FILE__)
require 'rspec'
require 'factory_girl'

Dir.glob(File.dirname(__FILE__) + "/factories/*/*").each do |factory|
  require factory
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end