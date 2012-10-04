class User < ActiveRecord::Base
  has_many :base_images, :class_name => "Tim::BaseImage"
end
