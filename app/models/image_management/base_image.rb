module ImageManagement
  class BaseImage < ImageManagement::Base
    has_many :image_versions
    belongs_to :template
    belongs_to :user, :class_name => ImageManagement.user_class

    accepts_nested_attributes_for :template
    accepts_nested_attributes_for :image_versions

    attr_accessible :template, :name, :description
    attr_accessible :template_attributes
    attr_accessible :image_versions_attributes, :as => :admin
    attr_protected :id
  end
end