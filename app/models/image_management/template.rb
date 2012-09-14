module ImageManagement
  class Template < ActiveRecord::Base
#    attr_accessor :xml
    attr_accessible :xml
    has_one :base_image
    has_one :target_image
  end
end
