class PoolFamily < ActiveRecord::Base
  has_many :base_images, :class_name => "ImageManagement::BaseImage"
end