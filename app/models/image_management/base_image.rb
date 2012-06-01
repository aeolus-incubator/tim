module ImageManagement
 class BaseImage < ActiveRecord::Base
    has_many :image_versions
    belongs_to :template

    accepts_nested_attributes_for :template, :class_name => "ImageManagement::Template"
    accepts_nested_attributes_for :image_versions
  end
end