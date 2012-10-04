class ProviderType < ActiveRecord::Base
  has_many :target_images, :class_name => "Tim::TargetImage"
end
