require "nokogiri"

class TemplateValidator < ActiveModel::Validator
  @@template_rng = File.join(Tim::Engine.root, "config/schemas", "tdl.rng")

  def validate(record)
    rng = Nokogiri::XML::RelaxNG(File.read(@@template_rng))
    xml = Nokogiri::XML(record.xml) { |config| config.strict }

    rng.validate(xml).each do |error|
      record.errors.add :xml, error.message
    end
  end

end