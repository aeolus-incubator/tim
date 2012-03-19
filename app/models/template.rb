class Template < ActiveRecord::Base
  has_one :base_image
  has_one :target_image
end