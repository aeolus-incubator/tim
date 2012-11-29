module Tim
  class BaseImage < Tim::Base
    has_many :image_versions, :inverse_of => :base_image
    belongs_to :template, :inverse_of => :base_images

    belongs_to :user, :class_name => Tim.user_class

    accepts_nested_attributes_for :template
    accepts_nested_attributes_for :image_versions

    attr_accessible :template, :name, :description, :import
    attr_accessible :template_attributes
    attr_accessible :image_versions_attributes, :as => :admin
    attr_protected :id
  end
end