module Tim
  class ImageVersion < Tim::Base
    belongs_to :base_image
    has_many :target_images

    accepts_nested_attributes_for :base_image
    accepts_nested_attributes_for :target_images

    attr_accessible :base_image_attributes
    attr_accessible :target_images_versions_attributes
    attr_protected :id
  end
end