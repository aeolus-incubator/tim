module ImageManagement
  class ImageVersion < ActiveRecord::Base
    # attr_accessible :title, :body
    belongs_to :base_image
    has_many :target_images

#    accepts_nested_attributes_for :base_image
  end
end
