module ImageManagement
  class Template < ImageManagement::Base
    has_many :base_images

    accepts_nested_attributes_for :base_images

    attr_accessible :base_images_attributes
    attr_accessible :xml
    attr_protected :id

    # TODO Add validation to check template conforms to factory TDL schema
  end
end