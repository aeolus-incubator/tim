module ImageManagement
 class BaseImage < ActiveRecord::Base
   attr_accessor :template
   attr_accessible :template_attributes, :as => :admin #, :image_versions_attributes
   has_many :image_versions
   belongs_to :template
   belongs_to :user, :class_name => ImageManagement.user_class

   accepts_nested_attributes_for :template
   accepts_nested_attributes_for :image_versions
  end
end
