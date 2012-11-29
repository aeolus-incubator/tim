module Tim
  class ImageVersion < Tim::Base
    belongs_to :base_image, :inverse_of => :image_versions
    has_many :target_images, :inverse_of => :image_version

    accepts_nested_attributes_for :base_image
    accepts_nested_attributes_for :target_images

    validates_presence_of :base_image

    attr_accessible :base_image_attributes
    attr_accessible :target_images_versions_attributes
    attr_protected :id
  end
end