class ProviderAccount < ActiveRecord::Base
  has_many :provider_images, :class_name => "ImageManagement::ProviderImage"
end