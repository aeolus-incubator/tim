# Setup Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require File.expand_path("../../lib/image_factory/image_factory.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
Dir.glob(File.join(File.dirname(__FILE__) + "/factories/", "**", "*.rb")).each do |file|
  require file
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

# Override to_xml to use underscore rather than dash
ActiveRecord::Base.class_eval do
  def to_xml(options={})
    options[:dasherize] ||= false
    super({ :root => self.class.name.split("::").last.underscore }.merge(options))
  end
end

module RequestContentTypeHelper
  def accept_all
    @request.env["HTTP_ACCEPT"] = "*/*"
  end

  def accept_json
    @request.env["HTTP_ACCEPT"] = "application/json"
  end

  def accept_xml
    @request.env["HTTP_ACCEPT"] = "application/xml"
  end

  def send_and_accept_xml
    @request.env["HTTP_ACCEPT"] = "application/xml"
    @request.env["CONTENT_TYPE"] = "application/xml"
  end

  def send_and_accept_json
    @request.env["HTTP_ACCEPT"] = "application/json"
    @request.env["CONTENT_TYPE"] = "application/json"
  end
end

include RequestContentTypeHelper
