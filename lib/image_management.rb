require "image_management/engine"
require "image_factory/image_factory.rb"

module ImageManagement
  mattr_accessor :user_class
  mattr_accessor :provider_account_class
  mattr_accessor :provider_type_class
end
