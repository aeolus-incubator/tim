require "nokogiri"

module Tim
  class Template < Tim::Base
    include ActiveModel::Validations
    validates_with TemplateValidator

    has_many :base_images, :inverse_of => :template

    attr_accessible :xml
    attr_protected :id

    # Used in views to display the xml elements of this template
    def xml_elements
      ::Nokogiri::XML::Document.parse(xml).xpath("//template/*").to_xml
    end

  end
end