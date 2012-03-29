module ImageManagement
 class BaseImage < ActiveRecord::Base
    has_many :image_versions
    belongs_to :template
  end
end