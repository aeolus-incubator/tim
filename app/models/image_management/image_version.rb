module ImageManagement
  class ImageVersion < ActiveRecord::Base
    belongs_to :base_image
    has_many :target_images

    accepts_nested_attributes_for :base_image, :class_name => "ImageManagement::BaseImage"
  end
end