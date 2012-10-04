require File.expand_path('../../app/models/tim/base_image', Tim::Engine.called_from)

class Tim::BaseImage #.class_eval do
  belongs_to :pool_family
#  include Tim::Concerns::Models::BaseImage
end
