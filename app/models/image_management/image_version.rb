module ImageManagement
  class ImageVersion < ActiveRecord::Base
    belongs_to :base_image
    has_many :target_images
    belongs_to :template
  end
end