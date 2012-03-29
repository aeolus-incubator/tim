module ImageManagement
  class ProviderImage < ActiveRecord::Base
    belongs_to :target_image
  end
end