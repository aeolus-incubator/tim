require "nokogiri"

module Tim
  class Template < Tim::Base
    include ActiveModel::Validations
    validates_with TemplateValidator

    has_many :base_images

    accepts_nested_attributes_for :base_images

    attr_accessible :base_images_attributes
    attr_accessible :xml
    attr_protected :id

    # Used in views to display the xml elements of this template
    def xml_elements
      ::Nokogiri::XML::Document.parse(xml).xpath("//template/*").to_xml
    end

  end
end